#!/usr/bin/env python3
# /// script
# requires-python = ">=3.10"
# dependencies = ["duckdb>=1.1", "pyarrow>=17", "requests>=2"]
# ///
"""MaleCNS connectome toolkit — DuckDB-driven, minimal footprint.

Data source: https://male-cns.janelia.org/ (CC-BY, Janelia FlyEM).
Tables are stored as Arrow Feather on GCS; we stream-convert to Parquet so
DuckDB can query them with bounded memory (spills to disk, never loads whole
tables). neuprint API is called over plain REST (no pandas stack).

Usage:
  uv run tools/malecns.py list                          # show datasets + sync state
  uv run tools/malecns.py sync [NAME...]                # default: annotations neurotransmitters
  uv run tools/malecns.py sql "SELECT ..."              # DuckDB over synced parquet
  uv run tools/malecns.py api "MATCH (n:Neuron {type:'DNge104'})-[c:ConnectsTo]->(m)
                                 RETURN m.type AS target, c.weight AS w
                                 ORDER BY w DESC LIMIT 10"
  uv run tools/malecns.py api "..." --sql "SELECT target, sum(w) w FROM q GROUP BY 1 ORDER BY w DESC"

Env:
  NEUPRINT_TOKEN  — API token from neuprint.janelia.org (api mode)
  MALECNS_DIR     — data dir (default ~/.local/share/malecns)
"""

import argparse
import json
import os
import shutil
import sys
import tempfile
from pathlib import Path

import requests

BASE = "https://storage.googleapis.com/flyem-male-cns/v1.0/connectome-data/flat-connectome"
NEUPRINT = "https://neuprint.janelia.org"
DATASET = "male-cns:v1.0"

# name -> (feather file, approx size)
TABLES = {
    "annotations": ("body-annotations-male-cns-v1.0-minconf-0.5.feather", "13 MB"),
    "neurotransmitters": ("body-neurotransmitters-male-cns-v1.0.feather", "42 MB"),
    "body-stats": ("body-stats-male-cns-v1.0-minconf-0.5.feather", "780 MB"),
    "weights": ("connectome-weights-male-cns-v1.0-minconf-0.5.feather", "1.1 GB"),
    "syn-partners": ("syn-partners-male-cns-v1.0-minconf-0.5.feather", "6.8 GB"),
    "syn-points": ("syn-points-male-cns-v1.0-minconf-0.5.feather", "12.7 GB"),
    "tbar-nt": ("tbar-neurotransmitters-male-cns-v1.0.feather", "2.7 GB"),
}
DEFAULT_SYNC = ["annotations", "neurotransmitters"]


def data_dir() -> Path:
    d = Path(os.environ.get("MALECNS_DIR", "~/.local/share/malecns")).expanduser()
    d.mkdir(parents=True, exist_ok=True)
    return d


def duck(memory_limit: str):
    import duckdb

    con = duckdb.connect()
    con.execute(f"SET memory_limit='{memory_limit}'")
    con.execute("SET threads=2")
    con.execute(f"SET temp_directory='{data_dir() / 'tmp'}'")
    # Attach every synced parquet as a view.
    for name in TABLES:
        pq = data_dir() / f"{name}.parquet"
        if pq.exists():
            con.execute(
                f"CREATE OR REPLACE VIEW {name} AS SELECT * FROM read_parquet('{pq}')"
            )
    return con


def cmd_list(_):
    for name, (_, size) in TABLES.items():
        state = "synced" if (data_dir() / f"{name}.parquet").exists() else "-"
        print(f"{name:20s} {size:>8s}  {state}")


def sync_one(name: str):
    import pyarrow as pa
    import pyarrow.parquet as pq

    feather, _ = TABLES[name]
    url = f"{BASE}/{feather}"
    out = data_dir() / f"{name}.parquet"
    if out.exists():
        print(f"{name}: already synced -> {out}")
        return

    print(f"{name}: downloading {feather} ...")
    tmp_path = data_dir() / f"{name}.feather.part"
    # Resume-capable download: Range requests against GCS; single connections
    # degrade to ~1KB/s, so short timeouts force reconnects (fresh = fast).
    for attempt in range(20):
        try:
            pos = tmp_path.stat().st_size if tmp_path.exists() else 0
            headers = {"Range": f"bytes={pos}-"} if pos else {}
            with requests.get(url, stream=True, timeout=(30, 30), headers=headers) as resp:
                if resp.status_code == 416:  # already complete
                    break
                resp.raise_for_status()
                if resp.status_code != 206 and pos:  # server ignored Range, restart
                    pos = 0
                    tmp_path.unlink()
                mode = "ab" if pos else "wb"
                with open(tmp_path, mode) as f:
                    for chunk in resp.iter_content(chunk_size=8 << 20):
                        f.write(chunk)
            break
        except (requests.RequestException, OSError) as e:
            if attempt == 19:
                raise
            print(f"  retry {attempt + 1}/19 after error: {e}")

    # Stream feather -> parquet one batch at a time (bounded RAM).
    try:
        reader = pa.ipc.open_file(tmp_path)
        schema = reader.schema
        with pq.ParquetWriter(out, schema) as writer:
            for i in range(reader.num_record_batches):
                writer.write_batch(reader.get_batch(i))
    finally:
        os.unlink(tmp_path)
    print(f"{name}: -> {out} ({out.stat().st_size >> 20} MB)")

def cmd_sync(args):
    names = args.names or DEFAULT_SYNC
    for name in names:
        if name not in TABLES:
            sys.exit(f"unknown table {name!r}; choices: {', '.join(TABLES)}")
        sync_one(name)


def cmd_sql(args):
    con = duck(args.mem)
    rows = con.execute(args.query).fetchall()
    cols = [d[0] for d in con.description]
    print("\t".join(cols))
    for row in rows:
        print("\t".join(str(v) for v in row))


def neuprint_query(cypher: str) -> tuple[list[str], list[dict]]:
    token = os.environ.get("NEUPRINT_TOKEN")
    if not token:
        sys.exit("set NEUPRINT_TOKEN (from neuprint.janelia.org account page)")
    payload = {"cypher": cypher, "dataset": DATASET}
    r = requests.post(
        f"{NEUPRINT}/api/readqueries", json=payload, timeout=120,
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
    )
    r.raise_for_status()
    body = r.json()
    cols = body["columns"]
    keys = body.get("keys") or cols
    rows = [dict(zip(keys, row)) for row in body["data"]]
    return cols, rows


def cmd_api(args):
    import pyarrow as pa

    cols, rows = neuprint_query(args.cypher)
    print(f"api: {len(rows)} rows")
    con = duck(args.mem)
    if rows:
        table = pa.Table.from_pylist(rows)
        con.register("q", table)
        if args.sql:
            rows = con.execute(args.sql).fetchall()
            cols = [d[0] for d in con.description]
            print("\t".join(cols))
            for row in rows:
                print("\t".join(str(v) for v in row))
        else:
            print("\t".join(cols))
            for row in rows[:50]:
                print("\t".join(str(v) for v in row.values()))


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = p.add_subparsers(dest="cmd", required=True)

    sub.add_parser("list", help="show datasets and sync state")

    s = sub.add_parser("sync", help="download + convert tables to parquet")
    s.add_argument("names", nargs="*", help=f"tables (default: {' '.join(DEFAULT_SYNC)})")

    s = sub.add_parser("sql", help="run SQL over synced parquet")
    s.add_argument("query")
    s.add_argument("--mem", default="512MB", help="duckdb memory limit (default 512MB)")

    s = sub.add_parser("api", help="run neuprint cypher (optionally post-process in DuckDB)")
    s.add_argument("cypher")
    s.add_argument("--sql", help="DuckDB SQL over the API result (table name: q)")
    s.add_argument("--mem", default="512MB", help="duckdb memory limit (default 512MB)")

    args = p.parse_args()
    {"list": cmd_list, "sync": cmd_sync, "sql": cmd_sql, "api": cmd_api}[args.cmd](args)


if __name__ == "__main__":
    main()

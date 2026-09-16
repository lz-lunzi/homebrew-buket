# tools/malecns.py — MaleCNS connectome, DuckDB-driven

Minimal-footprint toolkit for the Janelia Male CNS connectome
(https://male-cns.janelia.org/, CC-BY). Tables stream-convert to Parquet;
all queries run through DuckDB with a 512 MB memory cap and disk spill.

## Usage

```bash
uv run tools/malecns.py list                     # tables + sync state
uv run tools/malecns.py sync                     # small tables (55 MB)
uv run tools/malecns.py sync weights syn-partners # pick tables
uv run tools/malecns.py sql "SELECT class, count(*) FROM annotations GROUP BY 1 ORDER BY 2 DESC"
```

neuprint API mode (register at https://neuprint.janelia.org, grab token):

```bash
export NEUPRINT_TOKEN=...
uv run tools/malecns.py api "MATCH (n:Neuron {type:'DNge104'})-[c:ConnectsTo]->(m)
                              RETURN m.type AS target, c.weight AS w ORDER BY w DESC LIMIT 10"
uv run tools/malecns.py api "..." --sql "SELECT target, sum(w) FROM q GROUP BY 1"
```

## Resource profile

 - SQL mode: measured peak RSS **78 MB** on a 210k×1.7M-row JOIN; hard cap 512 MB
   (DuckDB limit + disk spill to data dir), 2 threads
 - sync: peak RAM ≈ one Arrow record batch; downloads resume on flaky links
   (GCS throttles idle connections to ~1 KB/s; short timeouts force reconnects)
 - Data dir: `~/.local/share/malecns` (override with `MALECNS_DIR`)
 - uv users with a corrupted `~/.cache/uv` (root-owned): `export UV_CACHE_DIR=/tmp/uvcache`

## Schema gotchas

 - Join key: `annotations.bodyId` = `neurotransmitters.body` (not `bodyId`)
 - NT columns: `predicted_nt`, `consensus_nt` (in `neurotransmitters`)

## Table sizes (feather source → parquet on disk)

| table | source | notes |
|---|---|---|
| annotations | 13 MB | 211,577 neurons, full schema |
| neurotransmitters | 42 MB | per-body consensus NT predictions |
| body-stats | 780 MB | synapse counts per body |
| weights | 1.1 GB | full connection graph (segment→segment) |
| syn-partners | 6.8 GB | synaptic partner pairs |
| syn-points | 12.7 GB | every pre/post synapse location |
| tbar-nt | 2.7 GB | per-T-bar NT probabilities |

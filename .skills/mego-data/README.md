---
name: mego-data-access
description: Access and analyze MEGO hand-object interaction dataset from Aliyun OSS
tags: [data, mego, hand-object, rclone, oss]
---

# MEGO Data Skill

Access and work with MEGO (hand-object interaction) dataset stored in Aliyun OSS via rclone.

## Dataset Overview

**Location:** `tos:genie-data-base-mego/prod/mego-hive/mego/`

**Structure:**
```
mego/
├── raw/               Raw sensor data + metadata
│   ├── {task_uuid}/
│   │   └── {episode_uuid}/
│   │       └── head_{task_uuid}/
│   │           └── {timestamp}/
│   │               ├── record/          Raw video & IMU
│   │               ├── audio/           Audio files
│   │               ├── meta_info.json   Session metadata
│   │               └── parameters/      Recording parameters
├── qc/                Quality control results
│   ├── {task_uuid}/
│   │   └── {episode_uuid}/
│   │       ├── {uuid}_preview.mp4       Montage preview video
│   │       ├── qc_result.json           Detailed QC labels
│   │       ├── payment.json             Duration & validity
│   │       └── failed_examples/         Sample failure frames
└── clips/             Extracted video clips
    ├── {task_uuid}/
    │   └── {episode_uuid}/
    │       ├── clip-N/
    │       │   ├── audio/
    │       │   ├── camera/
    │       │   ├── labels/
    │       │   ├── log/
    │       │   ├── meta_info.json
    │       │   ├── parameters/
    │       │   └── record/
```

## Key Data Files

### payment.json
Duration validation summary:
```json
{
  "duration_ms": 836510,
  "valid_duration_ms": 722635,
  "comment": "有效率86.39%；无效时长113.875秒..."
}
```

### qc_result.json
Detailed quality assessment with schema `mego-big-video-qc/v1`:
- **Meta:** task_uuid, episode_uuid, created_at, sampling params
- **Summary:** session_count, inference_request_count, quality_counts
- **Sessions:** per-video analysis
  - Montages: 6-frame clips sampled every 5sec
  - Labels per frame:
    - `quality`: PASS | NO_OBJECT_INTERACTION | OUT_OF_FRAME
    - Hand/object info: visibility, interaction type, scene level
    - Attributes: object_category, operation_context, active_hand
    - Bounding boxes: hand_bboxes (normalized coords)

### meta_info.json (raw)
Sensor metadata:
- robot_type, task_type, version
- Camera list: head_stereo_left/right, head_fisheye, etc.
- Camera FPS, IMU/audio sensors
- Calibration info

## Usage

### Setup
```bash
# Configure rclone (one-time)
rclone config
# Remote: tos
# Type: s3
# Provider: Other
# Endpoint: https://oss-cn-shanghai.aliyuncs.com (public)
# Access key / Secret: from credentials

# Or write directly to ~/.config/rclone/rclone.conf
[tos]
type = s3
provider = Other
access_key_id = <KEY>
secret_access_key = <SECRET>
endpoint = https://oss-cn-shanghai.aliyuncs.com
force_path_style = false
no_check_bucket = true
env_auth = false
disable_http2 = true
list_version = 2
```

### List available tasks
```bash
rclone lsd "tos:genie-data-base-mego/prod/mego-hive/mego/raw" --max-depth 1
```

### Inspect QC results
```bash
# List all QC records
rclone lsf "tos:genie-data-base-mego/prod/mego-hive/mego/qc" --max-depth 2

# Read QC labels for episode
rclone cat "tos:genie-data-base-mego/prod/mego-hive/mego/qc/{task_uuid}/{episode_uuid}/qc_result.json" \
  | python3 -m json.tool
```

### Download raw data
```bash
# Sync local copy (full task)
rclone sync "tos:genie-data-base-mego/prod/mego-hive/mego/raw/{task_uuid}" ./mego_raw/

# Download specific file
rclone cat "tos:genie-data-base-mego/prod/mego-hive/mego/raw/{task_uuid}/{episode_uuid}/head_{task_uuid}/{timestamp}/meta_info.json" > meta.json
```

### Extract video clips
```bash
# List clips for task
rclone lsf "tos:genie-data-base-mego/prod/mego-hive/mego/clips/{task_uuid}/{episode_uuid}"

# Download clip with metadata
rclone sync "tos:genie-data-base-mego/prod/mego-hive/mego/clips/{task_uuid}/{episode_uuid}/{clip_id}" ./clip/
```

## Network Notes

- **Public endpoint:** `oss-cn-shanghai.aliyuncs.com` (external access)
- **Internal endpoint:** `oss-cn-shanghai-internal.aliyuncs.com` (Aliyun VPC only, not accessible externally)
- Current config uses public endpoint for broad access

## Data Stats

Example task structure:
- Raw video: 1-11 MB per frame montage
- QC metadata: 50-600 KB per episode
- Clips: segmented with audio, camera, labels, parameters
- ~50 sample episodes currently in prod

## Credentials

Keep `~/.config/rclone/rclone.conf` secure; rclone reads it for auth.
Access key & secret rotate per Aliyun policies.

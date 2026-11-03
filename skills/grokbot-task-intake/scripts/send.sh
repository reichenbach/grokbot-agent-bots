#!/usr/bin/env bash
# Send one task to a Grok Bot webhook routine. Reads GROKBOT_WEBHOOK_URL and
# GROKBOT_WEBHOOK_KEY from the environment. Never prints the key.
set -euo pipefail

usage() {
  echo "usage: send.sh --source claude|cursor|codex --type \"<task type>\" --details \"<text>\" [--dry-run]" >&2
  exit 2
}

source_name=""; task_type=""; details=""; dry=0
while [ $# -gt 0 ]; do
  case "$1" in
    --source) source_name="${2:-}"; shift 2 ;;
    --type) task_type="${2:-}"; shift 2 ;;
    --details) details="${2:-}"; shift 2 ;;
    --dry-run) dry=1; shift ;;
    *) usage ;;
  esac
done
[ -n "$source_name" ] && [ -n "$task_type" ] && [ -n "$details" ] || usage

case "$source_name" in claude|cursor|codex) ;; *) echo "source must be claude, cursor or codex" >&2; exit 2 ;; esac
case "$task_type" in
  "LinkedIn profile edit"|"draft a social post"|"update a project status") ;;
  *) echo "task type not allowed: $task_type" >&2; exit 2 ;;
esac
if [ "${#details}" -gt 4000 ]; then echo "details too long (max 4000 chars)" >&2; exit 2; fi

request_id="$(python3 -c 'import time,secrets;print(time.strftime("%Y%m%dT%H%M%S")+"-"+secrets.token_hex(3))')"

payload="$(TT="$task_type" RID="$request_id" SRC="$source_name" DET="$details" python3 -c '
import json, os
print(json.dumps({"task_type": os.environ["TT"], "request_id": os.environ["RID"],
                  "source": os.environ["SRC"], "details": os.environ["DET"]}))')"

if [ "$dry" -eq 1 ]; then
  echo "$payload"
  exit 0
fi

: "${GROKBOT_WEBHOOK_URL:?set GROKBOT_WEBHOOK_URL}"
: "${GROKBOT_WEBHOOK_KEY:?set GROKBOT_WEBHOOK_KEY}"
header="${GROKBOT_WEBHOOK_AUTH_HEADER:-Authorization: Bearer {KEY}}"
header="${header//\{KEY\}/$GROKBOT_WEBHOOK_KEY}"

# The header goes through stdin config so the key never appears in the process list.
status="$(printf 'header = "%s"\n' "$header" | curl -sS --config - \
  -X POST "$GROKBOT_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  --data "$payload" \
  --max-time 30 -o /dev/null -w '%{http_code}')"

if [ "$status" -ge 200 ] && [ "$status" -lt 300 ]; then
  echo "accepted (HTTP $status), request_id=$request_id. Result will appear in the Grok Bot chat."
else
  echo "rejected (HTTP $status), request_id=$request_id" >&2
  exit 1
fi

#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: replace_audio.sh --video <video_file> --audio <audio_file> --output <output_file>

Options:
  --video    Original video file path
  --audio    New audio file path (WAV/MP3)
  --output   Final output video file path
EOF
  exit "${1:-0}"
}

VIDEO=""
AUDIO=""
OUTPUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --video)  VIDEO="$2"; shift 2 ;;
    --audio)  AUDIO="$2"; shift 2 ;;
    --output) OUTPUT="$2"; shift 2 ;;
    -h|--help) usage 0 ;;
    *) echo "Unknown option: $1"; usage 1 ;;
  esac
done

if [[ -z "$VIDEO" || -z "$AUDIO" || -z "$OUTPUT" ]]; then
  echo "Error: --video, --audio, and --output are all required." >&2
  usage 1
fi

if [[ ! -f "$VIDEO" ]]; then
  echo "Error: Video file not found: $VIDEO" >&2
  exit 1
fi

if [[ ! -f "$AUDIO" ]]; then
  echo "Error: Audio file not found: $AUDIO" >&2
  exit 1
fi

# Use ffmpeg to replace the audio track
# -map 0:v : take video from the first input
# -map 1:a : take audio from the second input
# -c:v copy : copy video codec without re-encoding
# -c:a aac : encode audio to AAC (standard for MP4)
# -shortest : end output when the shortest input ends
echo "Replacing audio in $VIDEO with $AUDIO -> $OUTPUT"
ffmpeg -y -i "$VIDEO" -i "$AUDIO" \
  -map 0:v:0 -map 1:a:0 \
  -c:v copy -c:a aac -b:a 192k \
  -shortest \
  "$OUTPUT"

echo "Done! Output saved to $OUTPUT"

#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_video.mp4>"
    exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found."
    exit 1
fi

if ! command -v ffmpeg &> /dev/null || ! command -v whisper &> /dev/null; then
    echo "Error: Missing dependencies. Ensure FFmpeg and Whisper are installed."
    exit 1
fi

BASENAME=$(basename "$INPUT_FILE" .mp4)
DIRNAME=$(dirname "$INPUT_FILE")
TEMP_AUDIO="${DIRNAME}/${BASENAME}.wav"

echo "Extracting audio track..."
ffmpeg -y -i "$INPUT_FILE" -ar 16000 -ac 1 -c:a pcm_s16le "$TEMP_AUDIO" -loglevel error

if [ ! -f "$TEMP_AUDIO" ]; then
    echo "Error: Audio extraction failed."
    exit 1
fi

echo "Starting Whisper transcription..."
whisper "$TEMP_AUDIO" --model base --output_format txt --language en

rm -f "$TEMP_AUDIO"
rm -f "$INPUT_FILE"

echo "Success! Transcription saved as ${BASENAME}.txt"
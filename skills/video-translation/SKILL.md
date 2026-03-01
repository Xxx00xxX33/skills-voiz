---
name: video-translation
description: Translate and dub videos from one language to another, replacing the original audio with TTS while keeping the video intact.
---

# Video Translation

Translate a video's speech into another language, using TTS to generate the dubbed audio and replacing the original audio track.

## Triggers

- translate this video
- dub this video to English
- 把视频从 X 语译成 Y 语
- 视频翻译

## Use Cases

- The user wants to watch a foreign language YouTube video but prefers to hear it in their native language.
- The user provides a video link and explicitly requests changing the audio language.

## Workflow

When the user asks to translate a video:

1. **Download Video & Subtitles**:
   Use the `youtube-downloader` skill to download the video and its subtitles as SRT. Make sure you specify the source language to fetch the correct subtitle.
   ```bash
   python path/to/youtube-downloader/scripts/download_video.py "VIDEO_URL" --subtitles --sub-lang <source_lang_code> -o /tmp/video-translation
   ```

2. **Translate Subtitles**:
   Read the downloaded `.srt` file. Translate its contents sentence by sentence into the target language using the following fixed prompt. Keep the exact same SRT index and timestamp format!

   **Translation Prompt**:
   > Translate the following subtitle text from <Source Language> to <Target Language>.
   > Provide ONLY the translated text. Do not explain, do not add notes, do not add index numbers.
   > The translation must be colloquial, natural-sounding, and suitable for video dubbing.

   Save the translated text into a new file `translated.srt`.

3. **Generate Dubbed Audio**:
   Use the `tts` skill to render the timeline-accurate audio from the translated SRT.
   Create a `voice_map.json`:
   ```json
   {
     "default": {
       "voice_id": "voice_123",  // Or let the Noiz backend auto-select
       "target_lang": "<target_lang_code>"
     }
   }
   ```
   Render audio:
   ```bash
   bash skills/tts/scripts/tts.sh render --srt translated.srt --voice-map voice_map.json --backend noiz --auto-emotion -o dubbed.wav
   ```

4. **Replace Audio in Video**:
   Use the `replace_audio.sh` script to merge the original video with the new dubbed audio.
   ```bash
   bash skills/video-translation/scripts/replace_audio.sh --video original_video.mp4 --audio dubbed.wav --output final_video.mp4
   ```

5. **Present the Result**:
   Return the `final_video.mp4` file path to the user.

## Inputs

- **Required inputs**:
  - `VIDEO_URL`: The URL of the video to translate.
  - `target_language`: The language to translate the audio to.
- **Optional inputs**:
  - `source_language`: The language of the original video (if not auto-detected or specified).
  - `voice_id`: Specific TTS voice ID to use for dubbing.

## Outputs

- Success: Path to the final video file with replaced audio.
- Failure: Clear error message specifying whether download, TTS, or audio replacement failed.

## Requirements

- `youtube-downloader` skill (from crazynomad/skills) must be installed and accessible.
- `tts` skill from this project.
- `NOIZ_API_KEY` configured (`bash skills/tts/scripts/tts.sh config --set-api-key YOUR_KEY`).
- `ffmpeg` installed.

## Limitations

- The source video must have subtitles (or auto-generated subtitles) available on the platform for the source language.
- Very long videos may take a significant amount of time to translate and dub.

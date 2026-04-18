---
name: sound-fx
description: "Use this skill whenever the user wants to generate sound effects, ambient audio, or short audio clips from a text description. Triggers include: any mention of 'sound effect', 'sfx', 'generate sound', 'make a sound', 'audio effect', 'ambient sound', 'foley', 'sound clip', 'noise', or requests to produce a specific sound (e.g. 'make a gunshot sound', 'generate thunder', 'create the sound of rain'). Also use when the user describes an action or scenario and wants the corresponding audio (e.g. 'someone getting spanked', 'a door slamming', 'cartoon boing'). Do NOT use for speech synthesis, music generation with melody/lyrics, or voice cloning."
permissions:
  - network
  - filesystem
metadata: {"openclaw": {"primaryEnv": "NOIZ_API_KEY"}}
---

# sound-fx

Generate any sound effect from a text description — footsteps, explosions, cartoon boings, ambient rain, or whatever you can imagine.

## Triggers

- sound effect / sfx / foley
- generate sound / make a sound / create audio
- ambient sound / background noise
- what does X sound like / make the sound of X
- 音效 / 声音 / 音频效果

## Quick Start

```bash
# Generate a 5-second sound effect
python3 skills/sound-fx/scripts/sfx.py "a cat knocking things off a table"

# Specify duration (1-30 seconds)
python3 skills/sound-fx/scripts/sfx.py "heavy rain on a tin roof" --duration 10 -o rain.wav

# Funny / expressive examples
python3 skills/sound-fx/scripts/sfx.py "cartoon character getting spanked, exaggerated yelp" --duration 3
python3 skills/sound-fx/scripts/sfx.py "dramatic anime nosebleed sound effect" --duration 2
python3 skills/sound-fx/scripts/sfx.py "someone slipping on a banana peel, cartoon slide and thud" --duration 3
python3 skills/sound-fx/scripts/sfx.py "evil villain laugh echoing in a dungeon" --duration 5
python3 skills/sound-fx/scripts/sfx.py "notification sound for receiving a love letter" --duration 2
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `prompt` | required | Text description of the sound to generate |
| `--duration` / `-d` | auto | Length in seconds (1–30). Omit to let the model decide. |
| `--format` / `-f` | `wav` | Output format: `wav`, `mp3`, `flac` |
| `--output` / `-o` | `output.wav` | Path to save the generated audio |
| `--api-key` | from env/config | Noiz API key (overrides stored key) |

## Configuration

```bash
# Save your API key once
python3 skills/sound-fx/scripts/sfx.py config --set-api-key YOUR_KEY

# Or set via environment variable
export NOIZ_API_KEY=YOUR_KEY
```

Get your API key at [developers.noiz.ai](https://developers.noiz.ai/api-keys).

## Fun Example Prompts

| Prompt | Suggested Duration |
|--------|--------------------|
| `"cartoon character getting spanked, exaggerated squeaky yelp"` | 2–3s |
| `"dramatic fail horn (wah wah wah)"` | 3s |
| `"anime power-up charging sound"` | 5s |
| `"someone aggressively typing on a mechanical keyboard"` | 5s |
| `"dramatic chipmunk stare — suspenseful strings"` | 3s |
| `"rubber duck squeak in a bathroom"` | 1s |
| `"monster truck engine revving"` | 5s |
| `"spaceship laser blaster"` | 2s |
| `"crowd gasping in disbelief"` | 3s |
| `"old dial-up modem connecting"` | 10s |
| `"a notification sound that sounds passive-aggressive"` | 2s |
| `"thunder clap with heavy rain on a metal roof"` | 10s |
| `"coffee machine brewing and steam hissing"` | 8s |

## Output

On success, the audio file is saved to the output path and the URL is printed:

```
✓ Saved to output.wav (3.2s, 282 KB)
  URL: https://storage.googleapis.com/...
```

## Requirements

- Python 3.6+
- `requests` package: `pip install requests`
- Noiz API key from [developers.noiz.ai](https://developers.noiz.ai/api-keys)

## Security & Data Disclosure

- **API key**: Stored in `~/.config/noiz/api_key` (permissions `0600`) or via `NOIZ_API_KEY` env variable.
- **Network**: The text prompt is sent to `https://noiz.ai/v1/text-to-sound` for generation. No other data is transmitted.
- **Output**: Generated audio is downloaded from a Noiz GCS URL and saved locally.

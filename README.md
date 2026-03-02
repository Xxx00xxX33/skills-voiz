# Unmute your intelligent bot

English | [简体中文](./README.zh-CN.md)

Central repository for managing Skills to "human" vibe-talking.

## Install with `npx skills add`

```bash
# List skills from GitHub repository
npx skills add NoizAI/skills --list --full-depth

# Install a specific skill from GitHub repository
npx skills add NoizAI/skills --full-depth --skill tts -y

# Install from GitHub repository
npx skills add NoizAI/skills

# Local development (run in this repo directory)
npx skills add . --list --full-depth
```

## Available skills

| Name | Description | Documentation | Run command |
|------|-------------|---------------|-------------|
| tts | Convert text into speech with Kokoro or Noiz, supporting simple mode and timeline-aligned rendering workflows. | [SKILL.md](./skills/tts/SKILL.md) | `npx skills add NoizAI/skills --full-depth --skill tts -y` |
| characteristic-voice | Make generated speech feel companion-like with fillers, emotional tuning, and preset speaking styles. | [SKILL.md](./skills/characteristic-voice/SKILL.md) | `npx skills add NoizAI/skills --full-depth --skill characteristic-voice -y` |

## Quick Verify

For example, characteristic-voice
```bash
bash skills/characteristic-voice/scripts/speak.sh \
  --preset comfort -t "Hmm... I'm right here." -o comfort.wav
```

## English Audio Demos

Sample outputs for quick listening (MP4 for inline playback):

- Breaking news style  
  <video src="./examples/audio/demo-breaking-news.mp4" controls></video>
- Mindful calm style  
  <video src="./examples/audio/demo-mindful-calm.mp4" controls></video>
- Podcast intro style  
  <video src="./examples/audio/demo-podcast-intro.mp4" controls></video>
- Startup hype style  
  <video src="./examples/audio/demo-startup-hype.mp4" controls></video>

## Noiz API Key (recommended)

For the best experience (faster, emotion control, voice cloning), get your API key from [developers.noiz.ai](https://developers.noiz.ai):

```bash
bash skills/tts/scripts/tts.sh config --set-api-key YOUR_KEY
```

The key is persisted to `~/.noiz_api_key` and loaded automatically. Alternatively, pass `--backend kokoro` to use the local Kokoro backend.

## Contributing

For skill authoring rules, directory conventions, and PR guidance, see `CONTRIBUTING.md`.

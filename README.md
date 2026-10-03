<h1 align="center">🎙️ Local Video Transcription Workflow</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/FFmpeg-007808?style=for-the-badge&logo=FFmpeg&logoColor=white" alt="FFmpeg" />
  <img src="https://img.shields.io/badge/OpenAI_Whisper-412991?style=for-the-badge&logo=openai&logoColor=white" alt="Whisper" />
</p>

<p align="center">
  <em>Extract audio from your video files and automatically transcribe them into text using the power of FFmpeg and OpenAI Whisper running entirely locally.</em>
</p>

<hr>

> ⚠️ **Copyright and Ethical Use Disclaimer**
> This tool was developed exclusively for educational purposes, to facilitate personal study and automate local workflows. **Do not use** these scripts to download, transcribe, or redistribute copyrighted material, protected university lectures, or content without the explicit consent of the legitimate owners. The user assumes full responsibility for the use of this software.

<br>

## ⚙️ 1. Dependencies Installation

### Windows
Open **PowerShell as Administrator** and execute the following commands.

Install Python and FFmpeg:
```powershell
winget install --id Python.Python.3.11 --accept-source-agreements --accept-package-agreements
```
```powershell
winget install --id Gyan.FFmpeg --accept-source-agreements --accept-package-agreements
```

Unlock local scripts execution (required only the first time):
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### macOS / Linux
Open the **Terminal** and execute the following commands based on your operating system.

**macOS (using Homebrew):**
```bash
brew install python ffmpeg
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update && sudo apt install python3 python3-venv python3-pip ffmpeg -y
```

<br>

## 🐍 2. Virtual Environment and Whisper Configuration
Whisper installation must take place in an isolated environment to avoid conflicts with system packages. Open a standard terminal (non-administrator), navigate to this project's folder, and run:

**Windows:**
```powershell
python -m venv venv
```
```powershell
.\venv\Scripts\Activate.ps1
```
```powershell
pip install -U openai-whisper
```

**macOS / Linux:**
```bash
python3 -m venv venv
```
```bash
source venv/bin/activate
```
```bash
pip install -U openai-whisper
```

<br>

## 🚀 3. Usage

Every time you want to transcribe a video, open the terminal, navigate to the project folder, and activate the virtual environment. Next, launch the appropriate script for your operating system.

**Windows:**
```powershell
cd C:\path\to\transcribe-project
```
```powershell
.\venv\Scripts\Activate.ps1
```
```powershell
.\src\transcribe-video.ps1 -InputVideo "C:\path\to\video.mp4"
```

**macOS / Linux:**
```bash
cd /path/to/transcribe-project
```
```bash
source venv/bin/activate
```
```bash
./src/transcribe-video.sh "/path/to/video.mp4"
```
<br>

## 📌 Notes and Customizations

### 1. **Save the transcription in the same folder as the original video**

By default, Whisper saves the `.txt` file in the folder where you are executing the terminal command (which is the main project folder `transcribe-project`). If you prefer the text file to be automatically generated in the exact same location as the starting `.mp4` video, you can modify the scripts to redirect the output.

**For Windows (PowerShell):**
Open the file `src/transcribe-video.ps1` and replace the Whisper startup line with the following:
```powershell
& whisper $tempAudio --model base --output_format txt --language en --output_dir "$directory"
```

**For macOS / Linux (Bash):**
Open the file `src/transcribe.sh` and replace the Whisper startup line with the following:
```bash
whisper "$TEMP_AUDIO" --model base --output_format txt --language en --output_dir "$DIRNAME"
```

### 2. **Enable GPU Acceleration (NVIDIA)**

If your system is equipped with an NVIDIA dedicated graphics card, you can drastically reduce transcription times by offloading the workload from the CPU to the GPU. 

To enable CUDA acceleration on **Windows** or **Linux**, open your terminal, activate the virtual environment, and install the GPU-optimized version of PyTorch by running:
```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

*Note for macOS users:* If you are using a Mac with Apple Silicon (M1/M2/M3/M4 chips), hardware acceleration via Metal Performance Shaders (MPS) is natively supported and enabled by default with the standard installation. No additional steps are required.


### 3. **Transcribing in Different Languages or Auto-Detection**

By default, the provided scripts set the transcription language to English. If you want to transcribe a video in another language, you need to modify the `--language` parameter inside the scripts.

**For Windows (PowerShell):**
Open the `src/transcribe-video.ps1` file and replace the Whisper execution line with:
```powershell
& whisper $tempAudio --model base --output_format txt --language it
```

**For macOS / Linux (Bash):**
Open the `src/transcribe-video.sh` file and replace the Whisper execution line with:
```bash
whisper "$TEMP_AUDIO" --model base --output_format txt --language it
```

**Auto-detect Language:**
If you prefer Whisper to automatically detect the spoken language, you can simply remove the `--language en` flag entirely from the scripts. Whisper will analyze the first 30 seconds of the audio to determine the language automatically.

> **Language Codes Reference (Most spoken languages):**
> When setting the `--language` flag, you must use the standard 2-letter code. Here are the codes for some of the most used languages in the world:
> * English: `en`
> * Mandarin Chinese: `zh`
> * Hindi: `hi`
> * Spanish: `es`
> * French: `fr`
> * Arabic: `ar`
> * Bengali: `bn`
> * Russian: `ru`
> * Portuguese: `pt`
> * Urdu: `ur`
> * Italian: `it`

<br>

## 👥 Testers & Contributors
A special thanks to those who contributed to the development and testing across different platforms:
* **Roberto Gallucci** - Intensive testing, troubleshooting on Windows environments, and workflow processing.

<br>

## ⭐ Support the Project
If this workflow saved you time or was useful for your studies, please consider leaving a ⭐️ **Star** at the top right of this repository! 
Stars help the project grow and make it more visible to other developers and students who might need it.

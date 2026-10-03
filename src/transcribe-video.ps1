param (
    [Parameter(Mandatory=$true)]
    [string]$InputVideo
)

function Test-CommandExists {
    param ([string]$CommandName)
    return [bool](Get-Command $CommandName -ErrorAction SilentlyContinue)
}

function Main {
    if (-Not (Test-Path $InputVideo)) {
        Write-Error "Error: Input file '$InputVideo' not found."
        exit 1
    }

    if (-Not (Test-CommandExists "ffmpeg") -or -Not (Test-CommandExists "whisper")) {
        Write-Error "Error: Missing dependencies. Ensure FFmpeg and Whisper are installed."
        exit 1
    }

    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputVideo)
    $directory = [System.IO.Path]::GetDirectoryName($InputVideo)
    
    if ([string]::IsNullOrWhiteSpace($directory)) { 
        $directory = ".\" 
    }
    
    $tempAudio = Join-Path $directory "$baseName.wav"

    Write-Host "Extracting audio track..."
    & ffmpeg -y -i $InputVideo -ar 16000 -ac 1 -c:a pcm_s16le $tempAudio -loglevel error

    if (-Not (Test-Path $tempAudio)) {
        Write-Error "Error: Audio extraction failed."
        exit 1
    }

    Write-Host "Starting Whisper transcription..."
    & whisper $tempAudio --model base --output_format txt --language en

    Remove-Item -Path $tempAudio -Force
    Remove-Item -Path $InputVideo -Force

    Write-Host "Success! Transcription saved as ${baseName}.txt"
}

Main
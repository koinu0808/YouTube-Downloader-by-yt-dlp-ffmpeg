# ==============================================
# install-yt-dlp-ffmpeg.ps1
# PowerShell Fully Automated Installation of yt-dlp + ffmpeg
# ==============================================

# 1 Set download paths
$installRoot = "C:\tools"
$ytDlpExe = "$installRoot\yt-dlp.exe"
$ffmpegZip = "$env:TEMP\ffmpeg.zip"
$ffmpegUrl = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
$ffmpegDir = "$installRoot\ffmpeg"

# 2 Create root directory for tools
New-Item -ItemType Directory -Force -Path $installRoot

# 3 Download yt-dlp.exe
if (-Not (Test-Path $ytDlpExe)) {
    Write-Host "Downloading yt-dlp..."
    Invoke-WebRequest -Uri "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe" -OutFile $ytDlpExe
} else {
    Write-Host "yt-dlp already exists, skipping download"
}

# 4 Download ffmpeg (if not exists)
if (-Not (Test-Path $ffmpegZip)) {
    Write-Host "Downloading ffmpeg..."
    Invoke-WebRequest -Uri $ffmpegUrl -OutFile $ffmpegZip
} else {
    Write-Host "ffmpeg zip already exists, skipping download"
}

# 5 Extract ffmpeg
if (-Not (Test-Path $ffmpegDir) -or -Not (Get-ChildItem -Recurse $ffmpegDir | Where-Object { $_.Name -eq "ffmpeg.exe" })) {
    Write-Host "Extracting ffmpeg..."
    New-Item -ItemType Directory -Force -Path $ffmpegDir
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($ffmpegZip, $ffmpegDir)
} else {
    Write-Host "ffmpeg already extracted, skipping"
}

# 6 Locate ffmpeg bin folder
$binFolder = Get-ChildItem $ffmpegDir -Directory | Select-Object -First 1
$ffmpegBin = Join-Path $binFolder.FullName "bin"

# 7 Temporarily add to PATH (current session)
$env:Path = "$installRoot;$ffmpegBin;$env:Path"

# 8 Permanently add to system PATH (requires admin)
$currentPath = [Environment]::GetEnvironmentVariable("Path","Machine")
if ($currentPath -notlike "*$installRoot*" -or $currentPath -notlike "*$ffmpegBin*") {
    [Environment]::SetEnvironmentVariable("Path", "$installRoot;$ffmpegBin;$currentPath", "Machine")
    Write-Host "Permanently added to PATH. Please restart PowerShell to use yt-dlp + ffmpeg"
} else {
    Write-Host "PATH already contains yt-dlp and ffmpeg"
}

# 9 Test installation
Write-Host "`nTesting yt-dlp:"
& $ytDlpExe --version

Write-Host "`nTesting ffmpeg:"
& (Join-Path $ffmpegBin "ffmpeg.exe") -version

Write-Host "Download completed. Please restart PowerShell"
Write-Host "Thank you for using"
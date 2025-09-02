# YouTube-Downloader-by-yt-dlp & ffmpeg
***Pleace Download Python First***

## This project can help you download & setting PATH for yt-dlp and ffmpeg
Just run `./YouTube-Downloader-for-Windows.ps1` and wait for it to finish.   
After done. You will restart PowerShell

yt-dlp Usage:  
type ```yt-dlp --version to check version```  
type ```yt-dlp -t mp4 <url>``` can use  
**default vidieo storage location is your current document**  
you can use ```yt-dlp -F <url>``` to see available video formats  
Use -o select download location. For example: ```-o ".\OneDrive\Desktop\%(title)s.%(ext)s"```  
Use -f choose formats

***if you want video + audio mix, you will see the following usage***

Example video formats:  
140 | m4a audio only  
299 | 1080 video only

You will type following:  
```yt-dlp -f "299+140" -o ".\OneDrive\Desktop\%(title)s.%(ext)s" <url>```

ffmpeg is required for yt-dlp to combine video and audio.  

Sep 2 2025 edit:  
For Windows only
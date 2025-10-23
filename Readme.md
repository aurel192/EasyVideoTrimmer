# Video Trimmer and Converter
---
This `trim.sh` script provides an interactive command-line interface to trim videos using ffmpeg.

It allows you to:

- Select an input video file
- Specify the start time and duration to trim (optional)
- Or skip `trimming` if you just want to change the `video codec`
- You can `trim` the video and change `codec` too.
- Choose the output directory and filename
- Select the video codec (e.g.`libx264`, `vp9`,  or `copy`)
- Specify the video bitrate if not using copy codec

---

### Usage

1. Make sure you have ffmpeg installed and accessible from the terminal.  
2. Add ffmpeg to PATH to access it anywhere.  
3. Run the script: `./trim.sh`  
On Windows the easiest way to run .sh files is `Windows Power Shell` then type `bash` then start the script.  
Or use GitBash which is a component in `Git for Windows`.
4. Follow the prompts:
   - Enter the input file directory and name
   - Enter the output file directory and name 
   - Specify the start time and duration for trimming  
   Optional: just press enter if you do not want to cut the video   
   - Select the video codec and bitrate.   
   Optional: If you do not want the change the video codec type `copy` as codec, it is the `fastest`  
   Type: `ffmpeg -encoders` to list the available encoders
5. The script will run the ffmpeg command to trim and/or encode the video.

---

### Example:

#### Trim a video from 5 seconds to 12 seconds and change the codec with 512 kbit/sec bitrate

> - Enter the input file directory (e.g. C:/Videos/): C:/Videos/
> - Enter the input file name (e.g. IN.mp4): input.mp4
> - Enter the output file directory (press Enter to use input directory): 
> - Enter the output file name (e.g. OUT.mp4): output.mp4
> - Enter the start time (press Enter if you do not want to cut the video! e.g. 00:00:00): 00:00:05
> - Enter the duration (e.g. 00:00:05): 00:00:07
> - Enter video codec (press Enter for default libx264 codec): h261
> - Enter video bitrate in kbit/sec (e.g. 2000): 512

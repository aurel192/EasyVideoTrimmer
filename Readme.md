# Video Trimmer and Converter
---
This `trim.sh` script provides an interactive command-line interface to trim videos using ffmpeg.

It allows you to:

- Select an input video file
- Specify the start time and duration to trim
- Choose the output directory and filename
- Select the video codec (copy or vp9)
- Specify the video bitrate if not using copy codec

---

### Usage

To use the script:

1. Make sure you have ffmpeg installed and accessible from the command line.
2. Run the script: `./trim.sh`
3. Follow the prompts to:
   - Enter the input file directory and name
   - Enter the output file directory and name 
   - Specify the start time and duration for trimming
   - Select the video codec and bitrate if applicable
4. The script will run the ffmpeg command to trim the video.

---

### Example: Trim a video from 5 seconds to 12 seconds

- Enter the input file directory (e.g. C:/Videos/): C:/Videos/
- Enter the input file name (e.g. IN.mp4): input.mp4
- Enter the output file directory (press Enter to use input directory): 
- Enter the output file name (e.g. OUT.mp4): output.mp4
- Enter the start time (press Enter if you do not want to cut the video! e.g. 00:00:00): 00:00:05
- Enter the duration (e.g. 00:00:05): 00:00:07
- Enter video codec (press Enter for default vp9 codec): h264_vulkan
- Enter video bitrate in kilobytes per second (e.g. 512): 512

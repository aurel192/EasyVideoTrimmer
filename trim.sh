#!/bin/bash

# Example ffmpeg command:
# ffmpeg -i "IN.mp4" -ss 00:00:05 -t 00:00:07 -c:a copy -c:v vp9 -b:v 512k "CUT.mp4"

# Function to normalize directory paths:
# - Converts backslashes to slashes
# - Ensures trailing slash
normalize_path() {
    local dir="$1"
    # Replace all backslashes with slashes
    dir="${dir//\\//}"
    # Ensure trailing slash
    if [[ ! "$dir" =~ [/]$ ]]; then
        dir="$dir/"
    fi
    echo "$dir"
}

# Input file selection loop
while true; do
    # Ask for input directory
    echo
    read -r -p "Enter the input file directory (e.g. C:/Videos/): " indir
    echo
    if [ -z "$indir" ]; then
        echo
        echo "Input directory is required!"
        echo
        continue
    fi
    indir=$(normalize_path "$indir")

    # Check if directory exists
    if [ ! -d "$indir" ]; then
        echo
        echo "Directory not found: $indir"
        echo
        continue
    fi
    
    # Ask for input file name
    echo
    read -r -p "Enter the input file name (e.g. IN.mp4): " infilename
    echo
    if [ -z "$infilename" ]; then
        echo
        echo "File name is required!"
        echo
        continue
    fi
    infile="${indir}${infilename}"

    # Check if input file exists
    if [ ! -f "$infile" ]; then
        echo
        echo "Input file not found: $infile"
        echo
        continue
    fi
    break
done

# Output file selection loop
while true; do
    echo
    read -r -p "Enter the output file directory (press Enter to use input directory): " outdir
    echo
    if [ -z "$outdir" ]; then
        outdir="$indir"
    else
        outdir=$(normalize_path "$outdir")
    fi

    # Ask for output file name
    echo
    read -r -p "Enter the output file name (e.g. OUT.mp4): " outfilename
    echo
    if [ -z "$outfilename" ]; then
        echo
        echo "Output file name is required!"
        echo
        continue
    fi
    outfile="${outdir}${outfilename}"
    break
done

# Start time and duration input loop
while true; do
    echo
    read -p "Enter the start time (press Enter if you do not want to cut the video! e.g. 00:00:00): " ss
    echo
    # If start time is empty, skip duration input
    if [ -z "$ss" ]; then
        break
    fi
    read -p "Enter the duration (e.g. 00:00:05): " t
    echo

    # Validate that both are provided together
    if [ -n "$ss" ] && [ -z "$t" ]; then
        echo
        echo "Duration is required if start time is given."
        echo
        continue
    fi
    if [ -n "$t" ] && [ -z "$ss" ]; then
        echo
        echo "Start time is required if duration is given."
        echo
        continue
    fi

    # Validate time format
    if [ -n "$ss" ] && [[ ! "$ss" =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
        echo
        echo "Invalid start time format. Use HH:MM:SS."
        echo
        continue
    fi
    if [ -n "$t" ] && [[ ! "$t" =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
        echo
        echo "Invalid duration format. Use HH:MM:SS."
        echo
        continue
    fi
    break
done

# Ask for video codec, default is libx264 if empty
echo
echo "To list available video codecs: use ffmpeg -encoders command."
echo "Note: Using 'copy' will skip re-encoding and keep the original codec."
echo "It is the fastest method, but bitrate will be the same as the original."
read -p "Enter video codec (press Enter for default libx264 codec): " videocodec
echo
if [ -z "$videocodec" ]; then
    videocodec="libx264"
fi

# Ask for video bitrate only if codec is not "copy"
if [ "$videocodec" != "copy" ]; then
    echo
    read -p "Enter video bitrate in kbit/sec (e.g. 512): " bitrate
    echo
    bitrateopt="-b:v ${bitrate}k"
else
    bitrateopt=""
fi

# Build ffmpeg time options only if both start time and duration are set
if [ -n "$ss" ] && [ -n "$t" ]; then
    timeopts="-ss $ss -t $t"
else
    timeopts=""
fi

# Build the ffmpeg command
echo
cmd="ffmpeg -i \"$infile\" $timeopts -c:a copy -c:v $videocodec $bitrateopt \"$outfile\""
echo "Running command: "
echo "$cmd"
echo

# Run the command
if eval $cmd; then
    echo
    echo "Video cut/encode completed successfully."
    echo
else
    echo
    echo "An error occurred during cutting."
    echo
fi
# End of script

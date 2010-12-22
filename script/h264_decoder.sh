#!/bin/bash

if [ -z $3 ]
then
    echo -e "\tUsage: $0 INPUT_VIDEO_DIR FILEMASK OUTPUT_VIDEO_DIR\n\tExample: $0 /home/username/to_convert *.avi /home/username/converted"
    exit 1
fi

input_video_dir=$1
filemask=$2
output_video_dir=$3
logfile=$output_video_dir/convert.log
source_extension=`echo $filemask | awk -F"." '{ ; print $NF }'`

encode() {
    HandBrakeCLI --preset Universal --vb 800 --two-pass --turbo --input "$1" --output "$2" 2> /dev/null
    if [ "$?" == "0" ]
        then
            echo "$(date +"%D %H:%M:%S") : \"$original_filename\" successfully converted." >> $logfile
        else
            echo "$(date +"%D %H:%M:%S") : !!! \"$original_filename\" converted with errors" >> $logfile
        fi
}
echo -e "$(date +"%D %H:%M:%S") : Convert script started... \n\tPerforming $input_video_dir/$filemask -> $output_video_dir/*.mp4" > $logfile

tmplist=`find $input_video_dir/* -maxdepth 0 -type f -name "$filemask"`

for video in $tmplist
do
    if [ -e "$video" ]
    then
        original_filename=`basename "$video"`
        echo "$(date +"%D %H:%M:%S") : Converting \"$original_filename\"" >> $logfile
        echo "Converting \"$original_filename\""
        encode "$video" "$output_video_dir/$(basename $video $source_extension)mp4"
        echo ""
    fi
done

echo "$(date +"%D %H:%M:%S") : Convert script finished job." >> $logfile

exit 0

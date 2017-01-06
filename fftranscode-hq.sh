#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Full hardware transcoding using Nvidia nvdec (CUVID) decode / Nvidia NVENC encode
#
# Usage fftranscode [-h] [-d <decoder_name>] [-e <encoder_name>] -i input_file -o output_file

DECODER=h264_cuvid
ENCODER=hevc_nvenc
INPUT=
OUTPUT=
WIDTH=1920
HEIGHT=1080

show_usage(){
cat << EOF
    Usage: "$(basename "$0")": [-h] [-d <decoder_name>] [-e <encoder_name>] [-x width] [-y height] -i input_file -o output_file

        [Default values]
            Decoder - h264_cuvid
            Encoder - hevc_nvenc
            Width   - 1920
            Height  - 1080

        For a list of decoders, use: ffmpeg -hide_banner -decoders | grep cuvid
        For a list of encoders, use: ffmpeg -hide_banner -encoders | grep nvenc
EOF
}

main(){
    ffmpeg -hide_banner -y -hwaccel cuvid \
        -vcodec "$DECODER" \
        -i "$INPUT" \
        -vf scale_npp="$WIDTH":"$HEIGHT" \
        -vcodec "$ENCODER" \
        -preset slow \
        -profile:v main10 \
        -pix_fmt cuda \
        -rc vbr_2pass \
        -rc-lookahead 480 \
        -temporal-aq 1 \
        -strict_gop 1 \
        -qmin 0 \
        -qmax 28 \
        -acodec copy \
        "$OUTPUT"
}

while getopts ":hd:e:i:o:x:y:" opt; do
    case $opt in
        h)
            show_usage
            exit
            ;;
        d)
            DECODER=$OPTARG
            ;;
        e)
            ENCODER=$OPTARG
            ;;
        i)
            INPUT=$OPTARG
            ;;
        o)
            OUTPUT=$OPTARG
            ;;
        x)
            WIDTH=$OPTARG
            ;;
        y)
            HEIGHT=$OPTARG
            ;;
        \?)
            echo "invalid option -$OPTARG" >&2
            ;;
    esac
done

main

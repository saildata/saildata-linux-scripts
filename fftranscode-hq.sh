#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Full hardware transcoding using Nvidia nvdec (CUVID) decode / Nvidia NVENC encode
#
# Usage fftranscode [-h] [-d <decoder_name>] [-e <encoder_name>] -i input_file -o output_file

# TODO - read docs/ add options for output resolution

DECODER=h264_cuvid
ENCODER=hevc_nvenc
INPUT=
OUTPUT=

show_usage(){
cat << EOF
    Usage: "$(basename "$0")": [-h] [-d <decoder_name>] [-e <encoder_name>] -i input_file -o output_file
        The default decoder is h264_cuvid
        The default encoder is hevc_nvenc.
        For a list of decoders, use: ffmpeg -hide_banner -decoders | grep cuvid
        For a list of encoders, use: ffmpeg -hide_banner -encoders | grep nvenc
EOF
}

main(){
    ffmpeg -hide_banner -y -hwaccel cuvid \
        -vcodec "$DECODER" \
        -i "$INPUT" \
        -vcodec "$ENCODER" \
        -preset slow \
        -profile:v main10 \
        -tier high \
        -rc vbr_2pass \
        -rc-lookahead 120 \
        -temporal-aq 1 \
        -strict_gop 1 \
        -qmin 0 \
        -qmax 35 \
        -acodec copy \
        "$OUTPUT"
}

while getopts ":hd:e:i:o:" opt; do
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
        \?)
            echo "invalid option -$OPTARG" >&2
            ;;
    esac
done

main

#!/bin/bash

TARGET=merge.mp4
ASECT_16_9=-vf "scale=-1:360,pad=640:ih:(ow-iw)/2" 

rm -rf $TARGET 
rm 0.mpg 1.mpg 2.mpg


echo cqd ${SECT_16_9} 
#ffmpeg -i 288X512_out.mp4 -i Eng_Output_1.mp4 -i 288X512_out.mp4 -filter_complex \
#      "[0:v:0] [0:a:0]  [1:v:0] [1:a:0] [2:v:0] [2:a:0] concat=n=3:v=1:a=1 [v] [a]" \
#         -map "[v]" -map "a" output_filter.mp4


#ffmpeg -i 0_start.mov -i 1_middle.mov -filter_complex \
#      "[0:v:0] [0:a:0]  [1:v:0] [1:a:0] concat=n=2:v=1:a=1 [v] [a]" \
#         -map "[v]" -map "[a]" output_filter.mp4


#ffmpeg -i 288X512_out.mp4 -i Eng_Output_1.mp4\
#    -filter_complex "[0:v:0] [0:a:0] [1:v:0] [1:a:0] concat=n=2:v=1:a=1 [v] [a]" \
#    -map "[v]" -map "[a]"  output.mp4


# 目前测试仅该方法有效
ffmpeg -i   ./0_start.mov -r 30 -qscale 0 0.mpg   #片头 
ffmpeg -i   ./2_end.mov   -r 30 -qscale 0 2.mpg   #片尾 
ffmpeg -i   ./XingQiuJueQi_16_BFrames.mp4 -vf "scale=-1:360,pad=640:ih:(ow-iw)/2"  -r 30 -qscale 0 1.mpg 
cat 0.mpg 1.mpg 2.mpg | ffmpeg -f mpeg -i - -vcodec h264 -r 30 -b 1536K -acodec aac -ab 60K  $TARGET

# 测试有音轨时视频合并,同时存在 4:3 转 16:9 转换，测试ok 
#ffmpeg -i 1024x768_43_test_shape.mp4  -vf "scale=-1:360,pad=640:ih:(ow-iw)/2"  -r 30 -qscale 0 0.mpg 
#ffmpeg -i XingQiuJueQi_16_BFrames.mp4 -vf "scale=-1:360,pad=640:ih:(ow-iw)/2"  -r 30 -qscale 0 1.mpg 
#cat 0.mpg 1.mpg | ffmpeg -f mpeg -i - -vcodec h264 -r 30 -b 1536K -acodec aac -ab 60K  $TARGET

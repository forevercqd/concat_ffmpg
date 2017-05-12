#!/bin/bash

TARGET=merge.mp4


SRC_FILE0=0_start
SRC_FILE2=2_end
SRC_FILE1=XingQiuJueQi_16_BFrames

ASECT_16_9=-vf "scale=-1:360,pad=640:ih:(ow-iw)/2" 

rm -rf $TARGET 
rm -rf ${SRC_FILE0}.mpg ${SRC_FILE1}.mpg ${SRC_FILE2}.mpg

length0=`ffmpeg -i ${SRC_FILE0}.mov 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,// `
length1=`ffmpeg -i ${SRC_FILE1}.mov 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,// `
echo cqd length=$length0 length1=$length1 

# 目前测试仅该方法有效
ffmpeg -i ${SRC_FILE0}.mov  -r 30 -qscale 0 -y ${SRC_FILE0}.mpg  #片头 
ffmpeg -i ${SRC_FILE2}.mov  -r 30 -qscale 0 -y ${SRC_FILE2}.mpg  #片尾 

ffmpeg -i ${SRC_FILE1}.mp4  -vf "scale=-1:360,pad=640:ih:(ow-iw)/2"  -r 30 -qscale 0 -y ${SRC_FILE1}.mpg

cat ${SRC_FILE0}.mpg ${SRC_FILE1}.mpg ${SRC_FILE2}.mpg | ffmpeg  -i -  \
    -vf  "movie=mask.png,scale= -1: -1[watermask]; [in] [watermask] overlay=x='if(between(t, 2, 14), 50, -1000)':y=50 [out]"\
    -vcodec h264 -r 30 -b 1536K -acodec aac -ab 60K -y $TARGET 

# 测试有音轨时视频合并,同时存在 4:3 转 16:9 转换，测试ok 
#ffmpeg -i 1024x768_43_test_shape.mp4  -vf "scale=-1:360,pad=640:ih:(ow-iw)/2"  -r 30 -qscale 0 0.mpg 
#ffmpeg -i XingQiuJueQi_16_BFrames.mp4 -vf "scale=-1:360,pad=640:ih:(ow-iw)/2"  -r 30 -qscale 0 1.mpg 
#cat 0.mpg 1.mpg | ffmpeg -f mpeg -i - -vcodec h264 -r 30 -b 1536K -acodec aac -ab 60K  $TARGET

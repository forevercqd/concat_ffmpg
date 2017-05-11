#!/bin/bash

src_name=0_start
dst_name=0_start_new


length=`ffmpeg -i ${src_name}.mov 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,// `        # 获取视频的时长   
ffmpeg -i ${src_name}.mov  -f mp3 -vn -y  ${src_name}.mp3                    # 截取等时长的音频
ffmpeg -i ${src_name}.mov -ss 00:00:00 -t $length -f mp3 -vn -y  ${dst_name}.mp3                    # 截取等时长的音频
ffmpeg -i ${src_name}.mov -vcodec copy -an -y  ${dst_name}_temp.mp4                                      # 祛除视频声音
ffmpeg -i ${dst_name}.mp3 -i ${dst_name}_temp.mp4 -y ${dst_name}.mp4                  #把音频合成进去

#!/bin/bash

#ffmpeg -i 288X512_out.mp4 -i Eng_Output_1.mp4 -i 288X512_out.mp4 -filter_complex \
#      "[0:v:0] [0:a:0]  [1:v:0] [1:a:0] [2:v:0] [2:a:0] concat=n=3:v=1:a=1 [v] [a]" \
#         -map "[v]" -map "a" output_filter.mp4


#ffmpeg -i 0_start.mov -i 1_middle.mov -filter_complex \
#      "[0:v:0] [0:a:0]  [1:v:0] [1:a:0] concat=n=2:v=1:a=1 [v] [a]" \
#         -map "[v]" -map "[a]" output_filter.mp4


#ffmpeg -i 288X512_out.mp4 -i Eng_Output_1.mp4\
#    -filter_complex "[0:v:0] [0:a:0] [1:v:0] [1:a:0] concat=n=2:v=1:a=1 [v] [a]" \
#    -map "[v]" -map "[a]"  output.mp4


#ffmpeg  -i 288X512_out.mp4 -i Eng_Output_1.mp4 -i 288X512_out.mp4  -filter_complex \
#            "[0]scale=288x512,setdar=16/9[a];[1]scale=288x512,setdar=16/9[b];[2]scale=288x512,setdar=16/9[c];[3]scale=288x512,setdar=16/9[d];[a][b][c][d]concat=n=4:v=1:a=1" output_new.mp4


#ffmpeg -i ./0_start.mov -vcodec copy -acodec copy -vbsf h264_mp4toannexb 1.ts
#ffmpeg -i ./1_middle.mov -vcodec copy -acodec copy -vbsf h264_mp4toannexb 2.ts
#ffmpeg -i ./2_end.mov    -vcodec copy -acodec copy -vbsf h264_mp4toannexb 3.ts
#ffmpeg -i "concat:1.ts|2.ts|3.ts" -acodec copy -vcodec copy -absf aac_adtstoasc output.mov


# 目前测试仅该方法有效
ffmpeg -i ./0_start.mov  -qscale 0 0.mpg    
ffmpeg -i ./1_middle.mp4 -vf scale=640:360 -aspect 16:9 -r 30 -b 1536K  -qscale 0 1.mpg
ffmpeg -i ./2_end.mov    -qscale 0 2.mpg
cat 0.mpg 1.mpg 2.mpg | ffmpeg -f mpeg -i - -qscale 0 -vcodec mpeg4 out_new.mp4

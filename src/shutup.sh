#!/bin/bash
remove="$@";
echo "$remove" >> ~/sh.log
ps aux | grep reader.sh | grep -v grep | cut -d\  -f3 | while read pid; do 
    kill -9 $pid;
done
if [ $remove ]; then
    rm -f /home/diknows/.skypetmp/*.txt;
    rm -f /home/diknows/.skypetmp/MP3/*.mp3;
fi

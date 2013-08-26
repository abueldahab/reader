#!/bin/bash
##############################################
# Reads the contents of the files (messages in the files ) in the $d
##############################################
d="$HOME/.skypetmp";
mkdir -p "$d/old";
MP3="$d/MP3";
mkdir -p "$MP3"; 
ip="$DIKNOWS"; 

function speak_naturalreaders(){
    local text=$1;
    local name=$2;
    local requesttoken=$3;
    echo "EN -> $text";
    #
    # Original Page http://www.naturalreaders.com/
    #
    MAN=1;
    MAN_RAYAN=33;       # So BAD
    MAN_FR_BRUNO=22;
    WOMAN_HEATHER=26;
    WOMAN_LAURA=17;
    WOMAN_CRYSTAL=11;
    WOMAN_FR_ALICE=21;
    SPEED=3;
    FRSPEED=1;
    local url="http://api.naturalreaders.com/v2/tts/";
    text=${text//'-'/' '}
    text=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$text"); echo $text;
    local data="r=$MAN&s=$SPEED&requesttoken=$requesttoken&t=$text";
    echo "$data" "$url" ;
    curl -s -o "$MP3/$name.mp3" -d "$data" "$url" ;
}
function speak_google(){
    local text=$1;
    local name=$2;
    echo "FR -> $text";
    # echo "Reading : $text";
    text=${text//'-'/' '}
    text="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$text")"
    local url="http://translate.google.com/translate_tts?tl=fr&q=$text";
    echo $url
    curl -s -o "$MP3/$name.mp3" -H "Content-Type: audio/mpeg" -A "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)" "$url" ;
}

# Loop over all the list of files in a directory and read them
function read_files(){
    # $1 : Path to the directory to read files from 
    cd $1 &> /dev/null;
    # Get list of files currently there and get it sorted
    local list=$(ls *.txt 2> /dev/null | sort );
    # $list is a block of lines .. tr splits them to real iterable lines 
    local requesttoken_url="http://api.naturalreaders.com/v2/auth/requesttoken?appid=tdtzxghaepc&appsecret=gy5r6sqtgjcwo8gwso4k8oo4wsws84c&_=1360156632953"
    local requesttoken=`curl -s $requesttoken_url | json -C "requesttoken"`
    for filename in `echo $list | tr ";" "\n"` ; do
    # ls *.txt | sort | while read filename; do
        if [ -f $filename ]; then
            local counter=0;
            local longtext=`cat "$filename" | sed -rs "s:&apos;:':g"` ;
            local longtext=`echo "$longtext" | sed -rs "s:&.{3,4};::g"` ;
            node /home/diknows/bin/reader/src/js/split.js "$longtext" | while read text; do
                local splittedFileName="`echo $filename | cut -d. -f1`_$counter";
                if [[ $text == "...-"* ]]; then 
                    text=${text:3}
                    if [[ $text == "-"* ]]; then 
                        text=${text:1}
                    fi
                    speak_google "$text" "$splittedFileName"
                else
                    speak_naturalreaders "$text" "$splittedFileName" "$requesttoken"
                fi
                counter="`expr $counter + 1`";
                sleep 0.1;
            done;
            mv "$filename" "$1/old/" ;
        fi ;
    done;
    cd - &> /dev/null ;
}

function playMp3(){
    while : ;do
        # Get list of files currently there and get it sorted
        # $list is a block of lines .. tr splits them to real iterable lines 
        ls -1 "$MP3" | sort | while read filename; do
            if [ -f "$MP3/$filename" ]; then
                mpg123 -q "$MP3/$filename";
                rm -f "$MP3/$filename";
            fi ;
        done;
        sleep 1;
    done
}

playMp3 &
# Initial read of messages
while : ;do
	read_files "$d" ;
	sleep 1;
done

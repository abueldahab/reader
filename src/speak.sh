#!/bin/bash - 
#===============================================================================
#
#          FILE: speak.sh
# 
#         USAGE: ./speak.sh 
# 
#   DESCRIPTION: Starts the reader if not started and passed the text to the
#   writer
# 
#       OPTIONS: The text to read
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Diaa Kasem
#  ORGANIZATION: 
#       CREATED: 06/04/13 09:28:04 EET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function print(){
    echo "$@" >> ~/sh.log
}
#!/bin/bash
text="$@";
res=`ps aux | grep "reader.sh" | grep -v grep | wc -l`;
if [ $res -lt 1 ]; then 
    print "Initializing new reader... [ $res ]"
    /home/diknows/bin/reader/src/reader.sh &
fi 
/home/diknows/bin/reader/src/normalwriter.py "$text" &


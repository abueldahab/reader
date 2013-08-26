#!/bin/bash - 
#===============================================================================
#
#          FILE: params_reveal.sh
# 
#         USAGE: ./params_reveal.sh 
# 
#   DESCRIPTION: Just puts the parameters to the file params.txt
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/19/12 09:43:14 EET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/bin/bash
echo `date` >> ~/.params.txt ;
echo "Opening $@" >> ~/.params.txt; 
echo "------------------------------------" >> ~/.params.txt ;
echo >> ~/.params.txt ;
sleep 60; 
xdg-open "$@"

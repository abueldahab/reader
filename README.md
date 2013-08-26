#!/bin/bash
#################################################################
#
# Installs the universal reader in the linux system
# It can integrate with skype and all the system
# In skype editing advanced notifications to execute the command
# 
# /home/diknows/bin/reader/src/writer.py "\%sname: \%smessage"
#
# In system wide, one can use clipit program and create actions
# Speak : /home/{user}/path/to/reader/src/speak.sh {text}
# Speak : /home/diknows/bin/reader/src/speak.sh %s
# Parle : /home/diknows/bin/reader/src/speak.sh ...%s
# Pause : /home/diknows/bin/reader/src/shutup.sh
# Shutup : /home/diknows/bin/reader/src/shutup.sh 'remove'
#
####################################################################

alias I='sudo apt-get install'
alias II='sudo npm install -g'

I clvc curl
II json
touch ~/fix.sh && chmod +x ~/fix.sh

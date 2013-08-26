#!/usr/bin/env python
import sys, os, time
############################################################################### 
home          = os.path.expanduser('~')
msg           = "%sT.txt" % os.path.join(home,'.skypetmp','msg_')
############################################################################### 
def write(text):
    msg_file = msg.replace('T',str(time.time()))
    time.sleep(0.1)
    with open(msg_file, 'w') as f : f.write(text)

def main(text):
    print text
    write(text)

if __name__ == '__main__': 
    # Make All arguments as text
    text   = ' '.join(sys.argv[1:])
    main(text)

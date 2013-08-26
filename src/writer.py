#!/usr/bin/env python
import sys, os, re, time
############################################################################### 
sender        = 'READER_LAST_SENDER'
home          = os.path.expanduser('~')
skype_pattern = re.compile(r'(\w+)\s\w+:\s(.+)')
removables    = (r':p', r':P', r':d', r':\)', r':\(', r':D', r'\s+')
msg           = "%sT.txt" % os.path.join(home,'.skypetmp','msg_')
link_name     = ' LINK '
############################################################################### 
def write(text):
    msg_file = msg.replace('T',str(time.time()))
    time.sleep(0.1)
    with open(msg_file, 'w') as f : f.write(text)

def setLastSender(name):
    with open(os.getenv('HOME')+'/.last_reader_sender','w') as f: f.write(name)

def getLastSender():
    try:
        with open(os.getenv('HOME')+'/.last_reader_sender','r') as f: return f.readline()
    except : pass

def main(text):
    if '***ERRORTRACEBACK***' in text: return 
    # Convert links to a LINK word 
    text   = re.sub('http(s?)://(.*?(\s|$))?', link_name, text)
    # Remove Useless text
    text   = re.sub('(%s)' % '|'.join(removables), ' ', text).strip()
    while '<ss type=' in text:
        text = text.replace('<ss type=.+>','',1)
        text = text.replace('<ss type=','',1)
        text = text.replace('</ss>','',1)

    # Remove Python Errors or Logs
    removable = {'Sent a log message': ['[INFO]','[DEBUG]'], 
            'Sent an error message': ['***ERROR***', '<Fault','[ERROR]','|Exception']}
    for msg, logs in removable.iteritems() : 
        for log in logs:
            if '%s'%log in text:
                text = msg
                break;

    # Check skype pattern 
    matchs = skype_pattern.match(text)											#Just for skype
    # If when matched .. inject the colon ':' to separate the user from text
    text = ' : '.join(matchs.groups()) if matchs else text
    text_splits  = text.split(':')
    if len(text_splits) > 0 :
        name = str(text_splits[0])
        if name.strip() == getLastSender():
            text = ''.join(text_splits[1:])
            # If no text to write, then dont write anything
            if text.strip() == '' :
                return
        else:
            setLastSender(name.strip())
    print text
    write(text)

if __name__ == '__main__': 
    # Make All arguments as text
    text   = ' '.join(sys.argv[1:])
    main(text)

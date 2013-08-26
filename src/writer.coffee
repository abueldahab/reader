#!/usr/bin/env node
# import sys, os, re, time
fs = require 'fs'
path = require 'path'

# Variables
sender        = 'READER_LAST_SENDER'
home          = path.relative('~')
skype_pattern = /(\w+)\s\w+:\s(.+)/
removables    = [ /:p/, /:P/, /:d/, /:\)/, /:\(/, /:D/, /\s+/ ]
msg           = "#{path.join(home, ".skypetmp" ,"msg_")}T.txt"
link_name     = " LINK "

cache = '/etc': '/etc/private'
fs.realpath '/home', cache, (err, resolvedPath)->
    console.log resolvedPath
    console.log home
    console.log msg

#!/bin/bash
d="$HOME/.skypetmp"
for i in $(ls "$d/old/" | sort -r | head -n $1); do mv "$d/old/$i" "$d/$i"; touch "$d/$i" ;done
touch "$d" ; 

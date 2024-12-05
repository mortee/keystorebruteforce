#!/bin/sh

echo $*
if [ -z "$*" ]; then 
  python ./keystorebrute.py $*
else
  python ./keystorebrute.py $*
fi

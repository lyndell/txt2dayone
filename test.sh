#!/bin/bash -x
# 
#  for Mac:  !/usr/bin/bash -x
# 

set warnings;
set strict;


echo "no parms.\n\n"

./txt2dayone.pl 

echo "missing file.\n\n"

./txt2dayone.pl hu

echo "help test.\n\n"

./txt2dayone.pl -h

echo "file out parm test.\n\n"

./txt2dayone.pl -f

echo "missing and existing file\n\n"

./txt2dayone.pl hu empty empty.txt 

echo "test mode.\n\n"

./txt2dayone.pl -t  empty.txt

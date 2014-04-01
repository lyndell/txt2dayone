#!/bin/bash -x

# Variables
#

date=""
file=$1

# FUNCTIONS


function getFile () {
  if [ -z $file ]
  then
    echo "No file specified."
  fi

  if [ ! -e $file ] # no file
  then
    echo "File missing or not found."
  fi

}
 
# make sure stat command is installed 
function checkstat () {
  which stat > /dev/null
  if [ $? -eq 1 ]
  then
    echo "stat command not found!"
    exit 2
  fi
}

function getDate () {
  #
  # tech@wrkstn txt2dayone $ stat -c %y empty.txt 
  # 2013-12-25 17:20:10.000000000 -0600
  # tech@wrkstn txt2dayone $ 
  #
  if [ $OSTYPE == "linux-gnu" ]
  then
    date=`stat -c %y $file `
  elif [ $OSTYPE == "darwin*" ]
  then
    date=`stat -f "%m%t%Sm" $file | cut -f2-`
  fi
  # Example  
  #    > stat -f "%m%t%Sm %N" /tmp/* | sort -rn | head -3 | cut -f2-
  #    Apr 25 11:47:00 2002 /tmp/blah
  #    Apr 25 10:36:34 2002 /tmp/bar
  #    Apr 24 16:47:35 2002 /tmp/foo
  echo "Date is: $date "
}

# Check for corresponding phots, with same file name 
function getPhoto () {
  if [ "${file##*.}" == "jpg" ]
  then
    echo "yayh, JPEG!  We have a photo."
  fi
  exit;
  photoCmd=""
}

# `which dayone` ]
function checkDayone () {
  if [ $OSTYPE != "darwin*" ]
  then
    echo "DayOne is Mac only."
  elif [ -e /usr/local/bin/dayone ]
  then
    # echo dayone  -d=\"${date}\" new < ${file}
    dayone  -d="${date}" new < ${file}
  else
    echo "DayOne missing"
  fi
}

# Delete added files, including photo if present.
#

function checkTrash () {
  if [ -e /usr/local/bin/trash ]
  then
    trash $file || echo "Failed to trash $file: $!"; 
  else
    mv -v $file deleteme/
  fi
}


# START

checkstat
checkDayone

getFile
getDate
getPhoto 

# Check for journal entry
#
if [ ! -e $file ]
then
  echo " $file is missing"; exit; # " $file exists! "
fi

# # Test mode
#
# Print commands that will be run
# # Run mode
#
# Add jounral entry
#





DAYONE=<<'DAYONE';

# Commands

new

  Adds a new entry
  using text from stdin

# Options

-d,
–date=<date>

  Creation date of the entry. If
  not specified then the current date is used. This option
  accepts dates in most formats, including some natural
  language strings such as ’tomorrow’ and
  ’yesterday’. The systemâs locale is used
  when deciding how to parse a date. The date is parsed using
  -[NSDate dateWithNaturalLanguageString].

-p,
–photo-path=<path>

  File path to a photo to attach
  to entry. Most image formats are accepted. If any side of
  the image is greater than 1600 pixels then it will be
  resized. In all cases the image is converted to JPEG.

DAYONE

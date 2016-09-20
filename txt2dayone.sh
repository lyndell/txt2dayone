#!/bin/bash -x
set +x			# disable debugging 
set -x			#  enable debugging 

# - [ ] TODO: add switch for opting to open an editor
# - [ ] TODO: add code to test for switch, open or bypass
#             opening editor.
#

# Variables
#

date=""
file=$1

if [[ "$OSTYPE" != "darwin"* ]]
then
  echo "This is a Mac only script.  "
  testmode='echo '      # test mode ON
  echo                   "Test mode ON"
  # set -x			          # activate debugging from here
  # echo                  "Debugging enabled."
else
  if [[ ! `which dayone` ]] 
  then
    echo "DayOne CLI missing"
    exit
  fi
fi

# FUNCTIONS

# check for file
{
  if [ -z $file ]
  then
    echo "No file specified."
    exit
  fi

  if [ ! -e $file ] # no file
  then
    echo "File missing or not found."
    exit
  fi
}

# get date 
{
  #
  # tech@wrkstn txt2dayone $ stat -c %y empty.txt 
  # 2013-12-25 17:20:10.000000000 -0600
  # tech@wrkstn txt2dayone $ 
  #
  if [[ "$OSTYPE" == "linux-gnu" ]]
  then
    date=`stat -c %y $file `
  elif [[ "$OSTYPE" == "darwin"* ]]
  then
    # Example  
    #    > stat -f "%m%t%Sm %N" /tmp/* | sort -rn | head -3 | cut -f2-
    #    Apr 25 11:47:00 2002 /tmp/blah
    #    Apr 25 10:36:34 2002 /tmp/bar
    #    Apr 24 16:47:35 2002 /tmp/foo
    date=`stat -f "%m%t%Sm" $file | cut -f2-`
  else
    echo "Unknown OS.  Exiting."
    exit;
  fi
  echo "Date is: $date "
}

# import entry 
{
: <<DAYONEHELP

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

DAYONEHELP

  set -x			          # activate debugging from here

  if [ ! -z $EDITFILE ]; then
    echo "\$EDITFILE = '${EDITFILE}'"; exit
    open -nW -a byword $file 
  fi

  if [ ! -z $testmode ]
  then
    echo "testing"
    echo "dayone -d='${date}' new < ${file} ;"
  else
    echo "Live..."
    dayone -d="${date}" new < "${file}" ;
  fi
}
set -x			          # activate debugging from here

# Delete added files, including photo if present.
#
{
  if [ ! `which trash > /dev/null` ]
  # if [ -e /usr/local/bin/trash ]
  then
    # echo "error: $?"
    $testmode trash $file || echo "Failed to trash $file: $!"; 
  else
    # echo "error: $?"
    $testmode mv -v $file deleteme/
  fi
}


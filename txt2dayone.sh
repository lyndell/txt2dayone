#!/bin/bash -x
set -x			#  enable debugging 
set +x			# disable debugging 


# Variables
#

date=""
file=$1

: <<HELP

Exit code
---------

1. Not running on Mac OS X
2. File not specified
3. File not found

HELP

testmode='';
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  testmode='echo ';
elif [[ "$OSTYPE" != "darwin"* ]]
then
  echo "This is a Mac only script.  \nExiting."
  exit 1;
fi

# FUNCTIONS

# check for file
{
  if [ -z $file ]
  then
    echo "No file specified."
    exit 2
  fi

  if [ ! -e $file ] # no file
  then
    echo "File missing or not found."
    exit 3
  fi

  echo "File is: $file \n"
}

# get date 
{
  date=`stat -f "%m%t%Sm" $file | cut -f2-`
  echo "Date is: $date \n"
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

  $testmode dayone -d="${date}" $PHOTOSTR new < $file || echo "Error: $!"

}

# Delete added files, including photo if present.
#
{
  if [ ! `which trash > /dev/null` ]
  then
    # echo "error: $?"
    $testmode trash $file || echo "Failed to trash $file: $!"; 
  else
    # echo "error: $?"
    $testmode mv -v $file deleteme/
  fi
  echo "\n\n";
}


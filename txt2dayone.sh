#!/bin/bash -x
set -x			#  enable debugging 
set +x			# disable debugging 


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

# Check for corresponding phots, with same file name 
function getPhoto () {
  picfile="${file%%.*}.jpg"
  if [ -e $picfile ]
  then
    echo "yayh, JPEG!  We have a photo."
    photoCmd="-p=${picfile}"
  else
    photoCmd=""
    echo "No! no photo.   :-( "
  fi
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

  $testmode dayone -d="${date}" $PHOTOSTR new < $file ;

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
exit;


# START

getPhoto 



# checkTrash 


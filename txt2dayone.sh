#!/bin/bash -x

# Variables
#

date=""
file=$1

# test for commands with:
#   which stat > /dev/null
#

which stat > /dev/null
 
# make sure stat command is installed 
if [ $? -eq 1 ]
then
	echo "stat command not found!"
	exit 2
fi


# Check for journal entry
#
if [ -f $file ]
then
  echo " $file exists! "
fi

# Get date of file
#
#
# tech@wrkstn txt2dayone $ stat -c %y empty.txt 
# 2013-12-25 17:20:10.000000000 -0600
# tech@wrkstn txt2dayone $ 

#date=`stat -c %y $file `
date=`stat -t %y $file `
date=`stat -f "%m%t%Sm " $file | cut -f2-`
# Example  
#    > stat -f "%m%t%Sm %N" /tmp/* | sort -rn | head -3 | cut -f2-
#    Apr 25 11:47:00 2002 /tmp/blah
#    Apr 25 10:36:34 2002 /tmp/bar
#    Apr 24 16:47:35 2002 /tmp/foo
echo "Date is: $date "
exit;


# Check for corresponding phots, with same file name as
# entry
#

photoCmd=""

# # Test mode
#
# Print commands that will be run
# # Run mode
#
# Add jounral entry
#

exit;

if [ ! -e /usr/local/bin/dayone ]
# `which dayone` ]
then
  dayone  -d=\"${date}\" new < ${file} 
fi

# Delete added files, including photo if present.
#

if [ ! -e /usr/local/bin/trash ]
# `which trash` ]
then
  trash $file || echo "Failed to trash $file: $!"; 
fi

#/bin/bash -x

# Variables
#

date=""
file=$1

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

date=`stat -c %y $file `


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

dayone  -d=\"${date}\" new < ${file} 

# Delete added files, including photo if present.
#

trash $file || echo "Failed to trash $file: $!"; 

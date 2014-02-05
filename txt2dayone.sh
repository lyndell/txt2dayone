#/bin/bash -x

# Variables
#

date=""
file=""

# Check for journal entry
#
if [ -f $file ] then
  echo $file exists!
fi

# Check for corresponding phots, with same file name as
# entry
#
# # Test mode
#
# Print commands that will be run
#
#
#
# # Run mode
#
# Add jounral entry
#

dayone $photoCmd -d=\"${date}\" new < \"${file}\" 

# Delete added files, including photo if present.
#

trash $file || echo "Failed to trash $file: $!"; 


# FUNCTIONS

if [ $OSTYPE != "darwin*" ]
then
  echo "This is a Mac only script.  Sorry."
  testmode='echo '      # test mode ON
  echo "continuing in development mode"; # exit
fi

# make sure stat command is installed 
function checkstat () {
  which stat > /dev/null
  if [ $? -eq 1 ]
  then
    echo "stat command not found!"
    exit 2
  fi
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

checkstat
checkDayone

# createSymlink

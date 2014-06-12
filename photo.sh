
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


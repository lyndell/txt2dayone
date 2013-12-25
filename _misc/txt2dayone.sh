#!/usr/bin/bash -x
# 

use warnings;
use strict;

$DATE="Jan 1999";
$FILE="null";

#   Get file date
##  Mac
#
# stat -f "%Sm" empty.txt
#
#
#
##  Linux
#
# stat -c %y folding.URL
#
#
#


echo " dayone -d=\"$DATE\" new < $FILE \n"
exit;

dayone -d="$DATE" new < $file "

exit;
$dayoneman = <<DAYONE;

# Commands

new

  Adds a new entry
  using text from stdin

$ Options

-d,
–date=<date>

  Creation date of the entry. If
  not specified then the current date is used. This option
  accepts dates in most formats, including some natural
  language strings such as ’tomorrow’ and
  ’yesterday’. The systemâs locale is used
  when deciding how to parse a date. The date is parsed using
  -[NSDate dateWithNaturalLanguageString].


DAYONE:

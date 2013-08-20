#!/usr/bin/perl
# 

use warnings;
use strict;

my $date = "Jan 1999";
my $file = "null";


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

print " dayone -d=\"$date\" new < $file \n";
exit;

system(" dayone -d=\"$date\" new < $file ") or die $! ;

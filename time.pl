#!/usr/bin/perl
# 

use warnings;
use strict;



use POSIX qw(strftime);
my $date = strftime("%c\n", localtime(time));
print $date;

#!/usr/bin/perl
# 

use warnings;
use strict;
use POSIX qw(strftime);

my $testmode;
   $testmode = 1;  # on
   $testmode = 0;  # off
# print "TEST MODE.\n\n";
my $donedir = "_done";

my $arg;
foreach $arg (@ARGV) {
  exit 1;
  print "Not implimented yet.\n\n";
}

use File::Copy;

my $file;
foreach  $file (@ARGV) # comand line input.
{
  if ( -e $file )
  {

    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
           $atime,$mtime,$ctime,$blksize,$blocks);
    my $date ;

    ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks)
            = stat($file);

    $date =  strftime "%c", localtime($mtime);
    print "\n\n  $file  is dated:  $date \n";

    if ($testmode) {
      print  "dayone -d=\"$date\" new < \"$file\" \n";
    }
    else
    {
      system("dayone -d=\"$date\" new < \"$file\" ");
      if ( $? == -1 )
      {
        print "command failed: $!\n";
      }
      else
      {
        move($file,$donedir); # move files out of theway after import
        print "\nShell exit code ", $? >> 8 , "\n\n";
      }
    }

  }
  else {
    print "$file missing.  $!  \n\n"; 
  }
}


exit;



my $stathelp=<<'STATHELP';

  0 dev      device number of filesystem
  1 ino      inode number
  2 mode     file mode  (type and permissions)
  3 nlink    number of (hard) links to the file
  4 uid      numeric user ID of file's owner
  5 gid      numeric group ID of file's owner
  6 rdev     the device identifier (special files only)
  7 size     total size of file, in bytes
  8 atime    last access time in seconds since the epoch
  9 mtime    last modify time in seconds since the epoch
 10 ctime    inode change time in seconds since the epoch (*)
 11 blksize  preferred I/O size in bytes for interacting with the
             file (may vary from file to file)
 12 blocks   actual number of system-specific blocks allocated
             on disk (often, but not always, 512 bytes each)

STATHELP





my $dayone=<<'DAYONE';

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


DAYONE

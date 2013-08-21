#!/usr/bin/perl
# 

use warnings;
use strict;

my $testmode = 0;
my $arg;
foreach $arg (@ARGV) {
  if ($arg eq "-f") {
    print "Output file parameter not implimented yet.\n\n";
    # if the next one is empty...;
    exit 1;
  }
  if ($arg eq "-h" or $arg eq "--help") {
    print "Just give me some files.\n\n";
    exit;
  }
  if ($arg eq "-X") {
    print "Experimental.   ...and not implimented.\n\n";
    exit 1;
  }
  if ($arg eq "-t") {
    $testmode = 1;
    shift(@ARGV);  # assuming this parm is left most.  
    # Add at end and it detects, but is processed as a file, too.
    print "\nTest mode.\n\n\n";
  }
}

my $file;
foreach  $file (@ARGV) # comand line input.
{
  if ( -e $file ) {

    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
           $atime,$mtime,$ctime,$blksize,$blocks);
    my $date ;

    ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks)
            = stat($file);

    $date = $ctime;

    if ($testmode) {
      print  "dayone -d=$date new < $file \n";
    } else {
      system("dayone -d=$date new < $file ") or die ; #"woops!  " ; #. $! ;
    }

  } else {
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
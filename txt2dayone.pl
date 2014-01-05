#!/usr/bin/perl
# 

use warnings;
use strict;
use POSIX qw(strftime);

use File::Copy;
use Config;
use Getopt::Long;

sub setTestMode;
sub getFileDate;

my $testmode = 0;  # OFF, simpler iniitalizing here.
my   $osvar = $Config{osname};
my $archvar = $Config{archname};

my $help = 0;
my $helptext=<<'HELPTEXT';
  --help    This help page
  --test    Testmode: print the command, don't run it.
  --notext  Test mode off: actually run command and add to Day One
            journal.
HELPTEXT

GetOptions ('test!' => \$testmode,
            'help' => \$help);

setTestMode();
if ( $help ) { showhelp(); }

my $donedir = "_done";

my $file;
foreach  $file (@ARGV) # comand line input.
{
  my $date ;
  print "File: " . $file . "\n"; 
  if ( -e $file )
  {
    $date =  getFileDate($file);
    print "\n $file  is dated:  $date \n";
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
    showhelp();
  }
}

sub getFileDate() { # input parm is filename
  my $file = $_[0];
  print "file = " .$file;
  # exit;
  my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
         $atime,$mtime,$ctime,$blksize,$blocks);

  ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
      $atime,$mtime,$ctime,$blksize,$blocks)
          = stat($file);

  return  strftime "%c", localtime($mtime);
}


sub setTestMode {
  if ( ! $testmode ) {
    if ( $osvar eq "darwin" ) 
    {
       $testmode = 0;  # off
    }
    elsif ( $osvar eq "linux" ) 
    {
       $testmode = 1;  # on, can't run the Mac app here.
    }
    else
    {
      $testmode = 1;  # If all else failes, test mode
      print "What?!\nUnhandled OS configuration.\n";
      exit 1;
    }
  }
  if ( $testmode ) {
    print "      *******  TEST MODE ON!  *******  \n\n";
  }
  else
  {
    print "test mode OFF.\n\n";
  }
}

sub showhelp { print $helptext; exit 0;}

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

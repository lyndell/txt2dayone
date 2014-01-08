#!/usr/bin/perl
# 

use warnings;
use strict;
use POSIX qw(strftime);

use File::Copy;
use Config;
use Getopt::Long;
use File::Basename;

sub setTestMode;

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
  my $cmd = "";
  my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
         $atime,$mtime,$ctime,$blksize,$blocks);

  my $photo = "";       # empty string
  my ($base, $dir, $ext) ;

  ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
  $atime,$mtime,$ctime,$blksize,$blocks)
    = stat($file) or next; 
  if ( 0 ) 
  {
    print "$file not found.\n"; 
    next; 
  }

  $date =  strftime "%c", localtime($mtime);

  ($base, $dir, $ext) = fileparse($file);
  ($base, $ext) = split(/\./, $base); # seperate name from extention
  $photo = $base . ".PNG";      # TODO: what about other extensions?
  if ( -e $photo )                    # check for photo.
  {
    print "Photo " . $photo . " found; including.\n"; 
    $photo = " -p=\"$photo\"";
  }

  $cmd =  "dayone $photo -d=\"$date\" new < \"$file\" \n";
  if ($testmode) {
    print  "$cmd \n";
  }
  else
  {
    system( $cmd ) or die  "command failed: $!\n";
    move($file,$donedir); # move files out of the way after import
    print "\nShell exit code ", $? >> 8 , "\n\n";
  }
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

-p,
–photo-path=<path>

  File path to a photo to attach
  to entry. Most image formats are accepted. If any side of
  the image is greater than 1600 pixels then it will be
  resized. In all cases the image is converted to JPEG.

DAYONE

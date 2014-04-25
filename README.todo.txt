Sat Aug 24 11:44 2013  

See why my script just died.  It added the text right.

    nuclear-powered-brain:txt2dayone lyndell$ ./txt2dayone.pl  ../DayOne/money.txt 
    New entry : ~/Library/Mobile
    Documents/5U8NS4GX82~com~dayoneapp~dayone/Documents/Journal_dayone/entries/EC35CFD4C0604F8AA02588F93BC3BC25.doentry
    Died at ./txt2dayone.pl line 49.
    nuclear-powered-brain:txt2dayone lyndell$



Thu Aug 29 12:58:22 2013  

The code is already not quoting the date infomration.  If formated,it will
need to be quoted.

    system("dayone -d=$date new < $file ") or die("woops!  $!");



Fri Aug 30 11:55:44 2013

It works, finally and the date was processed right:

    nuclear-powered-brain:Dropbox lyndell$ Projects/txt2dayone/txt2dayone.pl  snippets\ for\ John\ Wheeler.txt 
      snippets for John Wheeler.txt  is dated:  Sun May 12 01:41:38 2013 
    New entry : ~/Library/Mobile Documents/5U8NS4GX82~com~dayoneapp~dayone/Documents/Journal_dayone/entries/77250131498C4AAB9EC3C2E4420E308C.doentry
    Shell exit code 0

    nuclear-powered-brain:Dropbox lyndell$



17/04/2014 22:56:15

Splitting checks into a setup file from the program.  The promgram should just run.

left check for trash command is it may not be installed on the Mac.

don't know what I'd do with that setup really.  just copy to the install/bin directory, or symlink

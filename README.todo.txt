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

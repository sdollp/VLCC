#!/usr/bin/expect -f
set timeout 600

set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];

spawn scp $arg2@$arg1:/home/rtp99/cif $arg4/script/
expect "*assword*" { send "$arg3\n" }
expect eof

spawn scp $arg2@$arg1:/home/rtp99/ltd $arg4/script/
expect "*assword*" { send "$arg3\n" }
expect eof


spawn scp $arg2@$arg1:/home/rtp99/tdcore $arg4/script/
expect "*assword*" { send "$arg3\n" }
expect eof

#!/usr/bin/expect -f
set timeout 10
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];

spawn bash -c "scp trace_int_cfx.sh $arg2@$arg1:/home/"
expect "*assword*" {send "$arg3\n"}
expect eof


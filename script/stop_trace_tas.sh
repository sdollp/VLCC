#!/usr/bin/expect -f
set timeout 300
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];

spawn ssh  $arg2@$arg1 -p 23
expect "*assword*" { send "$arg3\n" }
expect "*>*" {send  "memo stop $arg4\n"}
expect "*>*" {send "memo export $arg4\n"}
send -- "exit\n"
expect eof

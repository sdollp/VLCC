#!/usr/bin/expect -f
set timeout 6000 
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];

spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*>*" { send "cd /home\n"}
expect "*>*" {send "chmod 755 trace_int_cfx.sh\n" }
expect "*>*" {send  "./trace_int_cfx.sh\n"}
send -- "exit\n"
expect eof


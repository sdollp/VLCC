#!/usr/bin/expect -f
set timeout 6000 
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
set arg5 [lindex $argv 4];
set arg6 [lindex $argv 5];
set arg7 [lindex $argv 6];
set arg8 [lindex $argv 7];
set arg9 [lindex $argv 8];

spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*day*" {send "\n"}
expect "*vi):*" {send "\n"}
expect "*#*" { send "cd /storage\n" }
expect "*#*" {send "chmod 755 trace_stop.sh\n" }
expect "*#*" {send  "./trace_stop.sh $arg4 $arg5 $arg6 $arg7 $arg8 $arg9\n "}
send -- "exit\n"
expect eof


#!/usr/bin/expect -f
set timeout 300 
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
set arg5 [lindex $argv 4];
set arg6 [lindex $argv 5];
set arg7 [lindex $argv 6];
set arg8 [lindex $argv 7];
set arg9 [lindex $argv 9];
set arg10 [lindex $argv 10];

spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*day*" {send "\n"}
expect "*vi):*" {send "\n"}
expect "*#*" { send "su - lss\n"}
expect "*day*" {send "\n"}
expect "*vi):*" {send "\n"}
expect "*#*" { send "log_cli -t loglevel -v 4 -f active_only -t feph -p all -i all\n"}
send -- "exit\n"

spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*day*" {send "\n"}
expect "*vi):*" {send "\n"}
expect "*#*" { send "cd /storage\n"}
expect "*#*" { send ">progress.txt\n"}
expect "*#*" {send "chmod 755 trace_capture.sh\n" }
expect "*#*" {send  "./trace_capture.sh $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10\n"}
send -- "exit\n"
expect eof
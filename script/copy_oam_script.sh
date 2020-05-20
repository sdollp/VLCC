#!/usr/bin/expect -f
set timeout 30
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];


spawn bash -c "scp trace_capture.sh $arg2@$arg1:/storage/"
expect "*assword*" {send "$arg3\n"}
expect eof

spawn bash -c "scp trace_stop.sh $arg2@$arg1:/storage/"
expect "*assword*" {send "$arg3\n"}
expect eof
#!/usr/bin/expect -f
set timeout 60
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];

#log_file -noappend "../$arg4/LOGS/SBC_TRACE_START.LOG"

spawn ssh  root@$arg1
expect "*assword*" { send "$arg2\n" }
expect "*>*" { send "cd /home\n"}
expect "*>*" {send "ssh $arg3\n" }
expect "*assword*" {send "$arg2\n"}
expect "*>*" {send "killall -9 'tcpdump'\n"}
expect "*>*" { send "exit\n" }
expect "*>*" { send "exit\n"}
expect eof


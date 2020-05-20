#!/usr/bin/expect -f
set timeout 5
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
log_file -noappend process_id
spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*>*" { send "cd /home\n"}
expect "*>*" {send "ssh $arg4\n" }
expect "*assword*" { send "$arg3\n" }
expect "*>*" {send "ps -ef | grep 'tcpdump'\n"}
expect "*>*" { send "exit\n" }
expect "*>*" { send "exit\n" }
expect eof


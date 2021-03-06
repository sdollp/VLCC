#!/usr/bin/expect -f
set timeout 30
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
log_file TAS_PRE_CALL_SUBSDATA.txt
spawn ssh  $arg2@$arg1 -p 23
expect "*assword*" { send "$arg3\n" }
expect "*#*" {send "sdb subscriber show data --impu $arg4\n" }
send -- "exit\n"
expect eof

#!/usr/bin/expect -f
set timeout 600

set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
set arg5 [lindex $argv 4];
spawn sftp $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*>*" { send "cd storage\n"}
expect "*>*" { send "lcd /cygdrive\n"}
expect "*>*" { send "lcd c\n"}
expect "*>*" { send "lcd VLCC\n"}
expect "*>*" { send "get tas_pre_call_subsdata.txt\n"}
expect "*>*" { send "rm tas_pre_call_subsdata.txt\n"}
expect "*>*" { send "exit\n"}
expect eof
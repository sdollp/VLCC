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
expect "*>*" { send "cd troubleshooting\n"}
expect "*>*" { send "cd monitorings\n"}
expect "*>*" { send "lcd /cygdrive\n"}
expect "*>*" { send "lcd c\n"}
expect "*>*" { send "lcd VLCC\n"}
expect "*>*" { send "lcd $arg4$arg5\n"}
expect "*>*" { send "lcd TAS\n"}
expect "*>*" { send "get -r volte\n"}
expect "*>*" { send "cd volte\n"}
expect "*>*" { send "rm *\n"}
expect "*>*" { send "exit\n"}
expect eof
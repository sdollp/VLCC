#!/usr/bin/expect -f
set timeout 600

set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
set arg5 [lindex $argv 4];

spawn scp $arg2@$arg1:/var/tmp/trace.tar.gz $arg4/$arg5/MRF/
expect "*assword*" { send "$arg3\n" }
expect eof


spawn ssh $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*#*" { send "rm -f /tmp/trace.pcap /tmp/trace.tar.gz\n" }
send -- "exit\n"
expect eof

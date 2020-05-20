#!/usr/bin/expect -f
set timeout 60
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];

spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*>*" { send "cd /home\n"}
expect "*>*" {send "ssh $arg4\n" }
expect "*assword*" {send "$arg3\n"}
expect "*>*" {send "chmod +x /usr/sbin/tcpdump\n"}
expect "*>*" {send "nohup tcpdump -vvv -i any  -w /tmp/CFX_Trace.pcap >normal.log 2>/dev/null &\n"}
expect "*>*" { send "exit\n" }
expect "*>*" {send "exit\n" }
expect eof


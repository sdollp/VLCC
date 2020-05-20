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
expect "*>*" {send "killall -9 'tcpdump'\n"}
expect "*>*" { send "exit\n" }
expect "*>*" { send "mkdir TDCORE\n" }
expect "*>*" { send "mkdir TDCORE/${arg4}\n" }
expect "*>*" { send "scp root@$arg4:/tmp/${arg4}_TDCORE_TRACE.pcap /home/TDCORE/${arg4}/\n" }
expect "*assword*" { send "$arg3\n" }
expect "*>*" {send "ssh $arg4\n" }
expect "*assword*" {send "$arg3\n"}
expect "*>*" { send "rm -f /tmp/${arg4}_TDCORE_TRACE.pcap\n" }
expect "*>*" { send "exit\n" }
expect "*>*" { send "tar -czvf TDCORE.tar.gz TDCORE\n"}
expect "*>*" { send "exit\n"}
expect eof


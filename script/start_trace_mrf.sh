#!/usr/bin/expect -f
set timeout 60 
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
set arg5 [lindex $argv 4];

spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*#*" {send "nohup tcpdump -G $arg4 -W 1 -i any -n -N -s 0 -vvv -x -w /var/tmp/${arg5}_mrf.pcap  >normal.log 2>/dev/null &\n" }
send -- "exit\n"
expect eof


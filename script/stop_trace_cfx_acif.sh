#!/usr/bin/expect -f
set timeout 20
set arg1 [lindex $argv 0];
set arg2 [lindex $argv 1];
set arg3 [lindex $argv 2];
set arg4 [lindex $argv 3];
set arg5 [lindex $argv 4];
set arg6 [lindex $argv 5];
set arg7 [lindex $argv 6];
log_file ${arg7}/cif_trace_details
spawn ssh  $arg2@$arg1
expect "*assword*" { send "$arg3\n" }
expect "*>*" { send "cd /home\n"}
expect "*>*" {send "ssh $arg4\n" }
expect "*>*" {send "kill -2 $arg5\n"}
expect "*>*" {send "kill -9 $arg5\n"}
expect "*>*" { send "\n" }
expect "*>*" { send "\n" }
send_log "@!@"
send_log "############################ !CFX! #######################################"
expect "*>*" { send "ps -ef | grep 'tcpdump'\n" }
send_log "@!@"
expect "*>*" { send "exit\n" }
expect "*>*" { send "mkdir CIF\n" }
expect "*>*" { send "scp root@$arg4:/tmp/${arg6}_CIF.pcap /home/CIF/\n"}
expect "*>*" {send "ssh $arg4\n" }
expect "*>*" { send "rm -f /tmp/${arg6}_CIF.pcap\n" }
expect "*>*" { send "exit\n" }
expect "*>*" { send "tar -czvf CIF.tar.gz CIF\n" }
expect "*>*" { send "exit\n"}
expect eof


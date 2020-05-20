#!/bin/bash

user=$2
mrf_ip=$1
pwd=$3
tc_name=$6



/usr/bin/expect <<EOD
	spawn scp trace_stop_mrf.sh $user@$mrf_ip:
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD


/usr/bin/expect <<EOS


spawn ssh  $user@$mrf_ip
expect "*assword*" { send "$pwd\n" }
expect "*#*" {send  "chmod 755 trace_stop_mrf.sh\n"}
expect "*#*" {send  "./trace_stop_mrf.sh $tc_name\n"}
expect "*#*" {send "tar -czvf /var/tmp/MRF.tar.gz /var/tmp/${tc_name}_mrf.pcap\n"}
send -- "exit\n"
expect eof
EOS
#!/bin/bash
True="T"
oam_ip=$1
user=$2
pwd=$3
path=$4
folder=$5
cfed_status=$6
dfed_status=$7
bgc_status=$8
fw_status=$9
master_status=${10}
sc_status=${11}

if [[ "$cfed_status" == "$True" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$oam_ip:/storage/CFED/cfed25.tar.gz $path/$folder/SBC/CFED/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

if [[ "$dfed_status" == "$True" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$oam_ip:/storage/DFED/dfed25.tar.gz $path/$folder/SBC/DFED/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

if [[ "$bgc_status" == "$True" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$oam_ip:/storage/BGC/BGC.tar.gz $path/$folder/SBC/BGC/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

if [[ "$sc_status" == "$True" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$oam_ip:/storage/SC/SC.tar.gz $path/$folder/SBC/SC/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

if [[ "$fw_status" == "$True" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$oam_ip:/storage/FW/fw25.tar.gz $path/$folder/SBC/FW/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

if [[ "$master_status" == "$True" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$oam_ip:/export/home/lss/logs/master.tar.gz $path/$folder/SBC/MASTER/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

/usr/bin/expect <<EOD
spawn ssh $user@$oam_ip
expect "*assword*" { send "$pwd\n" }
expect "*day*" { send "\n" }
expect "*vi):*" {send "\n"}
expect "*#*" {send "cd /storage\n"}
expect "*#*" {send "rm -rf CFED DFED FW MASTER BGC SC\n"}
send -- "exit\n"
expect eof
EOD
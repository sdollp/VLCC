#!/bin/bash
True="T"
cif_ip=$1
user=$2
pwd=$3
path=$4
folder=$5
cif_status=$6
tdcore_status=$7
multi_ip=$8

if [[ "$multi_ip" == "F" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$cif_ip:/home/CIF.tar.gz $path/$folder/CFX/CIF/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
	/usr/bin/expect <<EOD
	spawn scp $user@$cif_ip:/home/L2TD.tar.gz $path/$folder/CFX/L2TD/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi

if [[ "$multi_ip" == "T" ]]; then
	/usr/bin/expect <<EOD
	spawn scp $user@$cif_ip:/home/CIF.tar.gz $path/$folder/CFX/CIF/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
	/usr/bin/expect <<EOD
	spawn scp $user@$cif_ip:/home/TDCORE.tar.gz $path/$folder/CFX/TDCORE/
	expect "*assword*" { send "$pwd\n" }
	expect eof
EOD
fi



# if [[ "$tdcore_status" == "$True" ]]; then
	# /usr/bin/expect <<EOD
	# spawn scp $user@$cif_ip:/home/TDCORE.tar.gz $path/$folder/CFX/TDCORE/
	# expect "*assword*" { send "$pwd\n" }
	# expect eof
# EOD
# fi

# if [[ "$cif_status" == "$True" ]]; then
	# /usr/bin/expect <<EOD
	# spawn scp $user@$cif_ip:/home/CIF.tar.gz $path/$folder/CFX/CIF/
	# expect "*assword*" { send "$pwd\n" }
	# expect eof
# EOD
# fi

/usr/bin/expect <<EOD
spawn ssh $user@$cif_ip
expect "*assword*" { send "$pwd\n" }
expect "*>*" { send "cd /home\n" }
expect "*>*" { send "rm -rf CIF TDCORE L2TD\n" }
send -- "exit\n"
expect eof
EOD

#!/bin/bash
True="T"
cfed_status=$1
dfed_status=$2
bgc_status=$3
fw_status=$4
master_status=$5
sc_status=$6


if [[ "$cfed_status" == "$True" ]]; then
        mkdir CFED
        cfed=$(lcp_status | grep -i 'CFED.*ENABLEDUNLOCKED' | awk '{print $5}')
        if [ "$cfed" == "ENABLEDUNLOCKED" ]
        then
               cfed=$(lcp_status | grep -i 'CFED.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$cfed" > vm_status
        ssh $cfed << EOF
        
        echo
        echo
        echo
        echo
        processID=\$(ps -ef | grep -m1 "cfed25" | awk '{print \$2}')
        echo
        echo
        
        echo
		kill -2 \$processID
		echo 
		echo
		sleep 2s
        kill -9 \$processID            
        echo
        echo
        echo
        sleep 5s
        
EOF
        echo "#########################COPYING CFED FILE#########################"
        scp $cfed:/storage/cfed25.pcap /storage/CFED/
        tar -czvf /storage/CFED/cfed25.tar.gz CFED/* --warning=no-file-changed
        ssh $cfed "rm -rf /storage/cfed25.pcap"
fi

if [[ "$dfed_status" == "$True" ]]; then
        mkdir DFED
        dfed=$(lcp_status | grep -i 'DFED.*ENABLEDUNLOCKED' | awk '{print $5}')
        if [ "$dfed" == "ENABLEDUNLOCKED" ]
        then
               dfed=$(lcp_status | grep -i 'DFED.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$dfed" > vm_status
        dfed=$(cat vm_status | head -n 1)
        ssh $dfed << EOF
        
        echo
        echo
        echo
        echo
        processID=\$(ps -ef | grep -m1 "dfed25" | awk '{print \$2}')
        echo
        echo
        echo
        echo
		kill -2 \$processID
		echo 
		echo
		sleep 2s
        kill -9 \$processID       
        echo
        echo
        echo
        sleep 5s
EOF
        echo "#########################COPYING DFED FILE#########################"
        scp $dfed:/storage/dfed25.pcap /storage/DFED/
        tar -czvf /storage/DFED/dfed25.tar.gz DFED/* --warning=no-file-changed
        ssh $dfed "rm -rf /storage/dfed25.pcap"

fi

if [[ "$fw_status" == "$True" ]]; then
        mkdir FW
        fw=$(lcp_status | grep -i 'FEPH.*ENABLEDUNLOCKED' | awk '{print $5}')
        if [ "$fw" == "ENABLEDUNLOCKED" ]
        then
               fw=$(lcp_status | grep -i 'FEPH.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$fw" > vm_status
        fw=$(cat vm_status | head -n 1)
        ssh $fw << EOF
        
        echo
        echo
        echo
        echo
        processID=\$(ps -ef | grep -m1 "fw25" | awk '{print \$2}')
        echo
        echo
        echo
        echo
		kill -2 \$processID
		echo 
		echo
		sleep 2s
        kill -9 \$processID      
        echo
        echo
        echo
        sleep 5s
EOF
        echo "#########################COPYING FW FILE#########################"
        scp $fw:/storage/fw25.pcap /storage/FW/
        tar -czvf /storage/FW/fw25.tar.gz FW/* --warning=no-file-changed
        ssh $fw "rm -rf /storage/fw25.pcap"
fi

if [[ "$bgc_status" == "$True" ]]; then
       mkdir BGC
        cat bgc_status | while read line
        do
        ssh $line << EOF
                echo
                echo
                echo
                echo
                processID=\$(ps -ef | grep -m1 $line | awk '{print \$2}')
                echo
                echo
                echo
                echo
				kill -2 \$processID
				echo 
				echo
				sleep 2s
                kill -9 \$processID
        	    # killall -9 tcpdump
                echo
                echo
                echo
                sleep 5s
EOF
done

echo
echo
echo "#########################COPYING BGC FILE#########################"
cat bgc_status | while read line
do
        scp $line:/storage/bgw${line}.pcap /storage/BGC/

done
tar -czvf /storage/BGC/BGC.tar.gz BGC/* --warning=no-file-changed

cat bgc_status | while read line
do
        ssh $line "rm -rf /storage/bgw${line}.pcap"


done
fi


if [[ "$sc_status" == "$True" ]]; then
        mkdir SC
        cat sc_status | while read line
        do
        ssh $line << EOF
                echo
                echo
                echo
                echo
                processID=\$(ps -ef | grep -m1 $line | awk '{print \$2}')
                echo
                echo
                echo
                echo
				kill -2 \$processID
				echo 
				echo
				sleep 2s
                kill -9 \$processID
                # killall -9 tcpdump
                echo
                echo
                echo
                sleep 5s
EOF
done

echo
echo
echo "#########################COPYING SC FILE#########################"
cat sc_status | while read line
do
        scp $line:/storage/sc${line}.pcap /storage/SC/

done
tar -czvf /storage/SC/SC.tar.gz SC/* --warning=no-file-changed

cat sc_status | while read line
do
        ssh $line "rm -rf /storage/sc${line}.pcap"


done
fi



sleep 5s
if [[ "$master_status" == "$True" ]]; then
        mkdir MASTER
        echo 
        echo
        echo
        echo "#########################COPYING MASTER.log FILE#########################"
        tar -czvf /export/home/lss/logs/master.tar.gz /export/home/lss/logs/master.log --warning=no-file-changed
fi






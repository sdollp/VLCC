#!/bin/bash
True="T"
cfed_status=$1
dfed_status=$2
bgc_status=$3
fw_status=$4
master_status=$5
sc_status=$6
tc_name=$7

touch /storage/sbc_trace_details

> /storage/sbc_trace_details

if [[ "$cfed_status" == "$True" ]]; then
        mkdir CFED
        
        cfed=$(cat vm_status | head -n 1)
        #echo "$cfed" > vm_status
        ssh $cfed >> /storage/sbc_trace_details << EOF
        
        echo
        echo
        echo
        echo
        processID=\$(ps -ef | grep -m1 $tc_name | awk '{print \$2}')
        echo
        kill -2 \$processID
        echo
        
        echo
        kill -9 \$processID         
	   echo
	   sleep 2s
        echo
        echo "@!@"
        echo
        echo "############################   !SBC-CFED! #######################################"
        ps -ef | grep tcpdump
        echo
        echo "@!@"
        echo

        sleep 5s
        
EOF
        echo "#########################COPYING CFED FILE#########################"
        scp $cfed:/storage/${tc_name}_cfed.pcap /storage/CFED/
        tar -czvf /storage/CFED/cfed.tar.gz CFED/* --warning=no-file-changed
        ssh $cfed "rm -rf /storage/${tc_name}_cfed.pcap"
fi




if [[ "$dfed_status" == "$True" ]]; then
        mkdir DFED
        
        dfed=$(cat vm_status | head -n 2 | tail -n 1)
        ssh $dfed >> /storage/sbc_trace_details << EOF
        
        echo
        echo
        echo
        echo
        processID=\$(ps -ef | grep -m1 $tc_name | awk '{print \$2}')
        echo
        kill -2 \$processID
        echo
        echo
        echo
        kill -9 \$processID       
        echo
	    echo
	    sleep 2s
        echo
        echo "@!@"
        echo
        echo "############################   !SBC-DFED! #######################################"
        ps -ef | grep tcpdump
        echo
        echo "@!@"
        sleep 5s
EOF
        echo "#########################COPYING DFED FILE#########################"
        scp $dfed:/storage/${tc_name}_dfed.pcap /storage/DFED/
        tar -czvf /storage/DFED/dfed.tar.gz DFED/* --warning=no-file-changed
        ssh $dfed "rm -rf /storage/${tc_name}_dfed.pcap"

fi

if [[ "$fw_status" == "$True" ]]; then
        mkdir FW
       
        fw=$(cat vm_status | head -n 3 | tail -n 1)
        ssh $fw >> /storage/sbc_trace_details << EOF
        
        echo
        echo
        echo
        echo
        processID=\$(ps -ef | grep -m1 $tc_name | awk '{print \$2}')
        echo
        echo
        kill -2 \$processID
        echo
        echo
        kill -9 \$processID      
        echo
	    echo
	    sleep 5s
        echo
        echo "@!@"
        echo
        echo "############################   !SBC-FW! #######################################"
        ps -ef | grep tcpdump
        echo
        echo "@!@"
        echo
       
EOF
        echo "#########################COPYING FW FILE#########################"
        scp $fw:/storage/${tc_name}_fw.pcap /storage/FW/
        tar -czvf /storage/FW/fw.tar.gz FW/* --warning=no-file-changed
        ssh $fw "rm -rf /storage/${tc_name}_fw.pcap"
fi

if [[ "$bgc_status" == "$True" ]]; then
       mkdir BGC
        cat bgc_status | while read line
        do
        ssh $line >> /storage/sbc_trace_details << EOF
                echo
                echo
                echo
                echo
                processID=\$(ps -ef | grep -m1 $line | awk '{print \$2}')
                echo
                echo
                kill -2 \$processID
                echo
                echo
                kill -9 \$processID
        	    # killall -9 tcpdump
                echo
		        echo
		        sleep 5s
                echo
                echo "@!@"
                echo
                echo "############################   !SBC-BGC! #######################################"
                ps -ef | grep tcpdump
                echo
                echo
                echo "@!@"
                echo
               
EOF
done

echo
echo
echo "#########################COPYING BGC FILE#########################"
cat bgc_status | while read line
do
        scp $line:/storage/${tc_name}_bgw_${line}.pcap /storage/BGC/

done
tar -czvf /storage/BGC/BGC.tar.gz BGC/* --warning=no-file-changed

cat bgc_status | while read line
do
        ssh $line "rm -rf /storage/${tc_name}_bgw_${line}.pcap"


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
                processID=\$(ps -ef | grep -m1 $tc_name | awk '{print \$2}')
                echo
                echo
                kill -2 \$processID
                echo
                echo
                kill -9 \$processID
                # killall -9 tcpdump
                echo
                echo
	           	echo
                echo
                sleep 5s
                echo "@!@"
		        echo
		        echo "############################   !SBC-SC! #######################################"
		        ps -ef | grep tcpdump
		        echo
                echo "@!@"


EOF
done

echo
echo
echo "#########################COPYING SC FILE#########################"
cat sc_status | while read line
do
        scp $line:/storage/${tc_name}_sc_${line}.pcap /storage/SC/

done
tar -czvf /storage/SC/SC.tar.gz SC/* --warning=no-file-changed

cat sc_status | while read line
do
        ssh $line "rm -rf /storage/${tc_name}_sc_${line}.pcap"


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






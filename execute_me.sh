#!/bin/bash


start_trace_sbc()
{

	echo "################################################################################"
	echo
	echo
	echo " 			STARTING TRACE FOR SBC				"
	echo
	echo
	echo "################################################################################"
    echo
	sleep 7s
	echo
	echo
	echo 

	path=${10}
	folder=$1
	oam_ip=$2
	user=$3
	pwd=$4
	cfed_status=$5
	dfed_status=$6
	bgc_status=$7
	fw_status=$8
	sc_status=$9
	cd script
	./copy_oam_script.sh $oam_ip $user $pwd
	./start_trace_sbc.sh $oam_ip $user $pwd $cfed_status $dfed_status $bgc_status $fw_status $sc_status $path
	cd ..
	echo 'T' >> status.txt
    
}

stop_trace_sbc()
{

	echo "################################################################################"
	echo
	echo
	echo " 			STOPPING TRACE FOR SBC				"
	echo
	echo
	echo "################################################################################"
        echo
		
	sleep 7s
	echo

	path=${11}
	folder=$1
    oam_ip=$2
	user=$3
	pwd=$4
	cfed_status=$5
	dfed_status=$6
	bgc_status=$7
	fw_status=$8
	master_status=$9
	sc_status=${10}
	cd $folder
	mkdir SBC
	cd SBC
	if [[ "$cfed_status" == "T" ]]; then	
		mkdir CFED
	fi
	if [[ "$dfed_status" == "T" ]]; then	
		mkdir DFED
	fi
	if [[ "$fw_status" == "T" ]]; then	
		mkdir FW
	fi
	if [[ "$bgc_status" == "T" ]]; then	
		mkdir BGC
	fi
	if [[ "$master_status" == "T" ]]; then	
		mkdir MASTER
	fi
	if [[ "$sc_status" == "T" ]]; then	
		mkdir SC
	fi
	
	cd ..
	cd ..

	cd script
	./stop_trace_sbc.sh $oam_ip $user $pwd $cfed_status $dfed_status $bgc_status $fw_status $master_status $sc_status
	sleep 5s 
	./ship_pcap_files.sh $oam_ip $user $pwd $path $folder $cfed_status $dfed_status $bgc_status $fw_status $master_status $sc_status
	cd ..
	
}


start_trace_mrf()
{
	echo "################################################################################"
	echo
	echo "			STARTING TRACE FOR MRF					"
	echo
	echo
	echo "################################################################################"
	echo
	sleep 7s
	echo
	
	folder=$1
    mrf_ip=$2
	user=$3
	pwd=$4
	cd script
	
	./start_trace_mrf.sh $mrf_ip $user $pwd 

	cd ..
	echo 'T' >> status.txt

}




stop_trace_mrf()
{
	echo "################################################################################"
	echo
	echo
	echo " 			STOPPING TRACE FOR MRF				"
	echo
	echo
	echo "################################################################################"
        echo
	sleep 7s
	echo

	 path="/drives/c/VLCC"
	 folder=$1
	 mrf_ip=$2
	 user=$3
	 pwd=$4
	 cd $folder
	 mkdir MRF 
	 cd ..
	 cd script
         ./stop_trace_mrf.sh $mrf_ip $user $pwd $path $folder
         ./ship_pcap_files_mrf.sh $mrf_ip $user $pwd $path $folder
         cd ..




}

start_trace_cfx()
{
	echo "################################################################################"
	echo
	echo
	echo " 			STARTING TRACE FOR CFX			"
	echo
	echo
	echo "################################################################################"
        echo
	sleep 7s
	echo

	path="/drives/c/VLCC"
	folder=$1
	cif_ip=$2
	user=$3
	pwd=$4
	cif_status=$5
	tdcore_status=$6
	multi_ip=$7

	cd script
	./copy_cfx_script.sh $cif_ip $user $pwd
	./start_trace_cfx.sh $cif_ip $user $pwd $path $folder
	./copy_ip_cfx.sh $cif_ip $user $pwd $path 
	chmod 755 *
	
	if [[ "$multi_ip" == "F" ]]; then	
		cif_act=$(cat cif)
		./start_trace_cfx_acif.sh $cif_ip $user $pwd $cif_act
		ltd=$(cat ltd)
		./start_trace_cfx_l2td.sh $cif_ip $user $pwd $ltd
	fi
	
	if [[ "$multi_ip" == "T" ]]; then
		cif_act=$(cat cif)
		./start_trace_cfx_acif.sh $cif_ip $user $pwd $cif_act
		cat tdcore | while read line 
		do
	   
		echo
		echo
		echo
		echo
			./start_trace_cfx_tdcore.sh $cif_ip $user $pwd $line
		
		done
		
	fi

	# if [[ "$cif_status" == "T" ]]; then	
		# cif_act=$(cat cif)
		# ./start_trace_cfx_acif.sh $cif_ip $user $pwd $cif_act
	# fi
	
	# if [[ "$l2td_status" == "T" ]]; then	
		# ltd=$(cat ltd)
		# ./start_trace_cfx_l2td.sh $cif_ip $user $pwd $ltd
	# fi
	
	
	# if [[ "$tdcore_status" == "T" ]]; then
		# cat tdcore | while read line 
		# do
	   
		# echo
		# echo
		# echo
		# echo
			# ./start_trace_cfx_tdcore.sh $cif_ip $user $pwd $line
		
		# done
	# fi
	cd ..
	echo 'T' >> status.txt

}


stop_trace_cfx()
{
	echo "################################################################################"
	echo
	echo
	echo " 			STOPPING TRACE FOR CFX			"
	echo
	echo
	echo "################################################################################"
        echo
	sleep 7s
	echo

	path="/drives/c/VLCC"
	folder=$1
    cif_ip=$2
	user=$3
	pwd=$4
	cif_status=$5
	tdcore_status=$6
	multi_ip=$7
	cd $folder
	mkdir CFX
	#cd CFX
	
	chmod 755 *
	
	if [[ "$multi_ip" == "F" ]]; then
		cd CFX
		mkdir CIF
		mkdir L2TD
		cd ..
		cd ..
		cd script
		cif_act=$(cat cif)
		./stop_trace_cfx_acif.sh $cif_ip $user $pwd $cif_act
		ltd=$(cat ltd)
		./stop_trace_cfx_l2td.sh $cif_ip $user $pwd $ltd
		cd ..
		cd $folder
		
	fi
	
	if [[ "$multi_ip" == "T" ]]; then
		cd CFX
		mkdir CIF
		mkdir TDCORE
		cd ..
		cd ..
		cd script
		cif_act=$(cat cif)
		./stop_trace_cfx_acif.sh $cif_ip $user $pwd $cif_act
		cat tdcore | while read line
		do 
		echo

		./stop_trace_cfx_tdcore.sh $cif_ip $user $pwd $line
		echo
		echo
		done
	fi
	
	
	# if [[ "$cif_status" == "T" ]]; then	
		# cd CFX
		# mkdir CIF
		# cd ..
		# cd ..
		# cd script
		# cif_act=$(cat cif)
		# ./stop_trace_cfx_acif.sh $cif_ip $user $pwd $cif_act
		# cd ..
		# cd $folder
	# fi
	# if [[ "$cif_status" == "T" ]]; then	
		# cd CFX
		# mkdir L2TD
		# cd ..
		# cd ..
		# cd script
		# ltd=$(cat ltd)
		# ./stop_trace_cfx_l2td.sh $cif_ip $user $pwd $ltd
		# cd ..
		# cd $folder
	# fi

	# if [[ "$tdcore_status" == "T" ]]; then
		# cd CFX	
		# mkdir TDCORE
		# cd ..
		# cd ..
		# cd script
		# cat tdcore | while read line
		# do 
		# echo

		# ./stop_trace_cfx_tdcore.sh $cif_ip $user $pwd $line
		# echo
		# echo
		# done
	# fi
	cd ..
	cd script
	sleep 5s 
	./ship_pcap_files_cfx.sh $cif_ip $user $pwd $path $folder $cif_status $tdcore_status $multi_ip
	cd ..
	

}


start_trace_tas()
{
	echo "################################################################################"
	echo
	echo "			STARTING TRACE FOR TAS					"
	echo
	echo
	echo "################################################################################"
	echo
	sleep 7s
	echo
	
	path="/drives/c/VLCC"
	folder=$1
    tas_ip=$2
	user=$3
	pwd="$4"
	command="$5"
	precall_subs_data=$6
	grep 'TAS_IMPU' edit_me.txt | cut -d " " -f 2 > script/tas_impu
	
	cd script
	touch TAS_PRE_CALL_SUBSDATA.txt
	chmod 755 tas_impu TAS_PRE_CALL_SUBSDATA.txt
        True="T"
	if [ "$precall_subs_data" = "T" ]
        then
	
		cat tas_impu | while read line 
		do
	   
		echo
		echo
		echo
		echo
		
			./get_precall_subdata_tas.sh $tas_ip $user $pwd $line
		
		done

	fi

	# GET PRE_CALL SUBS DATA FILE TO LOCAL SYSTEM

	#./ship_precall_subdata_tas.sh $tas_ip $user $pwd $path $folder

	./start_trace_tas.sh $tas_ip $user $pwd $command

	cd ..
	echo 'T' >> status.txt

}



stop_trace_tas()
{
	echo "################################################################################"
	echo
	echo
	echo " 			STOPPING TRACE FOR TAS				"
	echo
	echo
	echo "################################################################################"
    echo
	sleep 7s
	echo

	 path="/drives/c/VLCC/"
	 folder=$1
	 tas_ip=$2
	 user=$3
	 pwd="$4"
	 command="$5"
	 postcall_subs_data=$6
	 cd $folder
	 mkdir TAS
	 cd ..

	 cd script
	
          touch TAS_POST_CALL_SUBSDATA.txt

         ./stop_trace_tas.sh $tas_ip $user $pwd $command
         ./ship_pcap_files_tas.sh $tas_ip $user $pwd $path $folder

        chmod 755 tas_impu TAS_POST_CALL_SUBSDATA.txt
        True="T"
		if [ "$postcall_subs_data" = "T" ]
        then
	
			cat tas_impu | while read line 
			do
	   
			echo
			echo
			echo
			echo
		
				./get_postcall_subdata_tas.sh $tas_ip $user $pwd $line
		
			done

		fi
		chmod 755 *
         cd ..
         mkdir $folder/TAS/SUBS_DATA
         mv script/TAS_PRE_CALL_SUBSDATA.txt $folder/TAS/SUBS_DATA
         mv script/TAS_POST_CALL_SUBSDATA.txt $folder/TAS/SUBS_DATA
}


Main()
{
	start=`date +%s`
	dos2unix edit_me.txt
	SBC=$(grep -m 1 -w 'SBC' edit_me.txt | cut -d "=" -f 2)
	CFX=$(grep -m 1 -w 'CFX' edit_me.txt | cut -d "=" -f 2)
	TAS=$(grep -m 1 -w 'TAS' edit_me.txt | cut -d "=" -f 2)
	MRF=$(grep -m 1 -w 'MRF' edit_me.txt | cut -d "=" -f 2)
	DIR=$(grep -m 1 -w 'PATH' edit_me.txt | cut -d "=" -f 2)
	
	sleep 2s
	True="T"
	touch status.txt
	count=0
	
	if [[ "$SBC" == "$True" ]]; then
		count=$(( $count + 1 ))
	fi
	if [[ "$MRF" == "$True" ]]; then
		count=$(( $count + 1 ))
	fi
	if [[ "$TAS" == "$True" ]]; then
		count=$(( $count + 1 ))
	fi
	if [[ "$CFX" == "$True" ]]; then
		count=$(( $count + 1 ))
	fi
		
	#echo "Count $count"
		
	echo "################################################################################"
	echo
	echo
	echo " 			TRACE CAPTURE TOOL				"
	echo
	echo
	echo "################################################################################"
        echo
	echo


	#read -p "Enter 1 to Start Trace, Enter 2 to Stop Trace :  " ch
	dos2unix *.sh
	dos2unix script/*
	chmod 755 script/*
	folder=$(date +%d_%b_%Y_%H_%M_%S)"_TC_Name_"$2
	#mkdir $folder
	
	if [ $3 == "start" ]
	then
		echo "Trace Capture Initiated wait till it get's started"
		echo "***************************************************"
		echo
		echo
		
		if [[ "$SBC" == "$True" ]]; then
			SBC_IP=$(grep -m2 -w 'SBC_IP' edit_me.txt | cut -d "=" -f 2)
			SBC_USER=$(grep -m2 -w 'SBC_USER' edit_me.txt | cut -d "=" -f 2)
			SBC_PASSWORD=$(grep -m2 -w 'SBC_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			CFED=$(grep -m 1 -w 'SBC_CFED_PCAP' edit_me.txt | cut -d "=" -f 2)
			DFED=$(grep -m 1 -w 'SBC_DFED_PCAP' edit_me.txt | cut -d "=" -f 2)
			BGC=$(grep -m 1 -w 'SBC_BGC_PCAP' edit_me.txt | cut -d "=" -f 2)
			FW=$(grep -m 1 -w 'SBC_FW_PCAP' edit_me.txt | cut -d "=" -f 2)
			SC=$(grep -m 1 -w 'SBC_SC_PCAP' edit_me.txt | cut -d "=" -f 2)
			echo -e "SBC Trace is \e[1;32m applicable\e[0m to below"
			#echo "SBC=T"
			grep -i 'SBC_.*=T' edit_me.txt
			echo "*********************************"
			echo
			start_trace_sbc $folder $SBC_IP $SBC_USER $SBC_PASSWORD $CFED $DFED $BGC $FW $SC $DIR > sbc.log &
			
			#echo "SBC Trace is enabled"
		else 
			echo -e "SBC Trace is \e[1;31m Not applicable\e[0m"
			echo "*********************************"
			echo
		fi 
		end=`date +%s`
		#echo "Trace Capture Started for SBC",$((end-start))
		
		if [[ "$TAS" == "$True" ]]; then
			TAS_IP=$(grep -m2 -w 'TAS_IP' edit_me.txt | cut -d "=" -f 2)
			TAS_USER=$(grep -m2 -w 'TAS_USER' edit_me.txt | cut -d "=" -f 2)
			TAS_PASSWORD=$(grep -m2 -w 'TAS_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			TAS_COMMAND=$(grep -m2 -w 'TAS_COMMAND' edit_me.txt | cut -d "=" -f 2)
			TAS_SUBS_DATA=$(grep -m2 -w 'GETSUBSDATA_TAS' edit_me.txt | cut -d "=" -f 2)
			echo -e "TAS Trace is \e[1;32m applicable\e[0m"
			#echo "TAS=T"
			grep -i 'TAS_.*=T' edit_me.txt
			echo "*********************************"
			echo
			start_trace_tas $folder $TAS_IP $TAS_USER $TAS_PASSWORD $TAS_COMMAND $TAS_SUBS_DATA > tas.log &
			#echo "TAS Trace is Enabled "
		else 
			echo -e "TAS Trace is \e[1;31m Not applicable\e[0m"
			echo "*********************************"
			echo
		fi 

		if [[ "$MRF" == "$True" ]]; then
			MRF_IP=$(grep -m2 -w 'MRF_IP' edit_me.txt | cut -d "=" -f 2)
			MRF_USER=$(grep -m2 -w 'MRF_USER' edit_me.txt | cut -d "=" -f 2)
			MRF_PASSWORD=$(grep -m2 -w 'MRF_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			echo -e "MRF Trace is \e[1;32m applicable\e[0m"
			#echo "MRF=T"
			grep -i 'MRF_.*=T' edit_me.txt
			echo "*********************************"
			echo
			start_trace_mrf $folder $MRF_IP $MRF_USER $MRF_PASSWORD > mrf.log &
			#echo "MRF Trace is Enabled "
		else 
			echo -e "MRF Trace is \e[1;31m Not applicable\e[0m"
			echo "*********************************"
			echo
		fi 

		if [[ "$CFX" == "$True" ]]; then
			CFX_IP=$(grep -m2 -w 'CFX_IP' edit_me.txt | cut -d "=" -f 2)
			CFX_USER=$(grep -m2 -w 'CFX_USER' edit_me.txt | cut -d "=" -f 2)
			CFX_PASSWORD=$(grep -m2 -w 'CFX_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			MULTI_IP=$(grep -m2 -w 'Multi_IP' edit_me.txt | cut -d "=" -f 2)
			CIF=$(grep -m 1 -w 'CFX_CIF_PCAP' edit_me.txt | cut -d "=" -f 2)
			TDCORE=$(grep -m 1 -w 'CFX_TDCORE_PCAP' edit_me.txt | cut -d "=" -f 2)
			echo -e "CFX Trace is \e[1;32m applicable\e[0m to below VM's"
			#echo "CFX=T"
			grep -i 'CFX_.*=T' edit_me.txt
			echo "*********************************"
			echo
			start_trace_cfx $folder $CFX_IP $CFX_USER $CFX_PASSWORD $CIF $TDCORE $MULTI_IP > cfx.log &
			#echo "CFX Trace is Enabled "
		else 
			echo -e "CFX Trace is \e[1;31m Not applicable\e[0m"
		fi 

		echo -e "\e[1;33m                               Below points to be remembered\e[0m"
		echo "###############################################################################################"
		echo "1) Trace once started needs to be stopped"
		echo -e "2) If\e[1;33m Ctrl+C\e[0m pressed in between make sure you stop the trace capture by running bellow command"
		echo -e "   \e[1;32m ./execute_me.sh <pass_key> <test_case_name> stop\e[0m"
		echo "###############################################################################################"
		end=`date +%s`
		#echo "All Trace Capture Started",$((end-start))
		echo 
			
		while true
		do
			line_count=$(wc -l < status.txt)
			if [[ "$line_count" == "$count" ]]; then
				> status.txt
				echo "Trace Capture Started"
				exit
			fi
			sleep 5
		done

	elif [ $3 == "stop" ]
	then
		mkdir $folder

		if [[ "$SBC" == "$True" ]]; then
			SBC_IP=$(grep -m2 -w 'SBC_IP' edit_me.txt | cut -d "=" -f 2)
			SBC_USER=$(grep -m2 -w 'SBC_USER' edit_me.txt | cut -d "=" -f 2)
			SBC_PASSWORD=$(grep -m2 -w 'SBC_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			CFED=$(grep -m 1 -w 'SBC_CFED_PCAP' edit_me.txt | cut -d "=" -f 2)
			DFED=$(grep -m 1 -w 'SBC_DFED_PCAP' edit_me.txt | cut -d "=" -f 2)
			BGC=$(grep -m 1 -w 'SBC_BGC_PCAP' edit_me.txt | cut -d "=" -f 2)
			FW=$(grep -m 1 -w 'SBC_FW_PCAP' edit_me.txt | cut -d "=" -f 2)
			MASTER=$(grep -m 1 -w 'SBC_MASTER_LOG' edit_me.txt | cut -d "=" -f 2)
			SC=$(grep -m 1 -w 'SBC_SC_PCAP' edit_me.txt | cut -d "=" -f 2)
			stop_trace_sbc $folder $SBC_IP $SBC_USER $SBC_PASSWORD $CFED $DFED $BGC $FW $MASTER $SC $DIR
		else 
			echo -e "SBC Trace is \e[1;31m Not applicable\e[0m"
		fi

		end=`date +%s`
		echo "Trace Capture Stoped for SBC",$((end-start))

		if [[ "$TAS" == "$True" ]]; then
			TAS_IP=$(grep -m2 -w 'TAS_IP' edit_me.txt | cut -d "=" -f 2)
			TAS_USER=$(grep -m2 -w 'TAS_USER' edit_me.txt | cut -d "=" -f 2)
			TAS_PASSWORD=$(grep -m2 -w 'TAS_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			TAS_COMMAND=$(grep -m2 -w 'TAS_COMMAND' edit_me.txt | cut -d "=" -f 2)
			TAS_SUBS_DATA=$(grep -m2 -w 'GETSUBSDATA_TAS' edit_me.txt | cut -d "=" -f 2)
			TAS_SUBS_DATA=$(grep -m2 -w 'GETSUBSDATA_TAS' edit_me.txt | cut -d "=" -f 2)
			stop_trace_tas $folder $TAS_IP $TAS_USER $TAS_PASSWORD $TAS_COMMAND $TAS_SUBS_DATA
		else 
			echo -e "TAS Trace is \e[1;31m Not applicable\e[0m"
		fi 

		if [[ "$MRF" == "$True" ]]; then
			MRF_IP=$(grep -m2 -w 'MRF_IP' edit_me.txt | cut -d "=" -f 2)
			MRF_USER=$(grep -m2 -w 'MRF_USER' edit_me.txt | cut -d "=" -f 2)
			MRF_PASSWORD=$(grep -m2 -w 'MRF_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			stop_trace_mrf $folder $MRF_IP $MRF_USER $MRF_PASSWORD 
		else 
			echo -e "MRF Trace is \e[1;31m Not applicable\e[0m"
		fi 

		if [[ "$CFX" == "$True" ]]; then
			CFX_IP=$(grep -m2 -w 'CFX_IP' edit_me.txt | cut -d "=" -f 2)
			CFX_USER=$(grep -m2 -w 'CFX_USER' edit_me.txt | cut -d "=" -f 2)
			CFX_PASSWORD=$(grep -m2 -w 'CFX_PASSWORD' edit_me.txt | cut -d "=" -f 2)
			CIF=$(grep -m 1 -w 'CFX_CIF_PCAP' edit_me.txt | cut -d "=" -f 2)
			TDCORE=$(grep -m 1 -w 'CFX_TDCORE_PCAP' edit_me.txt | cut -d "=" -f 2)
			MULTI_IP=$(grep -m 1 -w 'Multi_IP' edit_me.txt | cut -d "=" -f 2)
			stop_trace_cfx $folder $CFX_IP $CFX_USER $CFX_PASSWORD $CIF $TDCORE $MULTI_IP
		else 
			echo -e "CFX Trace is \e[1;31m Not applicable\e[0m"
			
		fi
		
		

		cd $folder
		mkdir PCAP
		if [[ "$TAS" == "$True" ]]; then
			cd ..
			cd /drives/c/VLCC/$folder/TAS/
			tar -czvf volte.tar.gz volte
		fi
		cd ..
		cd /drives/c/VLCC/$folder/
		find . -name '*.gz' -execdir gunzip '{}' \;
		find . -name '*.tar' -execdir tar -xvf '{}' \;
		find . -name '*.pcap' -exec mv {} /cygdrive/c/VLCC/$folder/PCAP \;
		cd ..
		cd /drives/c/"Program Files"/Wireshark/
		cmd /c  mergecap -w c:/VLCC/$folder/PCAP/merged.pcap  c:/VLCC/$folder/PCAP/*.pcap
		#echo "################################################################################"
		echo
		echo
		#echo " 			MERGE IS DISABLED HERE		"	
		echo
		echo
		#echo "################################################################################"
        echo
		
		cd ..
		cd /drives/c/VLCC/$folder/PCAP/
		tar -czvf merged.tar.gz merged.pcap
		rm -rf *.pcap

		os_type=$(uname -s)
		if [ "$os_type" == "Linux" ];then

			cd $folder
		else

			explorer.exe "c:\VLCC\\$folder"
		fi

		

		echo "################################################################################"
		echo
		echo
		echo " 			TRACE CAPTURE COMPLETE		"	
		echo
		echo
		echo "################################################################################"
        echo
		echo

	else
		echo "Wrong Input"
	fi







}

mon=$(date +%b)
pass=$1
call_type=$2
operation=$3
echo
echo
pre_pwd=$(cat /cygdrive/c/VLCC/script/data | grep $mon | cut -d ":" -f 2)

data=`echo $pre_pwd | openssl enc -aes-128-cbc -a -d -salt -pass pass:test 2>/dev/null` 

echo
echo
echo
echo "$pwd"
if [ "$data" == "$pass" ] && [ $# == 3 ];then

		Main $pass $call_type $operation
elif [ $# != 3 ];then
		
		echo "*****************Run with proper argument eg:'./execute_me.sh password call_type start/stop'*****************"
	
elif [ "$data" != "$pass" ]; then

	
		echo "*****************WRONG PASSWORD ENTERED*****************"
		

else
		echo "*****************Run with proper argument eg:'./execute_me.sh password call_type start/stop'*****************"

fi

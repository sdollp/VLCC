set arg1=%1
set arg2=%2
set arg3=%3
set arg4=%4
shift
shift
shift
shift



start "" "C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe" -newtab "c:/TC_Tool/execute_me.sh %arg1% %arg2% %arg3% %arg4%"


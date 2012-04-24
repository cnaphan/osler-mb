rem %1 MB7BROKER
rem %2 OSlerExecutionGroup
mqsichangetrace %1 -u -e %2 -l none -c 5000
mqsireadlog %1 -e %2 -o readlog.out -u -f
mqsiformatlog -i readlog.out -o readlog.txt 
start notepad readlog.txt
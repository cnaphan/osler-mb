rem %1 MB7BROKER
rem %2 EG 
mqsichangetrace %1 -u -e %2 -r 
mqsichangetrace %1 -u -e %2 -l debug -c 5000
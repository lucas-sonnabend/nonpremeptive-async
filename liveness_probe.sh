#!/bin/bash

INTERVAL=1  # in seconds
ENDPOINT="localhost:8000/health"

# some nice colours
RED='\033[0;31m'
GREEN='\033[0;32m'

NC='\033[0m' # No Color

timestamp() {
  date +"%T" # current time
}

while :
do
	TS=$(timestamp)
	STATUS_CODE=$(curl --max-time 1 -s -o /dev/null -w "%{http_code}" $ENDPOINT) 
	if [ "$STATUS_CODE" = "200" ]; then
		printf "${TS} ${GREEN}healthy${NC}"
        else
        	printf "${TS} ${RED}unhealthy${NC}"
        fi
	printf "    Press [CTRL+C] to stop..\n"
	sleep $INTERVAL
done

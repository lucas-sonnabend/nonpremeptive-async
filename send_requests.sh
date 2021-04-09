#!/bin/bash

REQUESTS=${1:-1}  # number of requests, defaults to one
ROUTE=${2:-processing}
ENDPOINT="localhost:8000/${ROUTE}"

# some nice colours
RED='\033[0;31m'
GREEN='\033[0;32m'

NC='\033[0m' # No Color

timestamp() {
  date +"%T" # current time
}

TS=$(timestamp)
printf "${TS} sending ${REQUESTS} requests to ${ENDPOINT}\n"

send_request() {
	local req_id=$1
	printf "%s spawned request ${req_id}\n" $(timestamp)
	curl ${ENDPOINT} &> /dev/null
	printf "%s $req_id done.\n" $(timestamp)
}

pids=()
for i in $(seq 1 $REQUESTS); do
        send_request $i &
        pids+=( $! )
done

for pid in "${pids[@]}"; do
        wait $pid
done

TS=$(timestamp)
printf "${TS} All requests finished\n"
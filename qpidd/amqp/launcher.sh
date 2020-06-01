#!/bin/bash

/sbin/qpidd &

function showProgress() {
  init=${1}
  count=${2}
  while [ ${count} -gt 0 ]; do
    printf "\r" | tr -d "\n"
    progress=$((init - count))
    value=$(yes '*' | head -${progress} | tr -d "\r\n")
    blank=$(yes '*' | head -${count} | tr -d "\r\n")
    printf "${value}${blank}"
    sleep 1
    count=$((count - 1))
  done
  echo
}

echo "wait to boot broker" showProgress 5

set -x
##  Add exchanges
# qpid-config add exchange topic event-ex

##  Add queues
# qpid-config add queue event.XXX

##  Bind exchanges and queues
# qpid-config bind event-ex event.XXX xyz


tail -f /dev/null

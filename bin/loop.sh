#!/bin/bash

echo "$@"

if [ $# -lt 1 ]; then
  sleep=300
else
  sleep=$1
fi

while true; do
  python bin/github-publish
  echo "Entering sleep for $sleep seconds"
  sleep $sleep
done

#!/bin/bash

wait=$WAIT_FOR
echo 'Read WAIT_FOR' $wait
echo 'Read WAIT_TIMEOUT' $WAIT_TIMEOUT

arr=${WAIT_FOR//,/ }

for each in $arr; do
  code=$(wait-for-it.sh -t $WAIT_TIMEOUT --strict --quiet $each -- echo "ok")
  if [[ $code == "ok" ]]; then
    echo $each' is ok'
  else
    exit 1
  fi
done

exit 0

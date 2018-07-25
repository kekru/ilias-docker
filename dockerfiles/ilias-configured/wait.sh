#!/bin/bash
should_run=true

after_boot() {
    if [ ! -z "$AFTER_BOOT" ]; then
        chmod +x $AFTER_BOOT
        "$AFTER_BOOT"
        echo "After boot exited with code $?"
    fi
}

before_shutdown() {
    should_run=false
    if [ ! -z "$BEFORE_SHUTDOWN" ]; then
        chmod +x $BEFORE_SHUTDOWN
        "$BEFORE_SHUTDOWN"
        echo "Before shutdown exited with code $?"
        exit $?
    fi
}

wait_for() {
    if [ ! -z "$WAIT_FOR" ]; then
        for i in $(echo $WAIT_FOR | tr "," "\n")
        do
          array=$(echo $i | tr ":" "\n")
          host="${array[0]}"
          port="${array[1]}"
          code=1
          while [ "$code" != "0" ] && [ should_run ]
          do
              echo "Waiting for $i to come up..."
              nc -z -v -w5 $host $port
              code=$?
              echo "Check exited with code $code."
              if [ "$code" != "0" ]; then
                sleep 5
              fi
          done
          echo "$i is up. Continuing."
        done
    fi;
}

trap before_shutdown HUP INT TERM KILL

wait_for;

echo "Starting command $@..."
"$@" &
PID=$!
echo "Command $@ is running with PID $PID"
echo "Starting after boot..."
after_boot;
echo "Finished after boot."
echo "Ready."
wait $PID
exit $?

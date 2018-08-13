#!/bin/bash
wait_for() {
    for i in $(echo $WAIT_FOR | tr "," "\n")
    do
        array=$(echo $i | tr ":" "\n")
        host="${array[0]}"
        port="${array[1]}"
        while ! $(nc -z -v -w5 $host $port)
        do
            echo "Waiting for '$i' to come up..."
            sleep 5
        done
        echo "$i is up. Continuing."
    done
}

wait_for;

echo "All dependencies are up. Ready!"

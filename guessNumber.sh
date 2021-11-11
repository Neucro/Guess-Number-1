#!/bin/bash

number=$(( $RANDOM % 100 + 1 ))

echo "Guess a number between 1 and 100"

guess=0

while [ "0$guess" -ne $number ] ; do
        read guess
        [ "0$guess" -lt $number ] && echo "Too low"
        [ "0$guess" -gt $number ] && echo "Too high"
done

echo "That's right!"
exit 0

#!/bin/bash

# References:
# https://www.gnu.org/software/bash/manual/html_node/Coprocesses.html
# https://www.geeksforgeeks.org/coproc-command-in-linux-with-examples/
# https://wiki.bash-hackers.org/syntax/keywords/coproc
# https://www.shell-tips.com/bash/math-arithmetic-calculation/#gsc.tab=0
# https://linuxhandbook.com/bash-check-substring/

# Guess range
min_high=100
max_low=1
# Pause time
pause=1
echo "Starting guessing game"
# Start a co process to run the game
coproc gn (bash guessNumber.sh)
# Read in the welcome message
read -r gameout <&"${gn[0]}"
echo "game: $gameout"
sleep $pause
# Use a loop to repeatedly feed in new guesses
while :; do
	# Make a guess, use integer arithmetic
	gamein=$(( min_high + max_low))
	#gamein=$(( gamein + gamein%2))
	gamein=$(( gamein / 2 ))
	echo "ai: guess $gamein"
	echo $gamein >&"${gn[1]}"
	read -r gameout <&"${gn[0]}"
	echo "game: $gameout"
	sleep $pause
	if [[ $gameout == *"high"* ]]; then
		min_high=$gamein
	elif [[ $gameout == *"low"* ]]; then
		max_low=$gamein
	else
		break
	fi
	gameout=""
done

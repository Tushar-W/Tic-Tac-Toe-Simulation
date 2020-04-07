#!/bin/bash -x

echo "Welcome To Tic-Tac-Toe Simulation"
#declaration of array playBoard
declare -a playBoard
#CONSTANTS
NOUGHT="X"
CROSS="O"
#VARIABLES
player=""

#resetting board
function resetBoard() {
	for((count=1; count<10; count++))
	do
		playBoard[$count]=" "
	done
}

#Assigning nought or cross to player
function assignNoughtOrCross() {
	letter=$((RANDOM%2))
	if [ $letter -eq 0 ];
	then
		player=$NOUGHT
	else
		player=$CROSS
	fi
}

resetBoard
echo ${playBoard[@]}
assignNoughtOrCross
echo "player:"$player

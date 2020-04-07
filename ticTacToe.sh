#!/bin/bash -x

echo "Welcome To Tic-Tac-Toe Simulation"
#declaration of array playBoard
declare -a playBoard

#resetting board
function resetBoard() {
	for((count=1; count<10; count++))
	do
		playBoard[$count]=" "
	done
}

resetBoard
echo ${playBoard[@]}

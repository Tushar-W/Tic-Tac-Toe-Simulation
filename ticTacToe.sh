#!/bin/bash -x

echo "Welcome To Tic-Tac-Toe Simulation"
#declaration of array
declare -a computerBoard
declare -a playBoard
#CONSTANTS
NOUGHT="O"
CROSS="X"
TOTAL_CELLS=10
#VARIABLES
checkWin=0
player=""
computer=""
pos=1

#get random position between 1 to 9
function getPosition() {
	comPos=$((RANDOM%9 + 1))
}

#checking is game tie
function isGameTie() {
	if [ $i -eq $((TOTAL_CELLS-1)) ];
	then
		echo "Game Is Tie"
	fi
}

#display play board
function displayBoard() {
	echo " Play Board "
	echo "---------"
	for((count=1; count<$TOTAL_CELLS; count++))
	do
		echo "${playBoard[$count]} | ${playBoard[$((++count))]} | ${playBoard[$((++count))]}"
		echo "---------"
	done
}

#checking winner at row
function checkingRow() {
	for ((count=1; count<$TOTAL_CELLS; count=count+3))
	do
		temp=$count
		if [[ ${playBoard[$temp]} == $letter ]] && [[ ${playBoard[$temp]} == ${playBoard[$((temp+1))]} ]] && [[ ${playBoard[$((temp+1))]} == ${playBoard[$((temp+2))]} ]]
		then
			echo "$name Is Win"
			checkWin=1
			exit
		fi
	done
}

#checking winner at column
function checkingColumn() {
	for ((count=1; count<4; count++))
	do
		temp=$count
		if [[ ${playBoard[$temp]} == $letter ]] && [[ ${playBoard[$temp]} == ${playBoard[$((temp+3))]} ]] && [[ ${playBoard[$((temp+3))]} == ${playBoard[$((temp+6))]} ]]
		then
			echo "$name Is Win"
			checkWin=1
			exit
		fi
	done
}

#checking winner at diagonal
function checkingDiagonal() {
	if [[ ${playBoard[1]} == $letter ]] && [[ ${playBoard[5]} == $letter ]] && [[ ${playBoard[9]} == $letter ]]
	then
		echo "$name Is Win"
		checkWin=1
	elif [[ ${playBoard[3]} == $letter ]] && [[ ${playBoard[5]} == $letter ]] && [[ ${playBoard[7]} == $letter ]]
	then
		echo "$name Is win"
		checkWin=1
	fi
}

#checking winner
function checkWinner() {
	letter=$1
	name=$2
	checkingRow
	checkingColumn
	checkingDiagonal
}

#check Position Available
function checkPositionAvailable() {
	position=$1
	if [[ ${playBoard[$position]} == " " ]];
	then
		playBoard[position]=$2
	else
		echo "Please Enter Valid Position"
		switchPlayer
	fi
}

#player turn
function playerTurn() {
	echo "Player Turn"
	read -p "Enter Position:" position
	checkPositionAvailable $position $player
	displayBoard
	checkWinner $player "Player"
	number=1
}

#check is centre position available in play board
function isCentreAvailable() {
	if [[ ${playBoard[5]} == " " ]];
	then
		comPos=5
	fi
}

#check is available corner in play board
function isAvailableCorner() {
	if [[ ${playBoard[1]} == " " ]];
	then
		comPos=1
	elif [[ ${playBoard[3]} == " " ]];
	then
		comPos=3
	elif [[ ${playBoard[7]} == " " ]];
	then
		comPos=7
	elif [[ ${playBoard[9]} == " " ]];
	then
		comPos=9
	fi
}

#computer moving To Winning Position
function moveToPosition() {
	j=1
	while [ true ]
	do
		getPosition
		if [[ ${computerBoard[$j]} != $comPos ]] && [[ ${computerBoard[$j+1]} != $comPos ]]
		then
			break
		fi
	done
}

#computer check if who can win then play that move
function checkWhoIsMoveToWin() {
	for((j=1; j<$TOTAL_CELLS; j++))
	do
		if [[ ${playBoard[$j]} == $1 ]]
		then
			computerBoard[$pos]=$j
			((pos++))
		fi
	done
}

#computer turn
function computerTurn() {
	echo "Computer Turn"
	checkWhoIsMoveToWin $computer
	checkWhoIsMoveToWin $player
	if [ $pos -ge 4 ];
	then
		moveToPosition
	elif [ $pos -lt 4 ];
	then
		isAvailableCorner
	else
		isCentreAvailable
	fi
	echo "Computer Position" $comPos
	checkPositionAvailable $comPos $computer
	displayBoard
	checkWinner $computer "Computer"
	number=0
}

#switch players
function switchPlayer() {
	if [ $number -eq 0 ];
	then
		playerTurn
	else
		computerTurn
	fi
}

#Assigning nought or cross to player
function assignNoughtOrCross() {
	if [ $number -eq 0 ];
	then
		player=$CROSS
		computer=$NOUGHT
	else
		player=$NOUGHT
		computer=$CROSS
	fi
}

#checking who play first in game
function checkWhoPlayFirst() {
	number=$((RANDOM%2))
	if [ $number -eq 0 ];
	then
		echo "Player Play First"
		assignNoughtOrCross
	else
		echo "Computer Play First"
		assignNoughtOrCross
	fi
}

#resetting board
function resetBoard() {
	for((count=1; count<$TOTAL_CELLS; count++))
	do
		playBoard[$count]=" "
	done
}

function main() {
	resetBoard
	checkWhoPlayFirst
	displayBoard
	for ((i=1; i<$TOTAL_CELLS; i++))
	do
		if [ $checkWin -eq 0 ];
		then
			switchPlayer
			isGameTie
		else
			break
		fi
	done
}

#calling main function
main

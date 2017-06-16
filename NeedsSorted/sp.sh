#!/bin/sh

function AskYesNoQuestion {
	while true; do
		echo
		echo -e  $1
	    read -p 'Would You like to create one? (This cannot be undone) Y/N: ' -n 1 response
	    echo
	    case $response in
	        [Yy]* ) break;;
	        [Nn]* ) exit;;
	        * ) echo "Please answer y or n.";;
	    esac
	done
}

input=$1
inputlen=${#input}
output=${input::-($inputlen-2)}

branch="SP/"$output"000/"$input

if [ `git branch --list $branch ` ];then
	git checkout $branch
else
	AskYesNoQuestion "Branch does not exist."
	git checkout -b $branch
fi
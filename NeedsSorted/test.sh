#!/bin/sh

##Setting up colors
Black="\033[0;30m";
Red="\033[0;31m";
Green="\033[0;32m";
Yellow="\033[0;33m";
Blue="\033[0;34m";
Cyan="\033[0;36m";
Purple="\033[0;35m";
DarkGrey="\033[0;37m";
DarkGrey="\033[1;30m";
LightRed="\033[1;31m";
LightGreen="\033[1;32m";
LightYellow="\033[1;33m";
LightBlue="\033[1;34m";
LightCyan="\033[1;36m";
LightPurple="\033[1;35m";
White="\033[1;37m";
bgBlack="\033[40m";
bgRed="\033[41m";
bgGreen="\033[42m";
bgYellow="\033[43m";
bgBlue="\033[44m";
bgPurple="\033[45m";
bgCyan="\033[46m";
bgDarkGrey="\033[47m";
NoColor="\033[0m";

function AskYesNoQuestion {
	while true; do
		echo
		echo -e  $1
	    read -p 'Would You like to create one? Y/N: ' -n 1 response
	    echo
	    case $response in
	        [Yy]* ) break;;
	        [Nn]* ) exit;;
	        * ) echo "Please answer y or n.";;
	    esac
	done
}

if [[ $1 = "" ]]; then
	echo -e $LightRed"No branch number entered"$NoColor	
	exit
fi

IssueNumber=$1
IssueNumberLen=${#IssueNumber}


if [ $IssueNumberLen == 5 ]; then
	MidSection=${IssueNumber::-($IssueNumberLen-2)}
	let "MidSection	*= 1000"
	branch="SP/"$MidSection"/"$IssueNumber
fi

if [ $IssueNumberLen == 6 ]; then
	MidSection=${IssueNumber::-($IssueNumberLen-3)}	
	let "MidSection	*= 1000"
	hundreds=$(($IssueNumber-$MidSection))
	hundredsLen=${#hundreds}
	hundreds=${hundreds::-($hundredsLen-1)}
	let "hundreds *= 100"
	branch="SP/"$MidSection"/"$hundreds"/"$IssueNumber	
fi

if [[ $IssueNumberLen > 6 || $IssueNumberLen < 5  ]]; then
	echo "Not a correct format"
	echo "Try again"
	exit
fi

if [ `git branch --list $branch ` ];then
	git checkout $branch
else
	AskYesNoQuestion "Branch "$branch" does not exist."
	git checkout -b $branch
fi
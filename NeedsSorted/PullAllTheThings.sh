#!/bin/bash

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

function StashChanges 
{
	if [ $(git status -s | wc -l) != 0 ]; then
		echo -e $Yellow
		git stash save \"$(curl -s whatthecommit.com/index.txt)\"
		echo -e $NoColor
	fi	
}

function HelpMenu
{
	echo "Usage: git pullall <project>"
	echo
	echo "Current supported Projects:"
	echo -e "HO\tHO Webforms"
	echo -e "PL\tPL Webforms"
}

function PullProject()
{
	project=none
	case "$1" in
		HO)
			project=/c/git/HORepos
			;;
		PL)
			project=/c/git/PLRepos
			;;
		*)
			echo -e $Red"You done goofed try again"$NoColor
			exit 1
			;;
	esac


	while IFS="," read repo branch
	do
		cd $repo
		echo -e $LightCyan  
		pwd
		echo -e $NoColor
		# StashChanges
		# git checkout --quiet $branch
		# git pull
	done < $project
}

if [[ $# -ne 1 ]]; then
	echo -e $Red"Must enter exactly one argument"$NoColor
	HelpMenu 
	exit 1
fi

case $1 in
	'HO' | 'ho')
		PullProject HO
		;;
	'PL' | 'pl')
		PullProject PL
		;;
	help)
		HelpMenu
		exit 1
		;;	
	*)
		echo -e $Yellow"Bad args"$NoColor
		HelpMenu
		exit 1
		;;
esac

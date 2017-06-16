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

function terminate_script
{
	echo
	echo -e $LightCyan"Press any key to exit...." $NoColor
   	read -n1
   	exit
}

function AskYesNoQuestion {
	while true; do
		echo
		echo -e  $DarkGrey$1$NoColor
	    read -p 'Would you like to continue? (This cannot be undone) y/N: ' -n 1 response
	    echo
	    case $response in
	        [Yy]* ) break;;
	        [Nn]* ) terminate_script;;
	        * ) echo "Please answer y or n.";;
	    esac
	done
}


echo
#Check to make sure we are in a repo...
if [[ $(git rev-parse --is-inside-work-tree) != "true" ]]; then
	echo -e $Red"No repo found in directory. Please try again."$NoColor
	terminate_script
fi

#stuff to set before we begin
#get the current branch so we can check to make sure its not dev or master
CURRENTBRANCH=$(git rev-parse --abbrev-ref HEAD);

if [[ $CURRENTBRANCH == "develop" ]]; then
	echo -e $Red"Do not run this on develop."$NoColor
	terminate_script	
fi

if [[ $CURRENTBRANCH == "master" ]]; then
	echo -e $Red"Do not run this on master."$NoColor
	terminate_script
fi

echo -e $Yellow"Squashing "$CURRENTBRANCH $NoColor
echo
echo -e $DarkGrey"Checking if branch lives on remote."$NoColor

#Checks the remote (by callout) if the current branch exists so we don't have to worry about users setting the upstream flag on push
#Returns 1 if branch exists
REMOTECHECK=$(git ls-remote --heads $(git config --get remote.origin.url) $CURRENTBRANCH | wc -l)
if [[ $REMOTECHECK -eq 1 ]]; then
	echo -e $Red"Branch has already been pushed to remote."
	terminate_script
fi

echo -e $Yellow"Good to go!"$NoColor
#Find how many commits are on this branch
NUMOFCOMMITS=$(git cherry -v develop | wc -l);

if [[ NUMOFCOMMITS -eq 0 ]]; then
	echo
	echo -e $Red"Nothing to squash... Exiting..."
	terminate_script
fi

AskYesNoQuestion "Squashing $NUMOFCOMMITS Commit(s)"
echo
echo -e $DarkGrey"Reseting branch"$NoColor
echo
git reset HEAD~$NUMOFCOMMITS
echo 
echo -e $DarkGrey"Commiting... Opening vim "$NoColor
echo -e $LightCyan"Press any key to continue...." $NoColor
read -n1
git add --all
git commit
echo
echo -e $DarkGrey"Checking out to dev..."$NoColor
echo
git checkout develop
echo
echo -e $DarkGrey"Pulling dev..."$NoColor
echo
git pull
echo
echo -e $DarkGrey"Rebasing $CURRENTBRANCH to develop."$NoColor
echo
git checkout $CURRENTBRANCH
git rebase develop
echo
echo -e $LightGreen"Branch squashed."
echo -e "Now you can push to origin."$NoColor
terminate_script
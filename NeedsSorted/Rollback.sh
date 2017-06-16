cwd=$(pwd);

cd /c/git/
for d in */ ; do
    cd $d;
    printf "\n";
	PWD;
    git checkout -- .;
    git status; 
    cd ..; 
done

cd $cwd;
cwd=$(pwd);
cd /c/git/;

find . -type d -name '.git' | while read dir ; do sh -c "cd $dir/../ && echo -e \"\nGIT STATUS IN ${dir//\.git/}\" && git status -sb" ; done \

cd $cwd;
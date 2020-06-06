#!/bin/bash

# Clear your terminal to enhance visibility
clear

while [ "$confirmation" != "Y" ]
do
    echo "The script will download and load files from the current directory, do you want to continue?"
    echo "[Y/N]"
    echo -e "> \c"

    read confirmation
    case "$confirmation" in 
        y|Y ) clear
              break;;
        n|N ) echo "Thanks for using the script, see you soon :)"
              exit;;
        # In case of bad input
        * ) clear;;
    esac 
done

# Continue
echo "Please copy/paste here the GitLab repository you want to import to GitHub"
echo -e "> \c"
read repo_link
clear

echo "What will be the name of the repository on GitHub ?"
echo -e "> \c"
read repo_name
clear

echo "Now trying to git clone from GitLab..."
git clone $repo_link
echo "OK"

echo "Now trying to init a git repository..."
mkdir $repo_name
## check if the repository already exists, potentially leading to an error
echo "OK"

echo "Copying files..."
old_repo=$(echo "$repo_link" | sed 's|.*/||')
#mv ./$old_repo/* ./$repo_name
cd $old_repo
# Correct this mv command
mv ./* ../$repo_name
cd ..
echo "OK"
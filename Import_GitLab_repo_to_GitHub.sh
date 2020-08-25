#!/bin/bash

# Clear your terminal to enhance visibility
clear

while [ "$confirmation" != "Y" ]
do
    echo "The script will download and load files from the current directory, do you wish to continue?"
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

echo "Please copy/paste here the GitHub repository that will be used"
echo -e "> \c"
read new_repo_link
clear

echo "Now trying to git clone from GitLab..."
git clone $repo_link
echo "OK"

echo "Now trying to git clone from GitHub..."
git clone $new_repo_link
## check if the repository already exists, potentially leading to an error
echo "OK"

echo "Copying files..."
old_repo=$(echo "$repo_link" | sed 's|.*/||')
new_repo=$(echo "$new_repo_link" | sed 's|.*/||')
cd $old_repo
mv -f ./* ../$new_repo
cd ..
echo "OK"

echo "Now trying to commit and push the modifications..."
cd $new_repo
git add *

echo "Please enter your commit message"
read commit_msg

git commit -m "$commit_msg"
git push origin master
echo "OK"

## To do
# Remove les dossiers à la fin (voir si c'est utile)
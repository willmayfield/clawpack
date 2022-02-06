#!/bin/sh

# Execute this script from the top level clawpack directory, 
# assumed to be a git clone of git://github.com/clawpack/clawpack.

# Before running this you might want to do:
#    python $CLAW/clawutil/src/python/clawutil/claw_git_status.py
# and then check the files
#    claw_git_status.txt  and  claw_git_diffs.txt
# to make sure you don't have uncommitted changes in these repositories.

# The commands below check out the master branch of each repository
# and pull any recent changes.

CLAW=$PWD
echo In directory $CLAW checking out master and pulling from origin

for repo in pyclaw classic riemann amrclaw clawutil
do
    cd $repo
    echo "In repository $repo"
    git clone https://github.com/clawpack/${repo}.git .
    #git checkout master
    #git pull origin master
    cd $CLAW
done

for repo in geoclaw visclaw
do
    cd $repo
    echo "In repository $repo"
    git clone https://github.com/willmayfield/${repo}.git .
    git checkout hueneme
    #git pull origin master
    cd $CLAW
done

# Create claw_git_status and claw_git_diff files to record what's checked out. 
# Requires $CLAW set to this directory above to work properly:

python ./clawutil/src/python/clawutil/claw_git_status.py
d=$(date +%Y-%m-%d)
f1=${d}_claw_git_status.txt
f2=${d}_claw_git_diff.txt
mv claw_git_status.txt $f1
mv claw_git_diffs.txt $f2
echo "Current git status listed in files"
echo "     ./$f1"
echo "     ./$f2"


#!/bin/bash

# labcheck2.5.sh

# Author:  Murray Saul
# Date:    January 15, 2020
# Modified by:	Chris Johnson
# Modified:	September 20, 2022
#
# Purpose: Check that user correctly issued some Linux file management
#          commands. This shell script will exit if errors,
#          but will provide feedback to correct the problem.
#          If no errors, then a congratulatory message will be displayed
#          so that the user can proceed to the next section.
#
# License: LGPL version 3
# Link:    https://www.gnu.org/licenses/lgpl.html
#

# Function to indicate OK (in green) if check is true; otherwise, indicate
# WARNING (in red) if check is false and end with false exit status

function check(){

  if eval $1
  then
     echo -e "\e[0;32mOK\e[m"
  else
     echo -e "\e[0;31mWARNING\e[m"
     echo 
     echo $2 
     echo
     exit 1
  fi

} # end of check() function

# Set shell shell history
HISTFILE=~/.bash_history
set -o history

clear  # Clear the screen

 Make certain user is in the home directory

if [ $PWD != $HOME ]
then
  echo -e "\033[1mERROR:\033[0m"
  echo
  echo "You are NOT located in your HOME directory."
  echo -e "(i.e. \033[1m$HOME\033[0m )"
  echo
  echo -en "Issue the \033[1mcd\033[0m command (without arguments)"
  echo -e "and confirm that you are"
  echo -e "currently located in your home directory with the \033[1mpwd\033[0m command,"
  echo "and re-run this checking script."
  echo
  echo
  exit 1
fi


# Start checking week3 tutorial
echo -e "\033[1mCHECKING YOUR WORK:\033[0m"
echo

# Check your home directory contains file called ls
echo -n "Checking your home directory contains copied file \"ls\": "
check "test -f $HOME/ls" "The regular file pathname \"$HOME/ls\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Reissue the Linux command to copy the /bin/ls file to your home directory and re-run this checking script"

# Check your home directory contains file called ls
echo -n "Checking your examples directory contains copied file \"ls\": "
check "test -f $HOME/tutorial3/practice/examples/ls" "The regular file pathname \"$HOME/tutorial3/practice/examples/ls\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Reissue the Linux command to copy the /bin/ls file to your current directory (which should have been set to \"examples\") and re-run this checking script"

# Check your home directory contains file called ls.bk
echo -n "Checking your examples directory contains copied file \"ls.bk\": "
check "test -f $HOME/tutorial3/practice/examples/ls.bk" "The regular file pathname \"$HOME/tutorial3/practice/examples/ls.bk\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Reissue the Linux command to copy the /bin/ls file to your current directory (which should have been set to \"examples\") and re-run this checking script"

echo
echo "Congratulations!"
echo
echo  "You have passed the Investigation 2: Parts 4 script"
echo
echo  "You can proceed with this tutorial."
echo
#!/bin/bash

# labcheck2.4.sh

# Author:  Murray Saul
# Date:    January 15, 2020
# Modified by:	Chris Johnson
# Modified: 	September 20, 2022
#
# Purpose: Check that user correctly created the specified directory
#          structure. This shell script will exit if errors,
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

# Make certain user is in the home directory

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

# Check directory tutorial3 created in home directory
echo -n "Checking \"tutorial3\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3" "The directory pathname \"$HOME/tutorial3\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3\" in your home directory and re-run this checking script"

# Check directory tutorial3/practice created in home directory
echo -n "Checking \"tutorial3/practice\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3/practice" "The directory pathname \"$HOME/tutorial3/practice\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3/practice\" in your home directory and re-run this checking script"

# Check directory tutorial3/practice/commands created in home directory
echo -n "Checking \"tutorial3/practice/commands\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3/practice/commands" "The directory pathname \"$HOME/tutorial3/practice/commands\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3/practice/commands\" in your home directory and re-run this checking script"

# Check directory tutorial3/practice/examples created in home directory
echo -n "Checking \"tutorial3/practice/examples\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3/practice/examples" "The directory pathname \"$HOME/tutorial3/practice/examples\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3/practice/examples\" in your home directory and re-run this checking script"

# Check directory tutorial3/notes created in home directory
echo -n "Checking \"tutorial3/notes\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3/notes" "The directory pathname \"$HOME/tutorial3/notes\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3/notes\" in your home directory and re-run this checking script"

# Check directory tutorial3/notes/lesson1 created in home directory
echo -n "Checking \"tutorial3/notes/lesson1\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3/notes/lesson1" "The directory pathname \"$HOME/tutorial3/notes/lesson1\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3/notes/lesson1\" in your home directory and re-run this checking script"

# Check directory tutorial3/notes/lesson2 created in home directory
echo -n "Checking \"tutorial3/notes/lesson2\" directory has been created in your home directory: "
check "test -d $HOME/tutorial3/notes/lesson2" "The directory pathname \"$HOME/tutorial3/notes/lesson2\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"tutorial3/notes/lesson2\" in your home directory and re-run this checking script"

echo
echo "Congratulations!"
echo
echo  "You have passed the Investigation 2: Parts 1-3 script"
echo
echo  "You can proceed with this tutorial."
echo
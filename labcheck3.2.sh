#!/bin/bash

# labcheck3.2.sh

# Author:  Murray Saul
# Date:    January 8, 2020
# Modified by:	Chris Johnson
# Modified:	January 8, 2023
#
# Purpose: Check that user correctly manipulated the specified directory
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


# System information gathering
echo "OPS705 Lab 3.2 Check Script"
echo
echo "SYSTEM INFORMATION:"
echo "------------------------------------"
hostnamectl
echo -n "              Date: "
date
echo

# Start checking of Lab 3, Investigation 1, Part 2 tutorial
echo -e "\033[1mCHECKING YOUR LAB 3, INVESTIGATION 1.2 WORK:\033[0m"
echo

# Check directory uli101xx/notes created in home directory
echo -n "Checking \"uli101xx/notes\" directory has been created in your home directory: "
check "test -d $HOME/uli101xx/notes" "The directory pathname \"$HOME/uli101xx/notes\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"uli101xx/notes\" in your home directory and re-run this checking script"

# Check directory uli101xx/tutorials created in home directory
echo -n "Checking \"uli101xx/tutorials\" directory has been created in your home directory: "
check "test -d $HOME/uli101xx/tutorials" "The directory pathname \"$HOME/uli101xx/tutorials\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"uli101xx/tutorials\" in your home directory and re-run this checking script"

# Check directory uli101xx/samples created in home directory
echo -n "Checking \"uli101xx/samples\" directory has been created in your home directory: "
check "test -d $HOME/uli101xx/samples" "The directory pathname \"$HOME/uli101xx/samples\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"uli101xx/samples\" in your home directory and re-run this checking script"

# Check directory xyz100xx created in home directory
echo -n "Checking \"xyz100xx\" directory has been created in your home directory: "
check "test -d $HOME/xyz100xx" "The directory pathname \"$HOME\xyz100xx\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"xyz100xx\" in your home directory and re-run this checking script"

# Check directory xyz100xx/uli101xx created in home directory
echo -n "Checking \"xyz100xx/uli101xx\" directory has been created in your home directory: "
check "test -d $HOME/xyz100xx/uli101xx" "The directory pathname \"$HOME\xyz100xx/uli101xx\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"xyz100xx/uli101xx\" in your home directory and re-run this checking script"

# Check directory xyz100xx/uli101xx/notes created in home directory
echo -n "Checking \"xyz100xx/uli101xx/notes\" directory has been created in your home directory: "
check "test -d $HOME/xyz100xx/uli101xx/notes" "The directory pathname \"$HOME/xyz100xx/uli101xx/notes\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"xyz100xx/uli101xx/notes\" in your home directory and re-run this checking script"

# Check directory xyz100xx/uli101xx/tutorials created in home directory
echo -n "Checking \"xyz100xx/uli101xx/tutorials\" directory has been created in your home directory: "
check "test -d $HOME/xyz100xx/uli101xx/tutorials" "The directory pathname \"$HOME/xyz100xx/uli101xx/tutorials\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"xyz100xx/uli101xx/tutorials\" in your home directory and re-run this checking script"

# Check directory xyz100xx/uli101xx/samples created in home directory
echo -n "Checking \"xyz100xx/uli101xx/samples\" directory has been created in your home directory: "
check "test -d $HOME/xyz100xx/uli101xx/samples" "The directory pathname \"$HOME/xyz100xx/uli101xx/samples\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"xyz100xx/uli101xx/samples\" in your home directory and re-run this checking script"

# Check directory xyz100xx/uli101xx/tutorials/acp100xx created in home directory
echo -n "Checking \"xyz100xx/uli101xx/tutorials/acp100xx\" directory has been created in your home directory: "
check "test -d $HOME/xyz100xx/uli101xx/tutorials/acp100xx" "The directory pathname \"$HOME/xyz100xx/uli101xx/tutorials/acp100xx\" does NOT exist. Check if you mispelled directory name, or used uppercase letters by mistake. Create the directory \"xyz100xx/uli101xx/tutorials/acp100xx\" in your home directory and re-run this checking script"

echo
echo "Congratulations!"
echo
echo  "You have passed the Investigation 1: Part 2 script"
echo  "This means that you have properly managed your directories :)"
echo
echo  "You can proceed with this tutorial."
echo
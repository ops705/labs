#!/bin/bash

# Lab 3 Check Script

# Make certain user isn't logged in as root
if [ $USER = "root" ]
then
  echo "Note: Do not run this program logged in as root. Log in to your local user and run again."
  exit 1
fi

clear

gr='\e[90m'
g='\e[32m'
r='\e[31m'
b='\e[34m'
d='\e[39m'

green () {
	text=$1
	printf "\e[32m$text\e[39m"
}

red () {
	text=$1
	printf "$r$text$d"
}

score1=0
score2=0

echo "Lab 3 Check Script"
echo "User: $USER"
hostnamectl | grep Static
hostnamectl | grep Operating
hostnamectl | grep Virtualization
hostnamectl | grep Boot
echo ""
echo "Checking Lab 3 - Investigation 1"
echo "--------------------------------"
read -p "Enter your first and last name (Example: Chris Johnson): " fullName
printf "\nDirectory ~/chris/: "
if [ -d ~/chris/ ]; then
	green "Passed"
	score1=$((score1+1))
	printf "\nDirectory ~/chris/docs/: "
	if [ -d ~/chris/docs/ ]; then
		green "Passed"
		score1=$((score1+1))
		printf "\nFile ~/chris/docs/file8: "
		if [ -f ~/chris/docs/file8 ]; then
			green "Passed"
			score1=$((score1+1))
		else
			red "Failed (File not found)"
		fi
	else
		red "Failed (Directory not found)"
	fi
else
	red "Failed (Directory not found)"
fi
printf "\nDirectory ~/chris/archive/: "
if [ -d ~/chris/archive/ ]; then
	green "Passed"
	score1=$((score1+1))
else
	red "Failed (Directory not found)"
fi
printf "\nDirectory ~/documents/: "
if [ -d ~/documents/ ]; then
	green "Passed"
	score1=$((score1+1))
	printf "\nFile ~/documents/file10: "
	if [ -f ~/documents/file10 ]; then
		green "Passed"
		score1=$((score1+1))
	else
		red "Failed (File not found)"
	fi
else
	red "Failed (Directory not found)"
fi
printf "\nFile ~/file9: "
if [ -f ~/file9 ]; then
	green "Passed"
	score1=$((score1+1))
else
	red "Failed (File not found)"
fi

printf "\nFile ~/"$USER"_lab3.txt: "
if [ -f ~/"$USER"_lab3.txt ]; then
	if [ "$(cat ~/"$USER"_lab3.txt)" == "My name is $fullName, and I've completed Investigation 1." ]; then
		green "Passed"
		score1=$((score1+1))
	else
		red "Failed (File contains incorrect text.)"
	fi
else
	red "Failed (File not found)"
fi

printf "\n\nInvestigation 1 - Score: $score1/8\n\n"

echo "Checking Lab 3 - Investigation 2"
echo "--------------------------------"
printf "File ~/shared/sales/file13: "
if [ -f ~/shared/sales/file13 ]; then
	if [ "$(date -r ~/shared/sales/file13) 536914d707b723dd3c13b320e823b7b5" == "$(cat ~/shared/sales/file13)" ]; then
		green "Passed"
		score2=$((score2+1))
	else
		red "Failed (File modified)"
	fi
else
	red "Failed (File not found)"
fi

printf "\nFile ~/shared/mkt/docs/file14: "
if [ -f ~/shared/mkt/docs/file14 ]; then
	if [ "$(date -r ~/shared/mkt/docs/file14) 88e4d6e3f8009bdd4c956227e679c48a" == "$(cat ~/shared/mkt/docs/file14)" ]; then
		green "Passed"
		score2=$((score2+1))
	else
		red "Failed (File modified)"
	fi
else
	red "Failed (File not found)"
fi

printf "\nFile ~/shared/mkt/docs/file15: "
if [ -f ~/shared/mkt/docs/file15 ]; then
	if [ "$(date -r ~/shared/mkt/docs/file15) 7d798c43d8c19e188b51da8ec165eda2" == "$(cat ~/shared/mkt/docs/file15)" ]; then
		green "Passed"
		score2=$((score2+1))
	else
		red "Failed (File modified)"
	fi
else
	red "Failed (File not found)"
fi

printf "\nFile ~/shared/mkt/docs/file16: "
if [ -f ~/shared/mkt/docs/file16 ]; then
	if [ "$(date -r ~/shared/mkt/docs/file16) 84b5ba8a1f21dd29040c27295e9a38d4" == "$(cat ~/shared/mkt/docs/file16)" ]; then
		green "Passed"
		score2=$((score2+1))
	else
		red "Failed (File modified)"
	fi
else
	red "Failed (File not found)"
fi

printf "\nFile ~/shared/mkt/docs2020/file17: "
if [ -f ~/shared/mkt/docs2020/file17 ]; then
	if [ "$(date -r ~/shared/mkt/docs2020/file17) a9629852cbaafa55fbaadafb2cd84581" == "$(cat ~/shared/mkt/docs2020/file17)" ]; then
		green "Passed"
		score2=$((score2+1))
	else
		red "Failed (File modified)"
	fi
else
	red "Failed (File not found)"
fi

printf "\n\nInvestigation 2 - Score: $score2/5\n\n"

echo "Date Complete: $(date)"
echo "Code: $(($(date -r ~/shared/mkt/docs2020/file17 +%s)*$(date +%s)))"

if [ $((score1+score2)) -eq "13" ]; then
	green "\nLab 3 check has passed.\n"
	echo "Screenshot this result and submit as part of your Lab 3 files."
else
	red "\nLab 3 contains errors and is incomplete.\n"
fi
#!/bin/bash

# ./labcheck2.sh

# Author:  Chris Johnson <chris.johnson@senecacollege.ca>
# Date:    Jan 18, 2023
#
# Purpose: Check that students correctly completed Lab 2.
#          Script will not exit if errors are detected,
#          but provide feedback to correct the problem.

# Make certain user is logged in as root
if [ $(whoami) == "root" ]
then
  echo "Note: You are required to run this program as your regular user and without sudo."
  exit 1
fi

clear

run_header () {
	echo "OPS705 Lab 2 Check Script - $USER"
	echo "Script Run: $(TZ=America/New_York date)"
	echo "----------------------------------------------"
}

yum_update () {
	echo -n "System updated: "
	if [[ $(yum check-update &> /dev/null; echo $?) == 0 ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi
}

firewall_services () {
	echo -n "Firewalld removed: "
	if ! $(rpm -q firewalld &> /dev/null); then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "iptables Service Active: "
	if [[ $(systemctl is-active iptables 2> /dev/null) == "active" ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "iptables Service Enabled: "
	if [[ $(systemctl is-enabled iptables 2> /dev/null) == "enabled" ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi
}

firewall_configuration () {
	echo ""
	echo "Checking iptables rules..."
	echo "--------------------------"
	echo -n "INPUT - RELATED,ESTABLED: "
	if $(sudo iptables -C INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 2> /dev/null ); then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "INPUT - LOOPBACK/ALL: "
	if $(sudo iptables -C INPUT -p all -i lo -j ACCEPT 2> /dev/null ); then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "INPUT - REJECT Rule Removed: "
	if $(sudo iptables -C INPUT -p all -j REJECT 2> /dev/null ); then
		echo -e "\e[0;31m[FAILED]\e[m"
	else
		echo -e "\e[0;32m[PASSED]\e[m"
	fi

	echo -n "INPUT - SSH on port 22222: "
	if $(sudo iptables -C INPUT -m state --state NEW -p tcp --dport 22222 -j ACCEPT 2> /dev/null ); then
		echo -e "\e[0;32m[PASSED]\e[m"
	elif $(sudo iptables -C INPUT -p tcp --dport 22222 -m state --state NEW -j ACCEPT 2> /dev/null ); then
		echo -e "\e[0;32m[PASSED]\e[m"
	elif $(sudo iptables -C INPUT -p tcp --dport 22222 -j ACCEPT 2> /dev/null ); then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "INPUT DEFAULT - DROP: "
	if $(sudo iptables -L | grep "INPUT" | grep "DROP" &> /dev/null) ; then 
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "FORWARD - REJECT Rule Removed: "
	if $(sudo iptables -C FORWARD -p all -j REJECT 2> /dev/null ); then
		echo -e "\e[0;31m[FAILED]\e[m"
	else
		echo -e "\e[0;32m[PASSED]\e[m"
	fi

	echo -n "FORWARD DEFAULT - DROP: "
	if $(sudo iptables -L | grep "FORWARD" | grep "DROP" &> /dev/null) ; then 
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi
}

authorized_keys () {
	echo ""
	echo "Checking public/private keys..."
	echo "-------------------------------"

	echo -n "Public key generated: "
	if [[ -f ~/.ssh/id_rsa.pub ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "Private key generated: "
	if [[ -f ~/.ssh/id_rsa ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi

	echo -n "Your public key installed in ~/.ssh/authorized_keys: "
	if [[ ! -f ~/.ssh/authorized_keys ]]; then
		echo -e "\e[0;31m[FAILED] (File doesn't exist.)\e[m"
	elif [[ $(grep -f ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys 2> /dev/null) ]] ; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED] (Key not found in file.)\e[m"
	fi

	echo -n "Professor's public key installed in ~/.ssh/authorized_keys: "
	if [[ ! -f ~/.ssh/authorized_keys ]]; then
		echo -e "\e[0;31m[FAILED] (File doesn't exist.)\e[m"
	elif [[ $(grep "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiPkuqQLXx36vV8XHsOd+rmdisEdkI3cwArrQmZZCF+f0EYZ/J75Gn39g8cZGqq02eVGUQSrmzIm+sB9f8O7+VtuWtN5WeNnGTH1cuOiC0GFAbI2/JaxxTFo09g/DbLMd5fa4IKnK4VPY/ybrtTmuhLFMyt+OJb1dnrq4/rhNFQxOGvbskSgs+AOhHGq7LVc6sJQIOguJ4JCG6Hcgdt4bTzEG+6Fm0IDirHdq3N6Hc+1BYOgAzyLXs1b34pB4nPRwYu3sfmrKWtj34i6IxAXEAOriLrL6LGraBg1BpWwW1ZUomWRPdhzizlNuQ8N3M2TF3lDaIVvYUxrcnx3TYSoNb" ~/.ssh/authorized_keys 2> /dev/null) ]] ; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED] (Key not found in file.)\e[m"
	fi

	echo -n "Testing SSH login without password on port 22222: "
	if [[ $(ssh -o PasswordAuthentication=no localhost -p 22222 "echo True" 2> /dev/null ) == "True" ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"
	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi
}

other_file () {
	echo ""
	echo "Checking ~/othertext.txt..."
	echo "---------------------------"
	echo -n "File exists: "
	if [[ -f ~/othertext.txt ]]; then
		echo -e "\e[0;32m[PASSED]\e[m"

		echo -n "\"This is the first line\": "
		if [[ $(grep "This is the first line" ~/othertext.txt) ]]; then
			echo -e "\e[0;32m[PASSED]\e[m"
		else
			echo -e "\e[0;31m[FAILED]\e[m"
		fi

		echo -n "\"This is the second line\": "
		if [[ $(grep "This is the second line" ~/othertext.txt) ]]; then
			echo -e "\e[0;32m[PASSED]\e[m"
		else
			echo -e "\e[0;31m[FAILED]\e[m"
		fi

		echo -n "\"This is the third line\": "
		if [[ $(grep "This is the third line" ~/othertext.txt) ]]; then
			echo -e "\e[0;32m[PASSED]\e[m"
		else
			echo -e "\e[0;31m[FAILED]\e[m"
		fi

		echo -n "\"This is the fourth line\": "
		if [[ $(grep "This is the fourth line" ~/othertext.txt) ]]; then
			echo -e "\e[0;32m[PASSED]\e[m"
		else
			echo -e "\e[0;31m[FAILED]\e[m"
		fi

	else
		echo -e "\e[0;31m[FAILED]\e[m"
	fi
}

end_message () {
	echo ""
	echo "IMPORTANT MESSAGE"
	echo "-----------------"
	echo "If ALL checks have passed, congratulations! You have finished the lab."
	echo "Take all required screenshots and submit them to Blackboard."
	echo ""
	echo "If ANY checks have failed, correct them and then run this script again."
	echo ""
}

run_header
yum_update
firewall_services
firewall_configuration
authorized_keys
other_file
end_message


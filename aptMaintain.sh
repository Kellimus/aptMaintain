#!/usr/bin/bash
# File: maintain.sh
# Update and upgrade the package files

updateflag=$1
safeupgradeflag=$2
fullupgradeflag=$3

if [[ $1 = "-h" ]] || [[ $1 = "-help" ]] || [[ $1 = "--h" ]] || [[ $1 = "--help" ]]
then
	echo ""
	echo -e "\033[4;38;5;106mAPT Maintain\033[m \033[38;5;106m- Calls various maintenance commands using apt.\033[0m"
	echo ""
	echo -e "\033[4;38;5;178musage: maintain [option option option]\033[0m"
	echo -e "\033[38;5;180mFirst option can be either y or n. This tells the script to either update (y/Y) the repositories, or not to update (n/N) them.\033[0m"
	echo -e "\033[38;5;180mSecond option can be either y or n. This tells the script to either do an upgrade (y/Y), or not to upgrade (n/N).\033[0m"
	echo -e "\033[38;5;180mThird option can be either f/F or any key. This tells the script to either do a full-upgrade (f/F), or to not full-upgrade (any character).\033[0m"
	echo -e "\033[1;3;38;5;160mAll three options must be called if you want to full-upgrade, and the third option must be a f/F in order to full-upgrade.\033[0m"
	echo ""
	echo -e "\033[38;5;159mExamples:\033[0m"
	echo -e "\033[38;5;150maptMaintain | Doesn't call any options and walks the user through questions relating to update and upgrade.\033[0m"
	echo -e "\033[38;5;150maptMaintain n | Calls the script and tells it to not update the respositories, and then asks questions pertinent to upgrade\033[0m"
	echo -e "\033[38;5;150maptMaintain y y * | Calls the script and tells it to update the repositories, and to upgrade; third option can be anything, doesn't run because of upgrade\033[0m"
	echo -e "\033[38;5;150maptMaintain n n f | Calls the script and tells it not to update, not to upgrade, and to full-upgrade.\033[0m"
	echo -e "\033[38;5;150maptMaintain y n f | Calls the script and tells it to update and to full-upgrade\033[0m"
	echo -e "\033[38;5;150maptMaintain n y * | Calls the script and tells it to not update and to upgrade; third option can be anything, doesn't run because of upgrade\033[0m"
	echo -e "\033[38;5;150maptMaintain -h/-help/--h/--help | Four options to call this help file\033[0m"
	echo ""
	echo -e "\033[1;3;38;5;165mKelly Christus ©2019―2021\033[0m"

	exit 0
fi

if [[ $updateflag = y ]] || [[ $updateflag = Y ]] && [[ -n $updateflag ]]
then
	echo -e "\033[1;38;5;147mUpdating Repositories with apt\033[0m"
	sudo apt update

	elif [[ -z $updateflag ]]
	then
		echo -e "\033[38;5;100mDo you wish to update your repositories? Y/y for yes. Any other character to skip\033[0m"
		read update
			if [[ $update = y ]] || [[ $update = Y ]]
			then
				echo -e "\033[1;38;5;147mUpdating Repositories with apt\033[0m"
				sudo apt update
			elif [[ $update != y ]] || [[ $update != Y ]]
			then
				echo -e "\033[1;4;38;5;75mNo update at all\033[0m"
			fi
else
	echo -e "\033[1;4;38;5;75mNo update\033[0m"
fi

echo ""

if [[ $safeupgradeflag = y ]] || [[ $safeupgradeflag = Y ]] && [[ -n $safeupgradeflag ]] && [[ -n $fullupgradeflag ]]
then
	echo -e "\033[1;38;5;45mUpgrading with upgrade\033[0m"
	sudo apt upgrade -y

elif  [[ $fullupgradeflag = f ]] || [[ $fullupgradeflag = F ]] && [[ -n $safeupgradeflag ]] && [[ -n $fullupgradeflag ]]
then
	echo -e "\033[1;38;5;51mUpgrading with full-upgrade\033[0m"
	sudo apt full-upgrade -y

elif [[ $fullupgradeflag != f ]] || [[ $fullupgradeflag != F ]] && [[ $safeupgradeflag != y ]] || [[ $safeupgradeflag != Y ]] && [[ -n $safeupgradeflag ]] || [[ -n $fullupgradeflag ]]
then
	echo -e "\033[1;4;38;5;160mNo upgrade period\033[0m"

elif [[ -z $safeupgradeflag ]] && [[ -z $fullupgradeflag ]]
then
	echo -e "\033[1;3;38;5;229mDo you wish to upgrade with upgrade? Y/y for yes, F/f for full-upgrade; N/n or any other character to not upgrade\033[0m"
	read choice
		if [[ $choice = y ]] || [[ $choice = Y ]]
		then
			echo -e "\033[1;38;5;45mUpgrading with upgrade\033[0m"
			sudo apt upgrade -y
		elif [[ $choice = f ]] || [[ $choice = F ]]
		then
			echo -e "\033[1;38;5;51mUpgrading with full-upgrade\033[0m"
			sudo apt full-upgrade -y
		else
			echo -e "\033[1;4;38;5;160mNo upgrade period\033[0m"
		fi
else
	echo -e "\033[1;4;38;5;160mNo upgrade period\033[0m"
fi

echo ""
echo -e "\033[3;38;5;37mRunning apt autoremove\033[0m"
sudo apt autoremove
echo ""
echo -e "\033[1;4;38;5;196mExiting script!\033[0m"
exit

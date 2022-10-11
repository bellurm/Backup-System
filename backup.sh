#! /bin/bash
# blog-cyberworm.com

files=()
index=0
extension="tar.gz"

# Get files' name and file's location. The user have to add the to be backup files in the same location.
function getFileAndDir() {
	read -p "[?] What is the name of your .tar.gz file? > " tarFile
	read -p "[?] What is the location of the to be backup files? > " fileLocation
	
	while true; do
	
		read -p "[?] File name to be backup: " fileName
		
		if [[ $fileName != 'q' ]]
		then
			findTheFile=`find / -name $fileName` # Search for the file in the system of the all Linux.
			
			if [[ $findTheFile ]]
			then
				echo -e "\n[*] '$fileName' is found.\n"
				# Add the every exist file to the 'files' array.
				files[index]="$fileName"
				(( index++ ))
			else
				echo -e "\n[*] '$fileName' is not found.\n"
			fi
		else
			echo -e "\n[*] Good Luck!\n"
			
			toBeWork_shFile
			crontabSetTime
			
			break
		fi
		echo -e "Your backup files: '${files[@]}'\n"
		
	done
	echo -e "Your backup files: '${files[@]}'\n"
}

# These are for the Cron job.
function crontabSetTime() {

	echo -e "\n[**WARN**] If you don't what should you do, please ask your administrator.\n"

	read -p "Minute: " m
	read -p "Hour: " h
	read -p "Day of Month: " dom
	read -p "Month: " mon
	read -p "Day of Week: " dow
	
	addCronJob
}

# 'toBeWork.sh' will added to Crontab.
function addCronJob() {
	findSubScript=`find / -name toBeWork.sh`
	cd /var/spool/cron/crontabs/
	echo >> root "$m $h $dom $mon $dow $findSubScript"
	service cron restart
}

# Transferring some information I got above to the 'toBeWork.sh' file.
function toBeWork_shFile() {
	chmod +x toBeWork.sh
	echo -e >> toBeWork.sh "tarFile='${tarFile}.${extension}'\nfiles=(${files[@]})\nfileLocation=$fileLocation\nbackup"
}

# MAIN AREA
# Looking for 'root' and controlling the script's run.

if [ $(whoami) != "root" ]
then
	echo -e "[!!!] You have to be 'root'.\n"
else
	# Notification on the top right corner.
	notify-send "WARNING." \
	"[***] Make sure you put the to be backup files in the same location." \
	-t 10000 # 10 seconds
	
	getFileAndDir
fi

# MAIN AREA
# Looking for 'root' and controlling the script's run.

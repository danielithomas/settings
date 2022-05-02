#!/bin/bash
# ---
# backup-profile.sh - Backup my Profile
# ---

directoryname=$(hostname)-terminal
BackupFile=$CUST_CONFIG/$directoryname/$(date +"%Y%m%d")_bashrc.txt

echo "Backup Terminal >>> " | lolcat

if [[ -d "${CUST_CONFIG}/${directoryname}" ]]; then
	echo "  >> ✅ Directory present!" |lolcat
else
	# Create Directory	
	echo "  >> ⚠️ Folder ${CUST_CONFIG}/${directoryname} not present" | lolcat
	mkdir "${CUST_CONFIG}/${directoryname}"
	echo "  >> ✅ Folder created!" | lolcat
fi

if uname | grep -q "Darwin"; then
	# echo "we're on a Mac!"
	BackupFile=${CUST_CONFIG}/$directoryname/$(date +"%Y%m%d")_zshrc.txt
	echo "  >> 💾 Backup to $BackupFile" | lolcat
	cp ~/.zshrc $BackupFile
fi

if uname | grep -q "Linux"; then
	echo "  >> 💾 Backup to $BackupFile" | lolcat
    cp ~/.bashrc $BackupFile
fi

echo "  >> DONE! 🚀🚀🚀🚀 " | lolcat



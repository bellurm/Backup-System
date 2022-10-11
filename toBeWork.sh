#! /bin/bash
# blog-cyberworm.com

# This script will be work on Cron.
function backup() {
	cd $fileLocation
	
	arrMembers=`echo ${#files[@]}`

	for items in ${files[@]}
	do
		tar -czf $tarFile ${files[@]} # Creating a tar.gz file and adding the files into the tar.gz file.
	done

}
# The following codes are added automatically.


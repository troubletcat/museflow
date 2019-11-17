#Same thing as archiveproj, but in the other direction.

echo "Enter name of project to be activated:"
read projName

#Check if that project exists in the archive.
if ! [ -d "../archived-projects/$projName" ]; then
	echo "Project $projName not found in archive."
	exec bash $0
fi

if [ -d "../current-projects/$projName" ]; then
	echo Project already exists. Rename the project then try again.
	read -p "Press enter to finish."
	exit
fi

#Move the specified project.
mv -i "../archived-projects/$projName" "../current-projects"

#Change file permissions to read only.
chmod 644 ../current-projects/"$projName"/*


echo Project "$projName" activated.

echo Commit activated project to Git repository? y/n.

read gitConfirm

if [ "$gitConfirm" = "y" ];
then
git add "../current-projects/$projName"
git commit -m "Activated project $projName."
read -p "Press enter to finish."
else
read -p "Press enter to finish."
fi

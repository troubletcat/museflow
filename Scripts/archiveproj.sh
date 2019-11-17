#Moves projects from the current project folder to the archived projects folder and sets them as read only.

echo "Enter name of project to be archived:"
read projName

#Check if that project exists.
if ! [ -d "../current-projects/$projName" ]; then
	echo "Project $projName not found."
	exec bash $0
fi

if [ -d "../archived-projects/$projName" ]; then
	echo Project already exists in archive, rename the project then try again.
	read -p "Press enter to finish."
	exit
fi

#Make this directory first just in case this is the first project being archived.
mkdir -p "../Archived-Projects"

#Move the specified project.
mv -i "../current-projects/$projName" "../archived-projects"

#Change file permissions to read only.
chmod 444 ../archived-projects/"$projName"/*


echo Project "$projName" archived.

echo Commit archived project to Git repository? y/n.

read gitConfirm

if [ "$gitConfirm" = "y" ];
then
git add "../archived-projects/$projName"
git commit -m "Archived project $projName."
read -p "Press enter to finish."
else
read -p "Press enter to finish."
fi


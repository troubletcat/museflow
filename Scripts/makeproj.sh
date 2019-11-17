#Creates a new music production project folder in the current-projects folder using the default template.
#Could be extended in the future to accept arguments for template and project locations.

echo Enter project name:

read projName

if [ -d "../current-projects/$projName" ]; then
	echo Project already exists, choose a different name.
	exec bash $0
fi

mkdir -p "../Current-Projects/$projName"

for i in templates/projects/default/*
do
	EXT=$(echo "$i" | grep -o '[^\.]*$')
	cp -i "$i" "../current-projects/$projName/$projName.$EXT"
done

#Old and bad code follows.

#cp -r -i templates/default "../current-projects/$projName"

#cd "../current-projects/$projName"

#for i in * 
#do
#	EXT=$(echo "$i" | rev | cut -d . -f 1 | rev)
#	mv "$i" "$projName".$EXT
#done

#cd -

echo Project "$projName" created in folder "../current-projects/$projName"

echo Commit project to Git repository? y/n.

read gitConfirm

if [ "$gitConfirm" = "y" ];
then
git add "../current-projects/$projName"
git commit -m "Created project $projName."
read -p "Press enter to finish."
else
read -p "Press enter to finish."
fi


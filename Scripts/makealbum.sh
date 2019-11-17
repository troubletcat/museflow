#Creates an album from a template. Basically the same script as makeproj.

echo Enter album name:

read albumName

if [ -d "../albums/$albumName" ]; then
	echo Album already exists, choose a different name.
	exec bash $0
fi

mkdir -p "../Albums/$albumName"

for i in templates/albums/default/*
do
	EXT=$(echo "$i" | grep -o '[^\.]*$')
	cp -i "$i" "../albums/$albumName/$albumName.$EXT"
done

echo Album "$albumName" created in folder "../albums/$albumName"

echo Commit album to Git repository? y/n.

read gitConfirm

if [ "$gitConfirm" = "y" ];
then
git add "../albums/$albumName"
git commit -m "Created album $albumName."
read -p "Press enter to finish."
else
read -p "Press enter to finish."
fi

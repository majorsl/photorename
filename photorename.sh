#!/bin/sh
# version 1.0.1
# This script will change the file name of a photo to it's EXIF description to a max
# of 35 characters.

STARTDIR=$1
EXCLUDE=$2

if [ "$STARTDIR" = "" ] || [ "$STARTDIR" = "?" ] || [[ "$STARTDIR" = *-h* ]]; then
	ECHO ""
	ECHO "Usage: photorename.sh <directorypath> to parse."
	ECHO ""
	exit
fi

IFS=$'\n'

cd $STARTDIR

for FILENAME in *.jpg
do
echo "Processing: $FILENAME"

NEWNAME=`exiftool -Description $FILENAME | cut -c 35- |sed 's/\:\:*//g' | sed 's/\"\"*//g'`

if [ "$NEWNAME" = "" ]; then
	NEWNAME=`ls $FILENAME | cut -d "." -f1`
fi

echo "Renamed: $NEWNAME.jpg"
echo ""

mv $FILENAME $NEWNAME".jpg"

done

unset IFS
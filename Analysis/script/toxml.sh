#!/bin/sh
files=$(ls -1 $1 | grep -v xml$)
for f in $files
do
echo "Converting $f to XML"
~/Documents/fmt2xml/bin/Mono/fmt2xml.exe ~/Documents/libodb/extra/dnsstats.xml $f
echo "Prettying XML"
xmllint --format $f.xml > $f.2.xml
mv $f.2.xml $f.xml
echo "Done"
done

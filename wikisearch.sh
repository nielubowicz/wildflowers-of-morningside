#!/bin/bash

OUTPUT="plants.md"
touch $OUTPUT

touch temp
plantname=$(echo "$1" | sed -e 's/ /%20/g')
echo "The plant: ${plantname}"

PLANTS=$(
curl -s "https://commons.wikimedia.org/w/api.php?action=query&generator=images&prop=imageinfo&gimlimit=5&redirects=1&iiprop=canonicaltitle|url&format=json&titles=$plantname" | \
	jq '.query.pages.[].imageinfo.[].url' | \
	sed -e 's/"//g' 
)

for imagename in ${PLANTS[@]} 
do
	echo "| <img src='${imagename}' width='200' height='200'/>" >> temp
	#echo "| ![$1](${imagename})" >> temp
done

if [[ -n $temp ]]; then
  echo " |\n" >> temp
fi

echo "\n## $1\n" >> $OUTPUT
cat temp | tr '\n' ' ' >> $OUTPUT

rm temp


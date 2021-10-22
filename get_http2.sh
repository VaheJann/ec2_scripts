#!/bin/bash

rm -rf url_answer
mkdir url_answer
rm -rf result 
lines=$(cat sources | wc -l)
echo ${lines};

for (( i=1; i<=${lines}; i++ ))
do
	p=$(sed -n ${i}p sources)
	if [[ $p == *"https"* ]]; then
		echo "content https "${i};
		echo ${p} > url_answer/url${i}; 
	elif [[ $p == *"http"* ]]; then
		echo "replaced http to https "${i};
		echo "${p/http/https}" > url_answer/url${i};
	fi
done

aws s3 cp url_answer s3://vahejann2/url_answer


#sed -i 's/http/https/' result

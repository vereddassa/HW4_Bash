#!/bin/bash

wget https://www.ynetnews.com/category/3082

grep -o "https://www.ynetnews.com/article/[0-9a-zA-Z]\{9\}" 3082 > article.txt

# Saving and counting one appirance of every link.

sort article.txt | uniq | tee uniq.txt | wc -l > results.csv

# Go over each link from the uniq required form.
# For every link search the required pattern and count its appearances.

for article in `cat uniq.txt` ;do
	
	wget $article -O art.txt
	gantz_num=`grep -o Gantz art.txt | wc -w`
	bibi_num=`grep -o Netanyahu art.txt | wc -w`
	
	if(( !gantz_num && !bibi_num ))
	then
		echo "$article, -" >> results.csv
	else
		echo "$article, Netanyahu, $bibi_num, Gantz, $gantz_num" >> results.csv
	fi 
done

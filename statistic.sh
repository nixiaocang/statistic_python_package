#!/bin/env/bash
find . -type f |grep py|xargs grep -E '^from|^import'| awk -F "py:" {'print $2'}|sort|uniq>res0.log
sed 's/from/import/g' res0.log| awk -F "import " {'print $2'} |awk -F '.' {'print $1'}|sort|uniq > res1.log
sed -i "s/,[ ]*/\n/g" res1.log
sed -i "s/\s/\n/g" res1.log
sed '/^$/d' res1.log|sort|uniq|while read line
do
    echo `pip freeze|grep $line` >> res2.log
done
sed -i "s/\s/\n/g" res2.log
sed '/^$/d' res2.log|sort|uniq > requirements.txt
rm res*

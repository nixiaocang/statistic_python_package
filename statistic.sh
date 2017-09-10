#!/bin/env/bash
find . -type f |grep py|xargs grep -E '^from|^import'| awk -F "py:" {'print $2'}|sort|uniq>res0.log
sed -i 's/from/import/g' res0.log
cat res0.log |awk -F "import " {'print $2'}|awk -F '.' {'print $1'}> res1.log
sed -i "s/,[ ]*/\n/g" res1.log
sed -i “s/\s/\n/g" res1.log
cat res1.log|sort|uniq |while read line
do
    echo `pip list|grep $line` >> res2.log
done
awk NF res2.log > res3.log
sed -i 's/ (/==/g' res3.log
sed -i 's/)//g' res3.log
sed -i "s# #\n#g" res3.log
sort res3.log|uniq >requests.txt
rm /tmp/res*

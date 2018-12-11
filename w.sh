#rm ./dump/*
#cd ./dump
#wget 'http://mystic.astroempires.com/ranks.aspx?view=ply_level&see='{1..10}
#cd ..
cat galaxybases.txt | awk 'BEGIN {FS="\t";}; {print $1}'  | grep  -v "\[HIDE\]" | grep -v "\[" | sort | uniq > unguilded-names.txt
cat galaxybases.txt | awk 'BEGIN {FS="\t";}; {print $1}'  | grep  -v "\[HIDE\]" | grep  "\[" | sort | uniq > guilded-names.txt

input="./unguilded-names.txt"
echo Unguilded players List > unguilded-done.txt
while IFS= read -r var
do
  echo >> unguilded-done.txt
  LEVEL=`grep -P "\t$var\t" ranks.txt |  awk 'BEGIN {FS="\t";}; {print $3}'`
  if [ "${LEVEL}" == "" ]; then
        LEVEL="?"
  fi
  echo $var $LEVEL >> unguilded-done.txt

  grep -P "$var\t" galaxybases.txt  | awk 'BEGIN {FS="\t";}; {print $3}' >> unguilded-done.txt
done < "$input"


input="./guilded-names.txt"
echo Guilded players List > guilded-done.txt
while IFS= read -r var
do
  echo >> guilded-done.txt
  LEVEL=`grep -F "$var" ranks.txt |  awk 'BEGIN {FS="\t";}; {print $3}'`
  if [ "${LEVEL}" == "" ]; then
  	LEVEL="?"
  fi
  echo $var $LEVEL >> guilded-done.txt

  grep -F "$var" galaxybases.txt  | awk 'BEGIN {FS="\t";}; {print $3}' >> guilded-done.txt
done < "$input"

echo cat unguilded-done.txt
echo cat guilded-done.txt

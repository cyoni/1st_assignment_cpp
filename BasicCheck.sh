#!/bin/bash

x=1
y=1
z=1

print(){
f=FAIL
p=PASS

first=$f
sec=$f
third=$f

if [ $1 -eq "0" ]
then
first=$p
fi

if [ $2 -eq "0" ]
then
sec=$p
fi

if [ $3 -eq "0" ]
then
third=$p
fi


echo  '         Compilation         Memory Leaks         Thread Race' 
echo "             $first                $sec                 $third"


}

dir="$1/"
FullName=$2

getName=(${FullName//./ })
file_name=${getName[0]}
makeFileName="Makefile"

if [ -z "$dir" ] || [ -z "$FullName" ] ||  [ ! -e "$dir$makeFileName" ] 
then
echo There is no MakeFile or first/sec argument is empty! This may help:
echo '1. ./BasicCheck.sh'
echo '2. path starting&ending with /'
echo '3. name of the program.[cpp or whatever]'
echo '4. arguments if the program uses'


elif [ -e $dir$file_name ]
then

if [ -r $dir$file_name ] 
then
## file found
cd $dir

 ## compile
 make &>compiler_report


if [ $? -eq 0 ]
then
rm compiler_report ## delete file if there is no error
x=0
## now to check for memory leak and then thread race

shift 2
programArgs=$@

valgrind --leak-check=full --error-exitcode=1 $dir$file_name $programArgs &>report_leak


if [ $? -eq 0 ]
then
y=0
fi


## check for thread race:
valgrind --tool=helgrind --error-exitcode=1 $dir$file_name $programArgs &>report_thread


if [ $? -eq 0 ]
then
z=0
fi


else
echo Something went wrong. Check file report for more info
fi

##########
else  
echo cannot read file. $dir$file_name
fi

else 
echo cannot find file $dir$file_name

fi


## print solution

print $x $y $z


##action- valgrind --leak-check=full -v $fileName


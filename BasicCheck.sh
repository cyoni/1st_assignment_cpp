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
FullName="$2"

getName=(${FullName//./ })
file_name=${getName[0]}

make_file="/Makefile"
if [ ! -f $dir$make_file ]; then
echo "makefile is missing"
fi

cd $dir
make > "/dev/null"

if [ $? -eq 0 ]
then

x=0


shift 2
programArgs=$@

##valgrind --leak-check=full --error-exitcode=2 $dir$file_name &>report_leak
valgrind --leak-check=full --error-exitcode=2 ./$file_name $programArgs &>report_memory

res=$?
if [ $res -eq 0 ]
then
y=0
fi


valgrind --tool=helgrind --error-exitcode=1 ./$file_name $programArgs &>report_thread


if [ $? -eq 0 ]
then
z=0
fi


fi

output=7


if [ $x -eq 0 ] && [ $y -eq 0 ] && [ $z -eq 0 ]
then
 output=0 
fi


if [ $x -eq 0 ] && [ $y -eq 0 ] && [ $z -eq 1 ]
then
output=1 
fi

if [ $x -eq 0 ] && [ $y -eq 1 ] && [ $z -eq 0 ]
then
output=2
fi

if [ $x -eq 0 ] && [ $y -eq 1 ] && [ $z -eq 1 ]
then
output=3
fi

echo $output
print $x $y $z
exit $output


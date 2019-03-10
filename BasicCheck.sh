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

output="2"

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


##shift 2
##programArgs=$@

valgrind --leak-check=full --error-exitcode=2 $dir$file_name &>report_leak

res=$?
if [ $res -eq 0 ]
then
y=0
fi


fi


print $x $y $z
exit $output


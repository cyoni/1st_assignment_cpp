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

dir=$1
FullName="/$2"

getName=(${FullName//./ })
file_name=${getName[0]}

make_file="/Makefile"
if [ ! -f $dir$make_file ]; then
echo "makefile is missing"
fi

make 

if [ $? -eq 0 ]
then

x=0





fi

print $x $y $z


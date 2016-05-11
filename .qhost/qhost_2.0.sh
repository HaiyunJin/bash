#!/bin/bash
#
#  Find out free nodes on phoenix
# 


nodelist8="
compute-0-16
compute-0-17
compute-0-18
compute-0-19
compute-0-20
compute-0-21
compute-0-22
compute-0-23
compute-0-24
compute-0-25
compute-0-27
compute-0-28
compute-0-29
"

nodelist12="
compute-1-0 
compute-1-1 
compute-1-2 
compute-1-3 
compute-1-4 
compute-1-5 
compute-1-6 
compute-1-7 
compute-1-8 
compute-1-9 
compute-1-10
compute-1-11
compute-1-12
compute-1-13
compute-1-14
compute-1-15
compute-1-16
compute-1-17
compute-1-18
compute-1-19
compute-1-20
compute-1-21
compute-1-22
compute-1-23
compute-1-24
compute-1-25
compute-1-26
compute-1-27
compute-1-28
compute-1-29
compute-2-0 
compute-2-1 
compute-2-2 
compute-2-3 
compute-2-4 
compute-2-5 
compute-2-6 
compute-2-7 
compute-2-8 
compute-2-9 
compute-2-10
compute-2-11
compute-2-12
compute-2-13
compute-2-14
compute-2-15
compute-2-16
compute-2-17
compute-2-18
compute-2-19
compute-2-20
compute-2-21
compute-2-22
compute-2-23
compute-2-24
compute-2-25
compute-2-26
compute-2-27
compute-2-28
compute-2-29
compute-1-40
compute-1-41
compute-2-38
compute-2-39
compute-2-40
compute-2-41
compute-2-42
compute-2-43
compute-2-44
compute-2-45
compute-2-46
compute-2-47
compute-2-48
compute-2-49
compute-1-42
compute-1-43
compute-1-44
compute-1-45
compute-1-46
compute-1-47
compute-1-48
compute-1-49
compute-1-50
compute-1-51
compute-1-52
"


echo
echo "Machine           Nodes"
echo "----------------  -----"

for x in $nodelist8
do
   a=`pbsnodes $x`
   ijobs=`echo $a |  grep -c "jobs ="`
   idown=`echo $a |  grep -c "offline"`
   if [ $ijobs == 0 -a $idown == 0 ] ; then
       printf "%-18s%2d\n" $x 12
   fi 
done

echo "Machine           Nodes"
echo "----------------  -----"
for x in $nodelist12
do
   a=`pbsnodes $x`
   ijobs=`echo $a |  grep -c "jobs ="`
   idown=`echo $a |  grep -c "offline"`
   if [ $ijobs == 0 -a $idown == 0 ] ; then
       printf "%-18s%2d\n" $x 12
   fi 
done

echo "----------------  -----"


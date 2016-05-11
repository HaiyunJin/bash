#!/bin/bash
#
# Find out free nodes on phoenix
# Created 2015/07/13 Haiyun Jin
#

chem8="compute-0-16  compute-0-17  compute-0-18  compute-0-19  compute-0-20  compute-0-21  compute-0-22  compute-0-23  compute-0-24  compute-0-25  compute-0-27  compute-0-28  compute-0-29 "
chem12="compute-1-0  compute-1-1  compute-1-2  compute-1-3  compute-1-4  compute-1-5  compute-1-6  compute-1-7  compute-1-8  compute-1-9 compute-1-10 compute-1-11 compute-1-12 compute-1-13 compute-1-14 compute-1-15 compute-1-16 compute-1-17 compute-1-18 compute-1-19 compute-1-20 compute-1-21 compute-1-22 compute-1-23 compute-1-24 compute-1-25 compute-1-26 compute-1-27 compute-1-28 compute-1-29  compute-2-0  compute-2-1  compute-2-2  compute-2-3  compute-2-4  compute-2-5  compute-2-6 compute-2-7  compute-2-8  compute-2-9 compute-2-10 compute-2-11 compute-2-12 compute-2-13 compute-2-14 compute-2-15 compute-2-16 compute-2-17 compute-2-18 compute-2-19 compute-2-20 compute-2-21 compute-2-22 compute-2-23 compute-2-24 compute-2-25 compute-2-26 compute-2-27 compute-2-28 compute-2-29 "
chem1262="compute-1-40 compute-1-41 compute-1-42 compute-1-43 compute-1-44 compute-1-45 compute-1-46 compute-1-47 compute-1-48 compute-1-49 compute-1-50 compute-1-51 compute-1-52 "
chembigdisk="compute-2-38 compute-2-39 compute-2-40 compute-2-41 compute-2-42 compute-2-43 compute-2-44 compute-2-45 compute-2-46 compute-2-47 compute-2-48 compute-2-49 "
cui12="compute-1-30 compute-1-31 compute-1-32 compute-1-33 compute-1-34 compute-1-35 "

function proceed {
pbsnodes  -x $list |sed  -r 's$</Node><Node>$&\n$g' > /dev/shm/qhosttemp_$LOGNAME
while read -r line
do      # if jobs is empty, then it is full to be used
        jobs=`echo $line | grep -IRPo  "(?<=<jobs>).+(?=</jobs>)" `    # get jobs information
        if [ "$jobs" == "" ] ; then
            name=`echo $line | grep -IRPo  "(?<=<name>).+(?=</name>)"`     # get node name
            printf  "%-18s%4s%16s%15s\n" $name $np $mem 
        else  
            freenp=`echo $np - $(echo $jobs | sed 's/, /\n/g' | wc -l) | bc -l `
            if [ $freenp != 0 ] ; then
                name=`echo $line | grep -IRPo  "(?<=<name>).+(?=</name>)"`     # get node name
                printf  "%-18s%4s%16s%15s\n" $name $freenp $mem # $properties
            fi
        fi
done <  /dev/shm/qhosttemp_$LOGNAME
}

function draw_a_line { echo "----------------  ----------  ---------";};
function write_title { draw_a_line; printf "%15s"  "$title"
                                     echo  "   Free Nodes  Tot. Mem." ; draw_a_line; } ;

title=' 8 core Machine' ; write_title ; 
    properties="Default" ;  list=$chem8       ; mem=23  ; np=8  ; proceed ;
title='12 core Machine' ; write_title ;
    properties="Default" ;  list=$chem12      ; mem=47  ; np=12 ; proceed ;
    properties="Default" ;  list=$chem1262    ; mem=62  ; np=12 ; proceed ;
    properties="bigdisk" ;  list=$chembigdisk ; mem="62,bgdsk"  ; np=12 ; proceed ;
title='  Cui Machine  ' ; write_title ;
    properties="cui"     ;  list=$cui12       ; mem=31  ; np=12 ; proceed ;
draw_a_line;

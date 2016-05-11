#!/bin/bash
#
#  Find out free nodes on phoenix
# 
# Created 2015/07/13 Haiyun Jin
#


pbsnodes  -x | sed  -r 's$<\Node>$&\n$g'  > /dev/shm/qhosttemp_$LOGNAME

echo
echo " Machine name     Free Nodes  Tot. Mem.         Properties      "
echo "----------------  ----------  ---------  -----------------------"

mem='dontcare'

while read -r line
do 
    #state=`echo $line | grep -IRPo  "(?<=<state>).+(?=</state>)"`     # get state, if job-exclusive, no output
    #status=`echo $line | grep -IRPo  "(?<=<status>).+(?=</status>)"`

    # if not chemnodes or cuinodes, skip
    properties=`echo $line | grep -IRPo  "(?<=<properties>).+(?=</properties>)"`     # get properties, if not chemnodes or cuinodes, skip
    if [ "`echo $properties | grep "chemnodes\|cuinodes"`" != "" ] ; then
#echo "properties" $properties
        # if jobs is empty, then it is full of use
        jobs=`echo $line | grep -IRPo  "(?<=<jobs>).+(?=</jobs>)" `    # get jobs information
        np=`echo $line | grep -IRPo  "(?<=<np>).+(?=</np>)"`   # get np, number of process
# if people do not care about mem
#        mem=`echo  $( echo $line  | grep -IRPo  "(?<=physmem=)\d+" )/1024/1024  | bc -l | cut -d . -f1`
        if [ "$jobs" == "" ] ; then
            name=`echo $line | grep -IRPo  "(?<=<name>).+(?=</name>)"`     # get node name
            printf  "%-18s%4s%16s%25s\n" $name $np $mem $properties
        else  
            freenp=`echo $np - $(echo $jobs | sed 's/, /\n/g' | wc -l) | bc -l `
            if [ $freenp != 0 ] ; then
                name=`echo $line | grep -IRPo  "(?<=<name>).+(?=</name>)"`     # get node name
                printf  "%-18s%4s%16s%25s\n" $name $freenp $mem $properties
            fi
        fi
    fi
done <  /dev/shm/qhosttemp_$LOGNAME
echo "----------------  ----------  ---------  -----------------------"

rm -f /dev/shm/qhosttemp_$LOGNAME


#!/bin/bash

qnodes > qnodefile
echo
echo "Machine           Nodes"
echo "----------------  ------"

a=`grep -n "^compute" qnodefile`
for x in $a
do
   line=`echo $x | cut -d : -f1`
   node=`echo $x | cut -d : -f2`
   nodeinfo=`sed -n "$[line],$(($line+7))p"  qnodefile `

   ichemnode=`echo $nodeinfo | grep "properties =" | grep -c "chemnodes"`
   if [ $ichemnode == 1  ] ; then
    ijobs=`echo $nodeinfo | grep -c "jobs ="`
    if [ $ijobs == 0 ] ; then
        np=`echo $nodeinfo | grep -IRPo  "(?<=np = )\d+"`
        echo "$node      $np"
    fi 
   fi

done
echo "----------------  ------"


rm -f qnodefile

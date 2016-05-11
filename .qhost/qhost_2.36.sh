
#!/bin/bash
#
#  Find out free nodes on phoenix
# 
# Updated 2015/07/12 Haiyun Jin


nodelist8=" compute-0-16 compute-0-17 compute-0-18 compute-0-19 compute-0-20 compute-0-21 compute-0-22 compute-0-23 compute-0-24 compute-0-25 compute-0-27 compute-0-28 compute-0-29 "

nodelist12smlmem="compute-1-0 compute-1-1 compute-1-2 compute-1-3 compute-1-4 compute-1-5 compute-1-6 compute-1-7 compute-1-8 compute-1-9 compute-1-10 compute-1-11 compute-1-12 compute-1-13 compute-1-14 compute-1-15 compute-1-16 compute-1-17 compute-1-18 compute-1-19 compute-1-20 compute-1-21 compute-1-22 compute-1-23 compute-1-24 compute-1-25 compute-1-26 compute-1-27 compute-1-28 compute-1-29 "
nodelist12smlmem="$nodelist12smlmem compute-2-0 compute-2-1 compute-2-2 compute-2-3 compute-2-4 compute-2-5 compute-2-6 compute-2-7 compute-2-8 compute-2-9 compute-2-10 compute-2-11 compute-2-12 compute-2-13 compute-2-14 compute-2-15 compute-2-16 compute-2-17 compute-2-18 compute-2-19 compute-2-20 compute-2-21 compute-2-22 compute-2-23 compute-2-24 compute-2-25 compute-2-26 compute-2-27 compute-2-28 compute-2-29 "

nodelist12bigmem="compute-1-40 compute-1-41 compute-1-42 compute-1-43 compute-1-44 compute-1-45 compute-1-46 compute-1-47 compute-1-48 compute-1-49 compute-1-50 compute-1-51 compute-1-52 "

nodelist12bigdisk=" compute-2-38 compute-2-39 compute-2-40 compute-2-41 compute-2-42 compute-2-43 compute-2-44 compute-2-45 compute-2-46 compute-2-47 compute-2-48 compute-2-49 "

cuinodelist=" compute-1-30 compute-1-31 compute-1-32 compute-1-33 compute-1-34 compute-1-35"


function process {
for x in $list
do
    a=`pbsnodes $x`
    ijobs=`echo $a | grep -c "jobs =" `
    if [ "$ijobs" != "0" ] ; then
        idown=`echo $a |  grep -c "offline"`
        if [ $idown == 0 ] ; then 
            freenode=`echo $totcore - $(echo $a  | grep -IRPo "\d+/\d+(?=.phoenix.chem.wisc.edu)" | wc -l)   | bc`
#            availmem=`echo  $( echo $a  | grep -IRPo  "(?<=physmem=)\d+" )/1024/1024  | bc -l | cut -d . -f1`
            if [ $freenode != 0 ] ;  then
                printf $format $x $freenode $mem
            fi
        fi
    else
        printf "%-18s%4s%12s\n" $x $totcore $mem
    fi
done
}


echo
echo " 8 core Machine   Free Nodes  Avail.Mem"
echo "----------------  ----------  ---------"

list=$nodelist8  ; totcore=8 ; mem=23 ; format="%-18s%4s%12s\n" ;
process

echo "----------------  ----------  ---------"
echo "12 core Machine   Free Nodes  Avail.Mem"
echo "----------------  ----------  ---------"

list=$nodelist12smlmem  ; totcore=12 ; mem=47 ; format="%-18s%4s%12s\n" ;
process

list=$nodelist12bigmem  ; totcore=12 ; mem=62 ; format="%-18s%4s%12s\n" ;
process

list=$nodelist12bigdisk  ; totcore=12 ; mem="62,bgdsk" ; format="%-18s%4s%16s\n" ;
process

echo "----------------  ----------  ---------"
echo "   cui  Machine   Free Nodes  Avail.Mem"
echo "----------------  ----------  ---------"
list=$cuinodelist  ; totcore=12 ; mem=31 ; format="%-18s%4s%12s\n" ;
process


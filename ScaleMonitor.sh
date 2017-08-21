#!/bin/bash -e

#laborcost="20"     # cost per hour to drive Trimming multipiler
#trimmultipiler="1" # hours to process an ounce


if [ -z "$1" ]
then
 echo "Pass Param 1 as weight in grams"
exit 2
else
 WEIGHT=$1
fi

if [ -z "$2" ]
then
echo "Pass Param 2 Product 'BB'=Buds on a Branch 'HM'=Hand Manicure 'WP'=Wet plant"
exit 3
else
   if [[ $2 = "BB" ]]
   then
    product="Bud on a Branch"
   elif [[ $2 = "HM" ]]
   then
    product="Hand Manicured"
   elif [[ $2 = "WP" ]]
   then
    product="Wet Plant"
   else
    echo "Wrong Product Description,  Use BB, HM, WP"
    exit 4
   fi
fi

if [ "$4" ]
then
PRICE="$4"
echo "Price per gram set to $ $4"
else
PRICE="3.45"
fi



if [ -z "$3" ]
then
echo "Pass Param 2 Product 'F'=Fine 'R'=Rough 'Raw'=Raw"
exit 3
else
   if [[ $3 = "F" ]]
   then
    PRICE=$(awk -v p="${PRICE}" 'BEGIN {printf "%.2f", (p*w)*t; exit(0)}')
   elif [[ $3 = "R" ]]
   then
    trim="Rough"
   elif [[ $3 = "Raw" ]]
   then
    trim="Raw"
   else
    echo "Wrong Trim input Use  F, R, Raw "
    exit 4
   fi
fi

NAME="Black Jack"
SPECIES="Sativa dominate" # "Sativa Dominate" "Indica Dominsate" "Sativa/Indica"
CBD="1.06"
THC="14.3"
#product="Bud on a Branch" # "Hand Manicured" "Bud on a Branch" "Wet Plant"
#trim="Rough"   # "Fine"  "Rough"  "Raw"
grade="Mid"   # "Top"  "Mid"  "Low"  "Shake"
farmname=" Fire\n Farms"
county=" Yolo"
tax="1.0775"
caltax=".0775"

C='$'
#WEIGHT=$(cat /dev/ttyUSB0 | grep -E -o '[0-9]{1,4}[.][0-9]{2}' -m 1)

TCAL=$(awk -v t="${caltax}" -v w="${WEIGHT}" -v p="${PRICE}" 'BEGIN {printf "%.2f", (p*w)*t; exit(0)}')
TOTAL=$(awk -v t="${tax}" -v w="${WEIGHT}" -v p="${PRICE}" 'BEGIN {printf "%.2f", (p*w)*t; exit(0)}')

echo $TOTAL
##############################
### Original Lable layout ####
#############################
#convert -size 1200x600 -font DejaVu-Sans-Mono-Bold -pointsize 52 label:"\n\n\nUnit price\nNet weight\nTotal Price" label1.png
#convert label1.png \
#        -gravity northwest -pointsize 60 -annotate 0 "$NAME" \
#        -gravity northeast -pointsize 60 -annotate 0 "$SPECIES" \
#        -gravity north     -pointsize 52 -annotate 0 "\n\n\n THC:$THC \%           CBD:$CBD \%" -geometry +20+20 \
#        -gravity northeast -pointsize 52 -annotate 0 "\n\n\n\n\n$C$PRICE/g  \n$WEIGHT/g  \n$C$TOTAL  " \
#        -gravity southeast -pointsize 42 -annotate 0 "Trim: $trim" \
#        -gravity southwest -pointsize 36 -annotate 0 "Grade: $grade" \
#        label5.png
#######################################
#######################################

##############################
### latest Label layout ####
#############################
convert -size 1200x600 -font DejaVu-Sans-Mono-Bold -pointsize 72 label:"\n\n\n$county\n$farmname" label1.png
convert label1.png \
        -gravity northwest -pointsize 60 -annotate 0 "Trim: $trim" \
        -gravity northwest -pointsize 72 -annotate 0 "\n$product" \
        -gravity northeast -pointsize 82 -annotate 0 "$NAME" \
        -gravity northeast -pointsize 54 -annotate 0 "\n\n$SPECIES" \
        -gravity northeast -pointsize 54 -annotate 0 "\n\n\nTHC: $THC \% \n CBD: $CBD \% \n$C$PRICE/g     \n$WEIGHT/g wt\nTax:$C$TCAL" \
        -gravity northeast -pointsize 82 -annotate +0+10 "\n\n\n\n\n\n$C$TOTAL" \
        -gravity southeast -pointsize 52 -annotate 0 "Grade: $grade" \
        label5.png
#######################################
#######################################




composite -dissolve 65% -gravity south /root/logo/Logo-Back.png label5.png label.png

/root/raspberrypi-label-printer/PrintLabel label.png

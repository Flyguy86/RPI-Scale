#!/bin/bash -e

PRICE="3.65"
NAME="Girl Scout Cookies"
#NAME="Romulin Grapefruit"
SPECIES="Sativa Hybrid 60/40"
CBD="1.06"
THC="14"
#WEIGHT='23.54'
#TOTAL='123.23'
GRADE='B'  # A, B, C, SH, TRM
TRIM='Rough' # Raw, Rough, Fine,
C='$'
WEIGHT=$(cat /dev/ttyUSB0 | grep -E -o '[0-9]{1,4}[.][0-9]{2}' -m 1)
TOTAL=$(awk -v w="${WEIGHT}" -v p="${PRICE}" 'BEGIN {printf "%.2f", p*w; exit(0)}')

#echo $WEIGHT
#echo $RESULT
#convert Rot-Logo-Back.png

convert -size 1200x600 -font DejaVu-Sans-Mono-Bold -pointsize 52 label:"\n\n\nUnit price\nNet weight\nTotal Price" label1.png
#composite -pointsize 42 -gravity southeast label:"Trim: $TRIM" label3.png label4.png
#composite -pointsize 36 -gravity southwest label:"Grade: $GRADE\nA=1'\nB=2'\nC=3'\nSH=Shake\nTRM=Trim" label4.png label5.png
convert label1.png \
        -gravity northwest -pointsize 60 -annotate 0 "$NAME" \
        -gravity northeast -pointsize 60 -annotate 0 "$SPECIES" \
        -gravity north     -pointsize 52 -annotate 0 "\n\n THC:$THC \%           CBD:$CBD \%" -geometry +20+20 \
        -gravity northeast -pointsize 52 -annotate 0 "\n\n\n\n$C$PRICE/g  \n$WEIGHT/g  \n$C$TOTAL  " \
        -gravity southeast -pointsize 42 -annotate 0 "Trim: $TRIM" \
        -gravity southwest -pointsize 36 -annotate 0 "Grade: $GRADE" \
        label5.png
composite -dissolve 65% -gravity south Logo-Back.png label5.png label.png

/root/raspberrypi-label-printer/PrintLabel label.png

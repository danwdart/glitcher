#!/bin/bash
SEQ=$(seq 97 122)
FILE=$1
NAME=$2
OUTHTML=$NAME.html
EXT_GLITCH=jpg
EXT_LOSSLESS=png
tochar() {
    printf "\\$(printf %o $1) "
}
a_to_z() {
    for NUM in $SEQ
    do
        tochar $NUM
    done
}
A_TO_Z=$(a_to_z)

echo "<!doctype html>" > $OUTHTML
OUTER=0
for CHAROUTER in $A_TO_Z
do
    OUTPUT=$NAME-$OUTER.gif
    echo "Creating $OUTPUT..."
    INNER=0
    for CHARINNER in $A_TO_Z
    do
        FILE_TMPL=$NAME-$OUTER-$INNER
        FILE_GLITCH=$FILE_TMPL.$EXT_GLITCH
        FILE_LOSSLESS=$FILE_TMPL.$EXT_LOSSLESS
        echo "Copying $FILE to $FILE_GLITCH"
        convert -resize 25% $FILE $FILE_GLITCH
        echo "Glitching $CHAROUTER to $CHARINNER in $FILE_GLITCH"
        sed -i "s/$CHAROUTER/$CHARINNER/g" $FILE_GLITCH
        echo "Converting $FILE_GLITCH to $FILE_LOSSLESS"
        convert -type grayscale $FILE_GLITCH $FILE_LOSSLESS 2>/dev/null
        echo Removing $FILE_GLITCH
        rm $FILE_GLITCH
        INNER=$[$INNER + 1]
    done
    echo "Converting $NAME-$OUTER-*.$EXT_LOSSLESS to $OUTPUT"
    convert -loop 0 -delay 1 $NAME-$OUTER-*.$EXT_LOSSLESS $OUTPUT
    echo "Removing $NAME-$OUTER-*.$EXT_LOSSLESS"
    rm $NAME-$OUTER-*.$EXT_LOSSLESS
    echo "Adding $OUTPUT to $OUTHTML"
    echo "<img src=\"$OUTPUT\" alt=\"$OUTPUT\"/>" >> $OUTHTML
    OUTER=$[$OUTER + 1]
done

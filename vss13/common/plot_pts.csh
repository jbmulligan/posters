#!/bin/csh

# source this file with $ptfile set to a file with x,y coords

set datafile=$ptfile

# this makes a thick line
echo "0.08 in setlinewidth" >> $psfile

if( $?color ) then
  if( $color == black ) then
    echo "0 0 0 setrgbcolor" >> $psfile
  else if( $color == green ) then
    echo "0 0.7 0 setrgbcolor" >> $psfile
  else if( $color == red ) then
    echo "0.8 0 0 setrgbcolor" >> $psfile
  else
    echo Oops, unexpected color: $color
    exit
  endif
endif

head -1 < $datafile | dm x1 '"gxu"' x2 '"gyu moveto"' >> $psfile
cat $datafile | dm x1 '"gxu"' x2 '"gyu l"' >> $psfile


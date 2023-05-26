#!/bin/csh

# source this file to draw a noise floor box on
# a correlogram plot.
#
# $xmin, $xmax, +=$max_sigma are the dimensions

echo "0.9 0.9 0.9 setrgbcolor" >> $psfile
echo "newpath" >> $psfile
echo "$xmin gxu $max_sigma gyu moveto" >> $psfile
echo "$xmax gxu $max_sigma gyu lineto" >> $psfile
echo "$xmax gxu -$max_sigma gyu lineto" >> $psfile
echo "$xmin gxu -$max_sigma gyu lineto" >> $psfile
echo "closepath fill" >> $psfile


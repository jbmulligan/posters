#!/bin/csh

if( $#argv != 1 ) then
  echo usage:  sweep_fig.csh device
  exit
endif

if( $1 == iPad2 ) then
  set xspan=7.758
  set yspan=5.818
else if( $1 == iPod4 ) then
  set xspan=2.945
  set yspan=1.963
else
  echo Device choices:  "iPad2|iPod4"
  exit
endif
set stem=$1

# general purpose script to make a postscript graph

set psdir=$HOME/working/postscript
set psfile=/tmp/psfile
cat $psdir/jbm_head.ps $psdir/jbm_page.ps $psdir/plotmacs.ps > $psfile

# these lines determine the size and placement on the page
# make it iPad-size...
set figfile=../figures/${stem}_sweep.eps

# we want landscape!?

set ybase=1.5
set gx0=2.0		# the graphing region, not the whole plot...

set smfontsiz=12
set lgfontsiz=16

# posn_axes sets the parameters to draw a position plot
source ${stem}_sweep_axes.csh
source ../common/draw_axes.csh

#echo "0.015 in setlinewidth" >> $psfile
echo "0.035 in setlinewidth" >> $psfile

cat $psdir/jbm_trailer.ps >> $psfile

epstool --copy --bbox /tmp/psfile /tmp/psfile2
epstool --add-tiff-preview --device tiff24nc /tmp/psfile2 $figfile


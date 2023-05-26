#!/bin/csh
set echo

set xspan=3.5
set yspan=3.5

# general purpose script to make a postscript graph

set psdir=$HOME/working/postscript
set psfile=/tmp/psfile
cat $psdir/jbm_head.ps $psdir/jbm_page.ps $psdir/plotmacs.ps > $psfile

set figfile=../figures/sens_vs_n.eps

# we want landscape!?

set ybase=3.5
set gx0=2.0		# the graphing region, not the whole plot...

set smfontsiz=12
set lgfontsiz=16

# posn_axes sets the parameters to draw a position plot
source sens_axes.csh
source ../common/draw_axes.csh

# Now plot some data...
#set ptfile=/tmp/pts
#set color=green
#set ptfile=ascii/fit$n_swipes.asc
#source ../common/plot_pts.csh

set i=1
set color=black
set ptfile=/tmp/pts
cat < /dev/null > $ptfile
foreach n ( 1 2 3 4 5 6 7 8 9 10 )
  set f=`cat ascii/peak_sens$n.asc`
  echo $n $f >> $ptfile
end
#source ../common/plot_pts.csh
set symbol=filled_circle
source ../common/plot_symbols.csh

#echo "0.015 in setlinewidth" >> $psfile
echo "0.035 in setlinewidth" >> $psfile

cat $psdir/jbm_trailer.ps >> $psfile

epstool --copy --bbox /tmp/psfile /tmp/psfile2
epstool --add-tiff-preview --device tiff24nc /tmp/psfile2 $figfile


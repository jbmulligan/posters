#!/bin/csh
set echo

if( $#argv != 1 ) then
  echo usage:  csf_fig.csh n_inputs
  exit
endif

set n_swipes=$1

set xspan=3.5
set yspan=3.5

# general purpose script to make a postscript graph

set psdir=$HOME/working/postscript
set psfile=/tmp/psfile
cat $psdir/jbm_head.ps $psdir/jbm_page.ps $psdir/plotmacs.ps > $psfile

set figfile=../figures/csf$n_swipes.eps

# we want landscape!?

set ybase=1.5
set gx0=2.0		# the graphing region, not the whole plot...

set smfontsiz=12
set lgfontsiz=16

# posn_axes sets the parameters to draw a position plot
source csf_axes.csh
source ../common/draw_axes.csh

# Now plot some data...
#set ptfile=/tmp/pts
#set color=green
#set ptfile=ascii/fit$n_swipes.asc
#source ../common/plot_pts.csh

set i=1
set color=black
while( $i <= $n_swipes )
  set ptfile=ascii/swipe$i.asc
  source ../common/plot_pts.csh
  @ i ++
end
set color=red
set ptfile=ascii/fit$n_swipes.asc
source ../common/plot_pts.csh
#source ../common/trace_legend.csh

#echo "0.015 in setlinewidth" >> $psfile
echo "0.035 in setlinewidth" >> $psfile

cat $psdir/jbm_trailer.ps >> $psfile

epstool --copy --bbox /tmp/psfile /tmp/psfile2
epstool --add-tiff-preview --device tiff24nc /tmp/psfile2 $figfile


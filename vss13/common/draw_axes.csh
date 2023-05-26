#!/bin/csh

# This file should be sourced, assumed certain vars defined.
# $psfile - the output postscript file
# $ybase - height on the page in inches
# $xspan - plot span in inches
# $yspan - plot span in inches
# $gx0 - offset from left side in inches
#
# $xmin, $xmax, $xtick - user units
# $ymin, $ymax, $ytick - user units


#%% for landscape mode, uncomment these two lines
#
#%% landscape mode
#%90 rotate
#%0 in -8.5 in translate

echo "0 0 0 setrgbcolor" >> $psfile
echo "/ybase $ybase in def" >> $psfile
echo "/xspan $xspan in def" >> $psfile
echo "/yspan $yspan in def" >> $psfile

# graphing region on page in inches

#/gx0 2.0 in def
#/gdx 5 in def

echo "/gx0 $gx0 in def" >> $psfile
echo "/gdx $xspan in def" >> $psfile
echo "/gy0 ybase def" >> $psfile
echo "/gdy yspan def" >> $psfile

echo "/smfsiz $smfontsiz def" >> $psfile
echo "/lgfsiz $lgfontsiz def" >> $psfile

# graph units to be mapped to graphing region
# set these to suit the particular application
# /guxmin -100.0 def
# /guxmax 700.0 def
echo "/guxmin $xmin def" >> $psfile
echo "/guxmax $xmax def" >> $psfile
echo "/guymin $ymin def" >> $psfile
echo "/guymax $ymax def" >> $psfile
echo "/gudx guxmax guxmin sub def" >> $psfile
echo "/gudy guymax guymin sub def" >> $psfile

# % /Times-Roman findfont smfsiz scalefont setfont
echo "/Helvetica findfont smfsiz scalefont setfont" >> $psfile
echo "newpath" >> $psfile

# draw vertical axis labels
echo "[ ] 0 setdash" >> $psfile

#
echo "/draw_frame { simple_frame } def" >> $psfile

echo "/simple_frame {" >> $psfile
echo "frame" >> $psfile

# draw a line at y=0
if( ! $?no_y_zero_indicator ) then
  echo "newpath" >> $psfile
  echo "guxmin gxu 0 gyu moveto" >> $psfile
  echo "guxmax gxu 0 gyu l" >> $psfile
endif

# Now draw the ticks...
# We may not be happy with the number formatting???

if( $?first_ytick ) then
  set y=$first_ytick
else
  set y=$ymin
endif
set ok=1
set ascending=`echo $ymin $ymax | dm "if x1 < x2 then 1 else 0"`
while( $ok )
  echo "($y) $y ylabeltick" >> $psfile
  if( $ascending ) then
    set y=`echo $y $ytick | dm x1+x2`
    set ok=`echo $y $ymax | dm 'if x1<=x2 then 1 else 0'`
  else
    set y=`echo $y $ytick | dm x1-x2`
    set ok=`echo $y $ymax | dm 'if x1>=x2 then 1 else 0'`
  endif
end


if( $?first_xtick ) then
  set x=$first_xtick
else
  set x=$xmin
endif
set ok=1
while( $ok )
  echo "($x) $x xlabeltick" >> $psfile
  set x=`echo $x $xtick | dm x1+x2`
  set ok=`echo $x $xmax | dm 'if x1<=x2 then 1 else 0'`
end

echo "($ylegend) ylegend" >> $psfile
echo "($xlegend) xlegend" >> $psfile

echo "} def" >> $psfile

echo "draw_frame" >> $psfile


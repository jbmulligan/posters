#!/bin/csh

if( $#argv != 1 ) then
  echo usage:  calc.csh device_name
  echo devices:  'iPad2|iPad4|iPadMini|iPod4|iPod4'
  exit
endif

if( $1 == iPad2 ) then
  set param_str="1024 768 132"
else if( $1 == iPad4 ) then
  set param_str="2048 1536 264"
else if( $1 == iPadMini ) then
  set param_str="1024 768 163"
else if( $1 == iPod4 ) then
  set param_str="960 640 326"
else if( $1 == iPod5 ) then
  set param_str="1136 640 326"
else
  echo Bad device specification: $1
  echo devices:  'iPad2|iPad4|iPadMini|iPod4|iPod4'
  exit
endif

set max_freq=`echo $param_str | dm x3 | dm 4/x1 y1/20 '1/(y2/(atan(1)/45))' | dm x3`
set min_freq=`echo $param_str | dm x1 x3 | dm '(x1/2)/x2' y1/20 '1/(y2/(atan(1)/45))' | dm x3`
set width_in=`echo $param_str | dm x1/x3`
set height_in=`echo $param_str | dm x2/x3`

echo Device $1
echo width:  $width_in inches
echo height:  $height_in inches
echo max SF:  $max_freq cpd
echo min SF:  $min_freq cpd

exit


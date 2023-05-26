# Look at the samples before 0 to estimate the noise level...

if( ! $?max_sigma ) set max_sigma=0

# BUG - use variables to set the limits?

if( ! $?noise_start_time ) set noise_start_time=-1000
if( ! $?noise_end_time ) set noise_end_time=0

cat -n $raw_file | dm "1000*((x1-513)/120)" x2 | \
  dm "if x1 >= $noise_start_time then INPUT else KILL" | \
  dm "if x1 < $noise_end_time then x2 else KILL" > /tmp/noise

set three_sigma=`cat /tmp/noise | mean | dm "x4*3"`
#echo three_sigma = $three_sigma
set max_sigma=`echo $max_sigma $three_sigma | dm 'max(x1,x2)'`


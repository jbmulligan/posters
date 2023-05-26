# draw a curve legend

echo "newpath" >> $psfile
echo "$legend_x gxu $legend_y gyu moveto" >> $psfile
echo "$legend_x $legend_delta_x add gxu $legend_y gyu l" >> $psfile

echo "$legend_x $legend_delta_x 1.2 mul add gxu $legend_y $legend_delta_y 0.25 mul add gyu moveto" >> $psfile
echo "($legend) show" >> $psfile

set legend_y=`echo $legend_y $legend_delta_y | dm x1+x2`


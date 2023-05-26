# draw a subject legend

echo "0 0 0 setrgbcolor" >> $psfile
echo "$subj_legend_x gxu $subj_legend_y gyu moveto" >> $psfile
echo "($subj_legend) show" >> $psfile


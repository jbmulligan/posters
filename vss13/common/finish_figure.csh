
cat $psdir/jbm_trailer.ps >> $psfile
epstool --copy --bbox /tmp/psfile /tmp/psfile2
epstool --add-tiff-preview --device tiff24nc /tmp/psfile2 $figfile


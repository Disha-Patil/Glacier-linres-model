#!/usr/bin/gnuplot -persist
set term pngcairo enh size 640,480;
set output "plots/band_v1.png";

LABEL = " A ";
set obj 1 rect at first 30,46.5 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 30,46.5 LABEL front center;

set xlabel "t ( yr )";
set ytics 4;
set mxtics;
set mytics 3;
#se yra[28:34];se yti 1;set mytics 2;
se yra[64:85];
set ylabel "Total volume ( 10 km^3 )";
p for[i=1:100] 'files/output_files/bands/total'.i.'' u 1:($2/10) w l lw 1 lc "light-blue" ti "",'files/output_files/total_scaling' u 1:($2/10) w l lw 1.5 lc "red" ti "Scaling", 'files/output_files/total_lin' u 1:($2/10) w l lw 1.5 lc "dark-blue" ti "Linear response",'files/output_files/total_sia' u 1:($2/10) w l lw 1.5 lc "orange" ti "SIA" ;

set term qt;
set term pngcairo enh size 640,480;
set output "plots/band_a1.png";

LABEL = " B ";
set obj 1 rect at first 35,46.5 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 35,46.5 LABEL front center;

set xlabel "t ( yr )";
set ytics 2;
set mxtics 5;
set mytics 4;
#se yra[25:27];se yti 1;set mytics 2;
se yra[60:69];
set ylabel "Total area ( 100 km^2 )";
p for[i=1:100] 'files/output_files/bands/total'.i.'' u 1:($3/100) w l lw 1 lc "light-blue" ti "",'files/output_files/total_scaling' u 1:($3/100) w l lw 1.5 lc "red" ti "Scaling", 'files/output_files/total_lin' u 1:($3/100) w l lw 1.5 lc "dark-blue" ti "Linear response",'files/output_files/total_sia' u 1:($3/100) w l lw 1.5 lc "orange" ti "SIA" ;

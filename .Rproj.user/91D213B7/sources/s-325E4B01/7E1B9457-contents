#!/usr/bin/gnuplot -persist

set term pngcai enh;


#set output "plots/time_evol1.png";
#
#LABEL = " B ";
#set obj 1 rect at first 70,0.2 size char strlen(LABEL), char 1.5 ;
#set obj 1 fillstyle empty border -1 front;
#set label 1 at 70,0.2 LABEL front center;

#set log xy;
#set xrange[2:100];
#set yrange[0.1:10];
#set xlabel "Area ( km^2 )";
#set ylabel "Volume ( km^3 )" offset 2,0;
#p for[i=15:25] 'input_files/random200_scaling/'.i.'s.txt' u 3:2 w l lw 1.5 lc 1 ti "", for[i=15:25] 'input_files/random200_sia/'.i.'.txt' u 3:($2*1) w l lw 1.5 lc 3 ti "";


set output "plots/time_evol1.png";
LABEL = " B ";
set obj 1 rect at first 70,0.2 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 70,0.2 LABEL front center;

set log xy;
set xrange[1:200];
set yrange[0.1:50];
set xlabel "Area ( km^2 )";
set ylabel "Volume ( km^3 )" offset 2,0;
#p for[i=15:25] 'input_files/random200_scaling/'.i.'s.txt' u 3:2 w l lw 1.5 lc 1 ti "", for[i=15:25] 'input_files/random200_sia/'.i.'.txt' u 3:($2*1) w l lw 1.5 lc 3 ti "";#4A235A

p for [fsc in system("ls ./files/scaling/scaling_*")] fsc u 3:2 w l lw 1.5 lc "#334A235A" ti "", for [fsi in system("ls ./files/sia_500/va_*")] fsi u 3:($2*1) w l lw 1 lc "#993498DB" ti "";



set output "plots/time_evol2.png";
LABEL = " B ";
set obj 1 rect at first 70,0.2 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 70,0.2 LABEL front center;

set log xy;
set xrange[1:200];
set yrange[0.1:50];
set xlabel "Area ( km^2 )";
set ylabel "Volume ( km^3 )" offset 2,0;
#p for[i=15:25] 'input_files/random200_scaling/'.i.'s.txt' u 3:2 w l lw 1.5 lc 1 ti "", for[i=15:25] 'input_files/random200_sia/'.i.'.txt' u 3:($2*1) w l lw 1.5 lc 3 ti "";

p for [fsc in system("ls files/random/scaling_*")] fsc u 3:2 w l lw 1.5 lc "#4A235A" ti "", for [fsi in system("ls files/random/va_*")] fsi u 3:($2*1) w l lw 1.5 lc "#3498DB" ti "";




set output "plots/scaling_c1.png";

reset

set xrange[1:200];
set yrange[0.1:50];
LABEL = " A ";
set log xy;
set obj 1 rect at first 70,0.17 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 70,0.17 LABEL front center;

set key left;

set xlabel "Area ( km^2 )";
set ylabel "Volume ( km^3 )" offset 3,0;
#----------------------------------------------------------------
mean(x)= m
fit mean(x) 'files/output_files/area_volume.txt' u (log10($2)):(log10($1)) via m
SST = FIT_WSSR/(FIT_NDF+1)

f(x)=log10(a)+1.2857*x;
a=0.05
fit f(x) 'files/output_files/area_volume.txt' u (log10($2)):(log10($1)) via a;

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R2i=SSR/SST

#--------------------------------------------------------------------

g(x)=log10(b)+1.2857*x;
b=a;

mean(x)= m
fit mean(x) 'files/output_files/area_volume_final.txt' u (log10($2)):(log10($1)) via m
SST = FIT_WSSR/(FIT_NDF+1)


fit g(x) 'files/output_files/area_volume_final.txt' u (log10($2)):(log10($1)) via b;

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R2f=SSR/SST

#----------------------------------------------------------------------------

set yrange[0.1:50];
set xrange[1:200];
#p 'area_volume.txt' u 2:1 w p pt 6 ps 0.75 lc "#3dcdff" ti "",'area_volume_final.txt' u 2:1 w p pt 6 ps 0.75 lc "#f698ff" ti "", a*(x**1.2857) lc "dark-blue",b*(x**1.2857) lc "#ad00bd"

p 'files/output_files/area_volume.txt' u 2:1 w p pt 6 ps 0.75 lc "#00a77a" ti "",'files/output_files/area_volume_final.txt' u 2:1 w p pt 6 ps 0.75 lc "#b653d4" ti "", a*(x**1.2857) w l lw 1.5 lc "#00a77a" ti "",b*(x**1.2857) w l lw 1.5 lc "#b653d4" ti ""

set print "files/output_files/r2_av.txt"
print R2i
print R2f



###
reset; se te pngcai enh; se ou "plots/va_c.png";
se lab "SIA" at graph .5,.95; se ke at graph .5,.9;
se xra[1:200];se yra[.1:50];
se xla "area (km^2)"; se yla "volume (km^3)";
f(x)=a+1.286*x;
fit f(x) 'props.txt' u (log10($3)/($4==0)):(log10($2)) via a;
f1(x)=a1+1.286*x;
fit f1(x) 'files/output_files/area_volume_final.txt' u (log10($2)):(log10($1)) via a1;
se log xy
p 10**a*x**1.286 lc 1 ti sprintf("(%.3f{/Symbol \261}%.3f) x^{1.286}",10**a,a_err*1.286*(10**a)),10**a1*x**1.286 lc 2 ti sprintf("(%.3f{/Symbol \261}%.3f) x^{1.286}",10**a1,a1_err*1.286*(10**a1)) ,'props.txt' u ($3/($4==0)):2 w p pt 6 lc 1 ti "",'files/output_files/area_volume_final.txt' u ($2):1 w p pt 6 lc 2 ti "";
se te qt;

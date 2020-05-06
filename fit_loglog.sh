#!/usr/bin/gnuplot -persist

set fit errorvariables;
filenamee = "files/output_files/fit_data.txt"

#tau_a vs t*----------------------------------------------------------------

mean(x)= m
#fit mean(x) filenamee using (log10($12/($12<84))):(log10($10)) via m
fit mean(x) filenamee using (log10($12)):(log10($10)) via m
SST = FIT_WSSR/(FIT_NDF+1)

f(x) = log10(c4)+x;
#fit f(x) filenamee u (log10($12/($12<84))):(log10($10)) via c4;
fit f(x) filenamee u (log10($12)):(log10($10)) via c4;

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R24=SSR/SST


#tau_a tau_v---------------------------------------------------------------------

mean(x)= m
fit mean(x) filenamee using (log10($10)):(log10($8)) via m
SST = FIT_WSSR/(FIT_NDF+1)

f(x) = log10(c5)+x;
fit f(x) filenamee u (log10($10)):(log10($8)) via c5;

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R25=SSR/SST


#dvv vs alpha---------------------------------------------------------
mean(x)= m
#fit mean(x) filenamee using (log10($6/($6<0.21))):(log10($2)) via m
fit mean(x) filenamee using (log10($6)):(log10($2)) via m
SST = FIT_WSSR/(FIT_NDF+1)

f(x) = log10(c1)+x;
c2=1;
c2_err = 0;
#fit f(x) filenamee u (log10($6/($6<0.21))):(log10($2)) via c1;
fit f(x) filenamee u (log10($6)):(log10($2)) via c1;

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R21=SSR/SST

#dvv vs daa----------------------------------------------------------------
mean(x)= m
#fit mean(x) filenamee using (log10($4/($4<0.28))):(log10($2)) via m
fit mean(x) filenamee using (log10($4)):(log10($2)) via m
SST = FIT_WSSR/(FIT_NDF+1)

f(x) = log10(c3)+x;
#fit f(x) filenamee u (log10($4/($4<0.28))):(log10($2)) via c3
fit f(x) filenamee u (log10($4)):(log10($2)) via c3

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R23=SSR/SST


set print "files/output_files/fit_parameters.txt"
print c1,c1_err
print c2,c2_err
print c3,c3_err
print c4,c4_err
print c5,c5_err

set print "files/output_files/r2.txt"
print R21
print "nan"
print R23
print R24
print R25


#t-t-------------------------------------------------------------------------------------
reset;
set xrange[19:500];
set yrange[:300];
#set ytics 50;
se te pngcai enh;
se ou "plots/tt_sia_1.png";

LABEL = " B ";
set obj 1 rect at first 250,15 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 250,15 LABEL front center;

unse ke;
set logscale xy;
se lab "SIA" at graph .5,.95;se ke at graph .5,.8;
se xla "{/Symbol t}_A (years)";
se yla "{/Symbol t}_V (years)" offset 1,0;
f(x)=c5*x;
p f(x) ti sprintf("y=(%.3f {/Symbol\261} %.3f)x \n R2 = %.3f",c5,c5_err,R25), 'files/output_files/fit_data.txt' u 10:8 w p pt 6 lc 3 ti "";


#dv/v - da/a------------------------------------------------------------------------
reset;
#set xti 0.1;
set yrange[:0.7];
set xrange[0.01:0.6];
se te pngcai enh;
#set mxtics 2;
#set mytics 2;
se ou "plots/dvvdaa_sia_1.png";

LABEL = " B ";
set obj 1 rect at first 0.35,0.015 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 0.35,0.015 LABEL front center;

unse ke;
set logscale xy;
se lab "SIA" at graph .45,.95;se ke at graph .5,.8;
se xla "{/Symbol D}A/A";
se yla "{/Symbol D}V/V" offset 2,0;
f(x)=c3*x;
#p f(x)ti "" lc 1, filenamee u 4:2 w p pt 6 lc  "#616161", '' u 4:2 w p pt 6 lc 3 ;
#p f(x)ti "" lc 1, filenamee u 4:2 w p pt 6 lc  "#616161", '' u ($4/($4<0.28)):2 w p pt 6 lc 3 ;
p f(x)ti sprintf("y=(%.2f {/Symbol\261} %.2f)x \n R2 = %.3f",c3,c3_err,R23) lc 1, filenamee u 4:2 w p pt 6 lc 3 ti "";#"#616161"


# dv/v - alpha---------------------------------------------------------------------
reset;
set logscale xy;
se te pngcai enh;
se ou "plots/dvv_sia_1.png";

LABEL = " B ";
set obj 1 rect at first 0.7,0.03 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 0.7,0.03 LABEL front center;


set xrange[0.02:1];
set yrange[0.02:1];
unse ke;
se lab "SIA" at graph .5,.95;se ke at graph .95,.4;
se yla "{/Symbol D}V/V" offset 2,0;
se xla "{/Symbol a}^{*}";
#se logscale;
f(x)= c1*x
#p f(x)ti "" lc 1, filenamee u 6:2 w p pt 6 lc  "#616161", '' u ($6/($6<0.21)):2 w p pt 6 lc 3 ;
p f(x) ti sprintf("y=(%.2f {/Symbol\261} %.2f)x \n R2 = %.3f",c1,c1_err, R21) lc 1, filenamee u 6:2 w p pt 6 lc 3 ti "";# "#616161"


#tauA - t*-----------------------------------------------------------------------------
reset;
set logscale xy;
#set ytics 100;
#set mytics 2;
#set xtics 0.02;
#set mxtics;
set yrange[15:1000];
set xrange[10:150];
se te pngcai enh;
se ou "plots/taua_sia_1.png";

LABEL = " B ";
set obj 1 rect at first 117,21 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 117,21 LABEL front center;

unse ke;
se lab "SIA" at graph .5,.95;se ke at graph .95,.2;
se yla "{/Symbol t}_A (years)" offset 1,0;
se xla "{/Symbol t}^{*}  (years)";
f(x)=c4*x;
#p f(x)ti "" lc 1, filenamee u 12:10 w p pt 6 lc  "#616161", '' u ($12):10 w p pt 6 lc 3 ;
#p f(x)ti "" lc 1, filenamee u 12:10 w p pt 6 lc  "#616161", '' u ($12/($12<84)):10 w p pt 6 lc 3 ;
p f(x) ti sprintf("y=(%.2f {/Symbol\261} %.2f)x \n R2 = %.3f",c4,c4_err,R24) lc 1, filenamee u 12:10 w p pt 6 lc 3 ti "";#  "#616161"




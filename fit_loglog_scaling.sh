#!/usr/bin/gnuplot -persist

set fit errorvariables;
filenamee = "files/output_files/fit_data_scaling.txt"

#tau_a vs t*----------------------------------------------------------------

mean(x)= m
fit mean(x) filenamee using (log10($12)):(log10($10)) via m
SST = FIT_WSSR/(FIT_NDF+1)

f(x) = log10(c4)+x;
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
fit mean(x) filenamee using (log10($4)):(log10($2)) via m

SST = FIT_WSSR/(FIT_NDF+1)

f(x) = log10(c3)+x;
fit f(x) filenamee u (log10($4)):(log10($2)) via c3

SSE=FIT_WSSR/(FIT_NDF+1)

SSR=SST-SSE
R23=SSR/SST

set print "files/output_files/fit_parameters_scaling.txt"
print c1,c1_err
print c2,c2_err
print c3,c3_err
print c4,c4_err
print c5,c5_err

set print "files/output_files/r2_scaling.txt"
print R21
print "nan"
print R23
print R24
print R25

#t-t-------------------------------------------------------------------------------------
reset;
set logscale xy;
set xrange[10:120];
set yrange[8:120];
#set ytics 20;
#set mxtics;
#set mytics;
#set xtics 20;
se te pngcai enh;
se ou "plots/tt_sca1.png";

LABEL = " A ";
set obj 1 rect at first 100,10 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 100,10 LABEL front center;

unse ke;

se lab "Scaling" at graph .45,.95;se ke at graph .5,.8;
se xla "{/Symbol t}_A (years)";
se yla "{/Symbol t}_V (years)" offset 2,0;
f(x)=c5*x;
p f(x) ti sprintf("y=(%.3f {/Symbol\261} %.3f)x\n R2 = %.3f",c5,c5_err,R25),'files/output_files/fit_data_scaling.txt' u 10:8 w p pt 6 lc 3 ti "";


#dv/v - da/a------------------------------------------------------------------------
reset;
set logscale xy;
#set xti 0.1;
#set yti 0.1;
set yrange[0.009:0.5];
set xrange[0.007:0.4];
se te pngcai enh;
#set mxtics 2;
#set mytics 2;
se ou "plots/dvvdaa_sca1.png";

LABEL = " A ";
set obj 1 rect at first 0.27,0.014 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 0.27,0.014 LABEL front center;


unse ke;
se lab "Scaling" at graph .45,.95;se ke at graph .5,.8;
se xla "{/Symbol D}A/A";
se yla "{/Symbol D}V/V" offset 3,0;
f(x)=c3*x;
#p f(x)ti "" lc 1, filenamee u 4:2 w p pt 6 lc 6, '' u 4:2 w p pt 6 lc 3 ;
p f(x)ti sprintf("y=(%.2f {/Symbol\261} %.2f)x\n R2 = %.3f",c3,c3_err,R23) lc 1, filenamee u 4:2 w p pt 6 lc 3 ti "";

# dv/v - alpha---------------------------------------------------------------------
reset;
set logscale xy;
se te pngcai enh;
se ou "plots/dvv_sca1.png";

LABEL = " A ";
set obj 1 rect at first 0.7,0.014 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 0.7,0.014 LABEL front center;

unse ke;
#set yti 0.1;
#set mxti;
#set xti 0.2;
set xrange[0.02:1];
set yrange[0.009:0.5];
se lab "Scaling" at graph .45,.95;se ke at graph .95,.4;
se yla "{/Symbol D}V/V" offset 2,0;
se xla "{/Symbol a}^{*}";
#se logscale;
f(x)= c1*x
#p f(x)ti "" lc 1, filenamee u 6:2 w p pt 6 lc "#616161", '' u ($6/($6<0.21)):2 w p pt 6 lc 3 ;
p f(x) ti sprintf("y=(%.2f {/Symbol\261} %.2f)x\n R2 = %.3f",c1,c1_err,R21) lc 1, filenamee u 6:2 w p pt 6 lc 3 ti ""#"#616161"

#tauA - t*-----------------------------------------------------------------------------
reset;
set logscale xy;
#set ytics 50;
#set mytics 2;
#set xtics 0.02;
#set mxtics;
set yrange[9:200];
set xrange[10:150];
#se te pngcai enh;
#se ou "plots/taua_sca1.png";

LABEL = " A ";
set obj 1 rect at first 120,12 size char strlen(LABEL), char 1.5 ;
set obj 1 fillstyle empty border -1 front;
set label 1 at 120,12 LABEL front center;

unse ke;
se lab "Scaling" at graph .4,.95;se ke at graph .95,.4;
se yla "{/Symbol t}_A (years)" offset 1,0;
se xla "{/Symbol t}^{*} (years)";
f(x)=c4*x;
#p f(x)ti "" lc 1, filenamee u 12:10 w p pt 6 lc 6, '' u ($12):10 w p pt 6 lc 3 ;
p f(x) ti sprintf("y=(%.2f {/Symbol\261} %.2f)x\n R2 = %.3f",c4,c4_err,R24) lc 1, filenamee u 12:10 w p pt 6 lc 3 ti ""


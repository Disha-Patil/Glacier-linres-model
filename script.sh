#remove previous plots
#make new directory
rm -rf plots
mkdir plots

# fit with cutoffs
python fit_data.py

#total scale and sia
python scaling.py
python sum.py

# fit plots sia
./fit_loglog.sh

# scaling data
python fit_data_scaling.py

#fit plots scaling
./fit_loglog_scaling.sh

# get total in res
python lin_res.py

# the area vol for first plots
python av_scaling.py

# band for final plot
python normal_band.py

# band and first plots
./first_plot.sh
./band_plot.sh

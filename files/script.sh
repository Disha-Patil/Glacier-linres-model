rm -rf sia_500
mkdir sia_500 
cp /home/disha/disha/glacier/review_2/all_maps/results_ab/sia_outputs/va_* sia_500


cd ..

Rscript filter_glaciers.R

cd files

cd sia_500

ls -1 | grep -v -x -f nodelete_sia.txt | xargs -d "\n" -P 0 rm -f

rm -rf nodelete_sia.txt

for f in *; do 
    mv -- "$f" "${f%}.txt"
done


cd ..

rm -rf random
cp -r ../../random .

rm -rf scaling
mkdir scaling

rm -rf lin_res
mkdir lin_res

rm -rf output_files
mkdir output_files

cd output_files

rm -rf bands
mkdir bands

cd ..
cd ..






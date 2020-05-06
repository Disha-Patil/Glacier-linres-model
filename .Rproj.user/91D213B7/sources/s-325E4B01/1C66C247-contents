#avifile = open("output_files/area_volume.txt",'w')
#avffile = open("output_files/area_volume_final.txt",'w')

avifile = open("files/output_files/area_volume.txt",'w')
avffile = open("files/output_files/area_volume_final.txt",'w')
#with open("output_files/fit_data.txt") as f:ids = [int(j[0]) for j in [k.split() for k in f.readlines()]]
#with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]

with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]

for glid in prop_arr:
    print(glid[0])
    glid=glid[0][1:-1]
    with open("files/sia_500/va_%s.txt"%(glid)) as f:av_arr = [[float(j[0]), float(j[1]),float(j[2])] for j in [k.split() for k in f.readlines()]]
    [t,v0,a0] = av_arr[0]
    [t,vf,af] = av_arr[499]
    avifile.write("%lf %lf\n"%(v0,a0))
    avffile.write("%lf %lf\n"%(vf,af))

'''
with open("input_files/id_asl_2km") as f:id_asl = [[j[0], float(j[1])] for j in [k.split() for k in f.readlines()]]

with open("input_files/ordered_50m/id_map.txt") as f:id_map = [[int(j[0]), j[1]] for j in [k.split() for k in f.readlines()]]
idfile = open("final_ids",'w')
for term in ids:
    for t in id_map:
        if(term == t[0]):
            for tt in id_asl:
                if("RGI60-"+t[1] == tt[0]):
                    idfile.write("%s %f\n"%(t[1], tt[1]))

with open("input_files/id_asl_2km") as f:id_asl = [[j[0], float(j[1])] for j in [k.split() for k in f.readlines()]]

    '''


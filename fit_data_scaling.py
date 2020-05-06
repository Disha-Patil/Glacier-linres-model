
with open("props_scaling.txt") as f:prop_arr = [[str(j[0]), float(j[1]),float(j[2]),float(j[3]),float(j[4]),float(j[5]),float(j[6]),float(j[7]),float(j[8]),float(j[9]),float(j[10]),float(j[11])] for j in [k.split() for k in f.readlines()]]
# prop arr = 0id 1tauv 3dv 5taua 7da


tau_data_file = open("files/output_files/fit_data_scaling.txt",'w')
for term in prop_arr:
    [glid,vol,area,slope,tv,tv_err,dv,dv_err,ta,ta_err,da,da_err] = term
    print(glid)
    #if(glid == n):break
    glid=glid[1:-1]
    with open("files/scaling/scaling_%s.txt"%(glid)) as f:[t,v0,a0] = [[float(j[0]), float(j[1]),float(j[2])] for j in [k.split() for k in f.readlines()]][0]
    with open("files/scaling/scaling_%s.txt"%(glid)) as f:[t,vf,af] = [[float(j[0]), float(j[1]),float(j[2])] for j in [k.split() for k in f.readlines()]][499]

    with open("files/hypso_arr/hypso%s"%(glid)) as g: hypso_arr = [[float(j[0]), float(j[1])*10000,float(j[2]), float(j[3]),float(j[4])] for j in [k.split() for k in g.readlines()]]
    v0*=1000000000
    a0*=1000000
    af*=1000000
    vf *= 1000000000
    dv *= 1000000000
    dv_err *= 1000000000
    da*=1000000
    da_err*=1000000
    h_avg = float(v0)/a0
    dt,tmax,dz,de = 1,501,25,100
    bmax,gamma = 1,1.2857

    zmin = 10000000
    for term in hypso_arr:
        [z,band_a,ela,beta,C] = term
        if(z<zmin): zmin = z        
    
    bt = beta*(zmin-ela)


    dvv = float(dv)/v0
    dvv_err = dv_err/v0
    daa = da/a0
    daa_err =  da_err/a0
    tstar = -1/((bt/(1.2857*h_avg)) + beta)
    tstar_err = 0
    alpha = beta*50*tstar/(1.2857*h_avg)
    alpha_err = 0

    #if(n==4):print(bt,h_avg,beta)
    

    tau_data_file.write("%s %lf %.8f %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf\n"%(glid,dvv,dvv_err,daa,daa_err,alpha,alpha_err,tv,tv_err,ta,ta_err,tstar,tstar_err))

tau_data_file.close()

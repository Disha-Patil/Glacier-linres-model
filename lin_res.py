from math import exp

import os
from os import system as trm


tmax = 501
total_v = [0 for i in range(tmax)]
total_a = [0 for i in range(tmax)]

#with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]
with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]

with open("files/output_files/fit_parameters.txt") as f:parm_arr = [[float(j[0]), float(j[1])] for j in [k.split() for k in f.readlines()]]
[c1,c1_err] = parm_arr[0]
[c2,c2_err] = parm_arr[1]
[c3,c3_err] = parm_arr[2]
[c4,c4_err] = parm_arr[3]
[c5,c5_err] = parm_arr[4]


'''
    dvv = c1*a + c2
    daa = dvv/c3
    ta = c4/t*
    tauv = c5*taua
'''
tau_file = open("files/output_files/linres_tau.txt",'w')
for glid in prop_arr:
    print(glid[0])
    glid=glid[0][1:-1]

    #scaling_file = open("output_files/lin_res/linres_%s.txt"%(glid),'w')
    scaling_file = open("files/lin_res/linres_%s.txt"%(glid),'w')
    #with open("sia_outputs/va_%s"%(glid)) as f:[t,v0,a0] = [[float(j[0]), float(j[1]),float(j[2])] for j in [k.split() for k in f.readlines()]][0]
    with open("files/sia_500/va_%s.txt"%(glid)) as f:[t,v0,a0] = [[float(j[0]), float(j[1]),float(j[2])] for j in [k.split() for k in f.readlines()]][0]

    #with open("ordered_200/%d.txt"%(n)) as f:[v0,a0] = float(f.readline().split(" ")[0])/100000, float(f.readline().split(" ")[1])/1000000
    with open("files/hypso_arr/hypso%s"%(glid)) as g: hypso_arr = [[float(j[0]), float(j[1])*10000,float(j[2]), float(j[3]),float(j[4])] for j in [k.split() for k in g.readlines()]]
    v0*=1000000000
    a0*=1000000
    h_avg = float(v0)/a0
    dt,dz,de = 1,25,50
    bmax,gamma = 1,1.2857

    

    zmin = 10000000
    for term in hypso_arr:
        [z,band_a,ela,beta,C] = term
        if(z<zmin): zmin = z        
    
    bt = beta*(zmin-ela)

    # all linear fits
    tstar = -1/(beta + bt/(gamma*h_avg))
    tau_a = -c4/(beta + bt/(gamma*h_avg))
    tau_v = c5*tau_a
    
    dvv = (beta*de*tstar/(gamma*h_avg))*c1
    daa = dvv/c3
    
    tau_file.write("%s %lf %lf\n"%(glid,tau_a,tau_v))
    # log dvvdaa, lin dvv
    '''tau_a = -2.28507840318746/(beta + bt/(gamma*h_avg))
    tau_v = 0.682100196723482*tau_a

    dvv = (0.748218209600324)*(beta*de*tau_a/(gamma*h_avg)) -0.03833020486706
    daa = dvv/1.84256890688809'''

    # log dvv daa, log dvv a*
    '''tau_a = -2.28507840318746/(beta + bt/(gamma*h_avg))
    tau_v = 0.682100196723482*tau_a

    dvv = (0.81008874890482)*(beta*de*tau_a/(gamma*h_avg))**1.27034747169372
    daa = dvv/1.84256890688809'''

    '''daa = 0.433566*(beta*de*tau_a/(gamma*h_avg))-0.018773
    dvv = daa*1.651608'''


    print(bt)
    for t in range(tmax):
        at=a0*(1-daa*(1-exp(-t/tau_a)))
        vt=v0*(1-dvv*(1-exp(-t/tau_v)))

        if(vt<=0):vt = 0
        if(at<=0):at = 0

        total_v[t] += vt
        total_a[t] += at
    
        scaling_file.write("%d %f %f\n"%(t,vt/(1000*1000*1000),at/(1000*1000)))
    scaling_file.close()

total_file = open("files/output_files/total_lin",'w')
for t in range(tmax):
    total_file.write("%d %lf %lf\n"%(t,total_v[t]/1000000000,total_a[t]/1000000))
total_file.close
tau_file.close

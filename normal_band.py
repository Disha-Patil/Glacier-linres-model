import numpy as np 
from os import system as trm
from math import exp
with open("files/output_files/fit_parameters.txt") as f:parm_arr = [[float(j[0]), float(j[1])] for j in [k.split() for k in f.readlines()]]
# prop arr = 0id 1tauv 3dv 5taua 7da

c1_norm = np.random.normal(0,1,100)
c2_norm = np.random.normal(0,1,100)
c3_norm = np.random.normal(0,1,100)
c4_norm = np.random.normal(0,1,100)
c5_norm = np.random.normal(0,1,100)

[c1,c1_err] = parm_arr[0]
[c2,c2_err] = parm_arr[1]
[c3,c3_err] = parm_arr[2]
[c4,c4_err] = parm_arr[3]
[c5,c5_err] = parm_arr[4]

def map_normal(norm,centre,err):return err*norm + centre


#with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]
with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]

for nn in range(1,101):
    print(nn)
    tmax = 501
    
    c1i = map_normal(c1_norm[nn-1],c1,c1_err)
    c2i = map_normal(c2_norm[nn-1],c2,c2_err)
    c3i = map_normal(c3_norm[nn-1],c3,c3_err)
    c4i = map_normal(c4_norm[nn-1],c4,c4_err)
    c5i = map_normal(c5_norm[nn-1],c5,c5_err)

    total_v = [0 for i in range(tmax)]
    total_a = [0 for i in range(tmax)]

    #print(c2,c2i)

    '''
        dvv = c1*a + c2
        daa = dvv/c3
        ta = c4/t*
        tauv = c5*taua
    '''
    for glid in prop_arr:
        print(glid[0])
        glid=glid[0][1:-1]

        #scaling_file = open("../lin_res/%dl.txt"%(n),'w')
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

        tstar = -1/(beta + bt/(gamma*h_avg))
        tau_a = -c4i/(beta + bt/(gamma*h_avg))
        tau_v = c5i*tau_a

        dvv = (c1i)*(beta*de*tstar/(gamma*h_avg))
        daa = dvv/c3i
        
        for t in range(tmax):
            at=a0*(1-daa*(1-exp(-t/tau_a)))
            vt=v0*(1-dvv*(1-exp(-t/tau_v)))

            if(vt<=0):vt = 0
            if(at<=0):at = 0

            total_v[t] += vt
            total_a[t] += at
        
            #scaling_file.write("%d %f %f\n"%(t,vt/(1000*1000*1000),at/(1000*1000)))
        #scaling_file.close()

    total_file = open("files/output_files/bands/total%d"%(nn),'w')
    for t in range(tmax):
        total_file.write("%d %lf %lf\n"%(t,total_v[t]/1000000000,total_a[t]/1000000))
    total_file.close

    
import os
from os import system as trm

tmax = 1000
total_v = [0 for i in range(tmax)]
total_a = [0 for i in range(tmax)]


#with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]
with open("props.txt") as f:prop_arr = [[str(j[0])] for j in [k.split() for k in f.readlines()]]


for glid in prop_arr:
    print(glid[0])
    glid=glid[0][1:-1]
    scaling_file = open("files/scaling/scaling_%s.txt"%(glid),'w')
    with open("files/sia_500/va_%s.txt"%(glid)) as f:[t,v0,a0] = [[float(j[0]), float(j[1]),float(j[2])] for j in [k.split() for k in f.readlines()]][0]
    #with open("ordered_200/%d.txt"%(n)) as f:[v0,a0] = float(f.readline().split(" ")[0])/100000, float(f.readline().split(" ")[1])/1000000
    with open("files/hypso_arr/hypso%s"%(glid)) as g: hypso_arr = [[float(j[0]), float(j[1])*10000,float(j[2]), float(j[3]),float(j[4])] for j in [k.split() for k in g.readlines()]]
    v0*=1000000000
    a0*=1000000
    #print(v0,a0)
    dt,tmax,dz,de = 1,500,25,50
    bmax,gamma = 1,1.2857
    v = v0
    a = 0.0



    dv0 = 0
    for term in hypso_arr:
        print(term)
        [z,band_a,ela,beta,C] = term
        a += band_a
        b = beta*(z-ela)
        if(b>1):b=1
        dv0 += b*band_a*dt
    #print(a,a0, n)
    scaling_file.write("%d %f %f\n"%(0,v0/(1000*1000*1000),a0/(1000*1000)))
    total_a[0]+=a0
    total_v[0]+= v0
    print(a0)
    print(a)
    for t in range(1,tmax):
        print(t)
        dv,a = 0,0.0
        for term in hypso_arr:
            [z,band_a,ela,beta,C] = term
            a += band_a
            b = beta*(z-ela-de)
            if(b>1):b=1
            dv += b*band_a*dt
        dv -= dv0
        da = a*dv/(gamma*v)
        v+=dv
        print(a)

        for i in range(len(hypso_arr)):
            print(i)
            if(hypso_arr[i][1]==0):continue 
            hypso_arr[i][1] += da
            if(hypso_arr[i][1]<0):
                print("negative")
                da -= hypso_arr[i][1]
                hypso_arr[i][1] = 0
            else: break
        #print(a/1000000)
        #input()
        '''if(t==1 or t==2 ):
            inputString = input('Enter a string:')
            print('area is:', str(a/1000000))'''
        total_a[t]+= a
        total_v[t]+= v
        if(v<=0 or a<=0):
            print("here")
            break
        scaling_file.write("%d %f %f\n"%(t,v/(1000*1000*1000),a/(1000*1000)))
    scaling_file.close()

total_file = open("files/output_files/total_scaling",'w')
for t in range(0,tmax):
    total_file.write("%d %lf %lf\n"%(t,total_v[t]/1000000000,total_a[t]/1000000))
total_file.close


#path for sia output files
PATH="/home/disha/disha/glacier/review_2/all_maps/results_ab/sia_outputs/"
#get va files list
va_files=list.files(path=PATH,
                    pattern ="^va")

#read va files one by one for all galciers
#in va files columns are :
#col 2 : volumen , col 3 : area
#read only 500 years simulation
simulation_time=500
data=data.frame()
for(i in va_files){
  
  df=read.table(paste(PATH,i,sep=""),header = F,sep=" ")[1:simulation_time,2:3]
  #add glacier name or region
  df[,3]=rep(sub("va_","",i),nrow(df))
  data=rbind(data,df)
  
  #uncomment following for debugging
  #print(df[1,1])
  #invisible(readline(prompt="Press [enter] to continue"))
}
#add the time column
data[,4]<-rep(1:simulation_time,length(va_files))
#name columns
colnames(data)=c("vol","area","region","time")

#uncomment following for debugging
#head(data)
#tail(data)
#View(data)
#class(data$region) #should be character


#calculate final area and volume change
area_change=data.frame(region=unique(data$region),area_change=0,vol_change=0)
#region shuld be character
class(area_change$region)
area_change$region=as.character(area_change$region)
class(area_change$region)
for(i in area_change$region){
  area_change[area_change$region==i,2]=1*(data[which(data$region==i & data$time==1),2]-data[data$region==i & data$time==simulation_time ,2])/data[which(data$region==i & data$time==1),2]
  area_change[area_change$region==i,3]=1*(data[which(data$region==i & data$time==1),1]-data[data$region==i & data$time==simulation_time ,1])/data[which(data$region==i & data$time==1),1]
  
}

#View(area_change)
#read the props file which has tau, ddv etc. give appropriate data classes 
#or else you will miss a glacier or two due to numeric numbering of glacier ids
# some trailing zeros will be deleted
props=read.table("props/props_sia_x1.txt",
                 sep=" ",header=T,
                 colClasses=c("character","numeric","numeric","numeric",
                              "numeric","numeric","numeric","numeric",
                              "numeric","numeric","numeric","numeric",
                              "character","numeric","numeric","numeric",
                              "numeric",
                              "character","numeric"))

#check column names
colnames(props)
#these are some col names
#id13 tau e15 beta c17 id bt19

#check glacier id class it should be character
class(props$rgiid)

#if not character run these
#props$rgiid=as.character(props$rgiid)
#class(props$rgiid)
#check
#head(props)
#View(props)
#make sure the row number matches total glaciers
dim(props)

#apply filter. tau greater than 500 and area change greater than 0.5
filter=c(props[which(props$tauv>500),1],
         area_change[which(area_change$vol_change>0.5),1],
         props[which(props$tauA>500),1])

#to check number of glaciers dropped due to individual filters
#length(props[which(props$tauv>500),1])
#length(area_change[which(area_change$area_change>0.5),1])
#length(area_change[which(area_change$vol_change>0.5),1]) # not used
#length(props[which(props$tauA>500),1])

#total glaciers dropped. check unique as it may have repeated values
length(unique(filter))

#fraction of area dropped due to tau cut off
#sum(props[which(props$tauA>500),3])/sum(props[,3])

# some glaciers are marked not good due to conservation error
props[(which(props$flag<0)),1]

#check if any of above already in filter. filter has repeated values
#filter[filter %in% props[(which(props$flag<0)),1]]
#length(which(props$flag<0))

#set glaciers listed in filter to -1 i.e. to be dropped
props[which(props$rgiid %in% filter ),4]=-1

#delete the dropped glaciers from dataframe
props_filtered=props[-which(props$flag<0),]
dim(props_filtered)
#check the class of glacier id
class(props_filtered$rgiid)
#write the filtered smaller dataset to props
write.table(props_filtered,"props.txt",sep="\t",row.names = FALSE,col.names = F)
#write the original data set with updated flag column to different file
write.table(props,"props/props_all_sia_x.txt",sep="\t",row.names = FALSE,col.names = F)

#-------------------------------------------------------------------------------------------------

##make hypso files as req

#hypso_extra=read.table("/home/disha/disha/glacier/review_2/all_maps/results_ab/id_tau_e_beta_c.txt",sep=" ",header=F,
#                       colClasses=c("character","numeric","numeric","numeric","numeric")	)

# we have read the props file already and it has information needed for hypsometry
# a different dataframe
hypso_extra=props[,c("id13" ,"tau"  ,"e15"  ,"beta" ,"c17")]
colnames(hypso_extra)=c("rgiid","tau","ela","beta","C")
class(hypso_extra$rgiid)
hypso_extra$rgiid=as.character(hypso_extra$rgiid)
class(hypso_extra$rgiid)

#read hypsometry file
for(i in hypso_extra$rgiid){
  #specify the hypso files path
  hypso=read.table(paste("/home/disha/disha/glacier/review_2/all_maps/results_ab/sia_outputs/hypso",i,sep=""),
                   sep="\t",header=F)
  print(hypso)
  hypso$ela=hypso_extra[hypso_extra$rgiid==i,3]
  hypso$beta=hypso_extra[hypso_extra$rgiid==i,4]
  hypso$C=hypso_extra[hypso_extra$rgiid==i,5]
  
  write.table(hypso,paste("files/hypso_arr/hypso",i,sep=""),row.names = F,col.names = F)
}

#View(hypso)
#colnames(hypso)=c("z","band_a")
#hypso$ela=hypso_extra[hypso_extra$rgiid=="14.11566",3]

#head(hypso)
#head(hypso_extra)

#scaling props

props_sca=read.table("props/props_sca.txt",
                     sep="\t",header=T,
                     colClasses=c("character","numeric","numeric","numeric",
                                  "numeric","numeric","numeric","numeric",
                                  "numeric","numeric","numeric","numeric"))
class(props_sca$rgiid)
props_sca$rgiid=as.character(props_sca$rgiid)
class(props_sca$rgiid)
head(props_sca)
#we have already filtered glaciers just update the flag column
props_sca[which(props_sca$rgiid %in% filter ),4]=-1
props_sca_filtered=props_sca[-which(props_sca$flag<0),]
dim(props_sca_filtered)
#View(props_sca)
#write scaling props
write.table(props_sca_filtered,"props_scaling.txt",sep="\t",row.names = FALSE,col.names = F)

#--------------------------------------------------------------------------------------------------------------

# make a list of files having only the selected glaciers va files. scaling and sia
t=1
scaling_files=va_files=c()
scaling_files[1]="nodelete_scaling.txt"
va_files[1]="nodelete_sia.txt"
for(id in props_filtered$rgiid){
  t=t+1
  scaling_files[t]=paste("scaling_",id,".txt",sep="")
  va_files[t]=paste("va_",id,sep="")
}

#write.table(scaling_files,"files/scaling/nodelete_scaling.txt",
 #           col.names = F,row.names = F)
write.table(va_files,"files/sia_500/nodelete_sia.txt",
            col.names = F,row.names = F, quote=FALSE)
#---------------------------------------------
dim(va_files)

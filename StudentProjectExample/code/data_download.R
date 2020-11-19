#######################################################################################################################################
# Downloads the 1948-2018 monthly Sea Temperature and Sea Salinity Profiles from the United Kingdom Met Office                  
# EN 4.2.1 Quality Controlled Dataset (Good et al 2013), extracts SST at 5m depth, cacontonates a 3D                            
# array (as a monthy time series) of gridded values, and derives soil moisture                       
# based predictive indices for summertime  precipitation anomalies in the Midwestern United States.                                                                   #

#R Script generated using Microsoft R Open 3.5.1 and run on April 3rd, 2019

require(lubridate)
require(ncdf4)
require(raster)
require(stringr)

#Creates netcdf file of monthly values of 5m salinity and temperature, extracted from the UKMO EN4.2.1 objective analyses----

local_dir = "~/CEE6000M0002_Fall2020/StudentProjectExample" #set to local data directory

setwd(local_dir) 
if(dir.exists("raw_data")){
	  setwd("./raw_data")
}else{
	  dir.create("raw_data")
  setwd("./raw_data")
}

yr<-rep(1948:2018, each=12)  #generate vector of years
mth<-rep(1:12, length(1948:2018))   #generate vector of months
sst_array<-array(NA, dim=c(360 ,173, length(mth))) #initiaate blank array for monthly surface SST values
sss_array<-array(NA, dim=c(360, 173, length(mth))) #initiate blank array for monthyl surface SSS values
for(y in 1948:2018){  #loop over years
	  filepath<-paste("EN.4.2.1.analyses.g10.", y,sep="")  #generate download link for year/file
  ncpath<-paste("EN.4.2.1.f.analysis.g10.", y, sep="")  #initiatve filepath
    download.file(paste("http://www.metoffice.gov.uk/hadobs/en4/data/en4-2-1/", filepath,".zip", sep=""), 
		                  destfile=paste(local_dir, "raw_data/", filepath, ".zip", sep=""),
				                  quiet=T)  #download file
    
    zf<-paste(filepath,".zip", sep="") # generate name of zip as downloaded on computer
      unzip(zf) #unzip zip file into 12 monthly .nc files
      
      unlink(paste(filepath, ".zip", sep="")) # delete zip file
        for(m in 1:12){  # loop over months
		    ss.nc<-nc_open(paste(ncpath, str_pad(m,2,pad="0"), ".nc",sep="")) #open .nc connection
          temp<-ncvar_get(ss.nc, varid="temperature") #extract SST data
	      salinity<-ncvar_get(ss.nc, varid="salinity" )  #extract SSS data
	      sst_array[,,which(yr %in% y & mth %in% m)]<-temp[,,1]   #insert surface SST data into monthly slot in array
	          sss_array[,,which(yr %in% y & mth %in% m)]<-salinity[,,1]  #insert surface SSS data into monthly slot in array
	          remove(temp); remove(salinity) #remote data from active directory
		      nc_close(ss.nc) # close .nc connection
		      unlink(paste(ncpath, str_pad(m,2,pad="0"), ".nc",sep="")) #delete .nc file
		        }
}

#write netCDF files of monthly 5m sea temperature/sea salinity
#define dimension variables
latitude<-(-83:89)
longitude<-1:360
time<-seq.Date(as.Date("1948/01/01"),as.Date("2018/12/01"), by="month")

latdim<-ncdim_def("latdim", "degrees_north",as.double(latitude))
londim<-ncdim_def("londim", "degrees_east", as.double(longitude))
timedim<-ncdim_def("timedim", "days since 1970-01-01 00:00:00", as.double(time))

#define values
fillvalue<-1e32
dlname<-"monthly 5m sea salinity from UKMO4.2.1 analyses"
sss_def<-ncvar_def("sss", "psu", list(londim, latdim, timedim), fillvalue, dlname, prec="single")

dlname<-"monthly 5m sea temperature from UKMO4.2.1 analyses"
sst_def<-ncvar_def("sst", "kelvin", list(londim, latdim, timedim), fillvalue, dlname, prec="single")

#initialized nc file
ncfname <- paste(local_dir, "raw_data/UKMO4_2_1_analyses_SSS_SST.nc", sep="")
ncout <- nc_create(ncfname,list(sss_def, sst_def),force_v4=T)
#insert data
ncvar_put(ncout,sss_def,sss_array)
ncvar_put(ncout,sst_def,sst_array)

#write nc file
setwd(paste(local_dir, "raw_data", sep=""))
nc_sync(ncout) 
nc_close(ncout) 

#save arrasy as R data
save(sst_array, file=paste(local_dir, "raw_data/UKMO421_monthly_SST.RData", sep="")) 
save(sss_array, file=paste(local_dir, "raw_data/UKMO421_monthly_SSS.RData", sep="")) 


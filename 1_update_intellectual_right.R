# this code is used to update intellectual rights as well as contact, access, distribution...

# install EDIutils package
#remotes::install_github("ropensci/EDIutils")

rm(list=ls())
library(EDIutils)
library(xml2)
library(dplyr)
library(stringr)
library(RCurl)
#######
# user input

# not include revision because the code detect the revision
identifier_all = c(3002,3004,3005) 

#the date you like to publish this data package
pubDate = "2022-05-10" 

# boilerplate that stores all the content that you want to change for all the EMLs
boilerplate_path <- "boilerplate_intellectualright_update.xml" 

#scope in data package
scope = "knb-lter-sbc"

# end user input

##########
for (j in 1:length(identifier_all))
  {
identifier = identifier_all[j]
# locate the latest EML from each data package
revision <- list_data_package_revisions(scope,
                                        identifier,
                                        filter = "newest",
                                        env = "production")
pkgid=paste0(scope,".",identifier,".",revision)

#create the next revision
new_pkgid=paste0(scope,".",identifier,".",revision+1)

#read in EML
pkg <- read_metadata(pkgid)
meta_ori <- EML::read_eml(pkg)
meta <- meta_ori

# read in all the boilerplate information
boilerplate <- EML::read_eml(boilerplate_path)

#replace content in the old eml
meta[["@context"]] <- boilerplate[["@context"]]
meta[["schemaLocation"]] <- boilerplate[["schemaLocation"]]
meta[["system"]] <- boilerplate[["system"]]

meta$access<-boilerplate$access
meta$dataset$contact<-boilerplate$dataset$contact 
meta$dataset$distribution<- boilerplate$dataset$distribution
meta$dataset$intellectualRights<- boilerplate$dataset$intellectualRights
meta$dataset$publisher<- boilerplate$dataset$publisher
meta$dataset$project<- boilerplate$dataset$project
meta$packageId<-new_pkgid
meta$dataset$pubDate <- pubDate

#########
#write out the new EML in the new_eml folder
EML::write_eml(meta,paste0("new_eml/eml_",identifier,"_",pubDate,".xml"))
}

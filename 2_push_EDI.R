# this code is used to push the EML into the Environmental Data Initiative repository
#remotes::install_github("ropensci/EDIutils")
rm(list=ls())
library(EDIutils)
library(xml2)
library(dplyr)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#######

# user input
identifier_all = c(3004,3005)

pubDate = "2022-05-10"

#put in the user name and password from the EDI
login(userId = "XXX", userPass = "xxxx" )

action = "evaluate" # or publish

envir = "staging" # or production

###############################

for (i in 1:length(identifier_all)){

if (action=="evaluate") {
# package evaluation

transaction <- evaluate_data_package(
  eml = paste0("new_eml/eml_",identifier_all[i],"_",pubDate,".xml"), 
  env = envir)

status <- check_status_evaluate(transaction, env = envir)

report <- read_evaluate_report(transaction, as = "char", env = envir)

message(report)
} else {
if (action=="publish")   {
# package upload
transaction <- create_data_package(
  eml = paste0("new_eml/eml_",identifier_all[i],"_",pubDate,".xml"), 
  env = envir)

status <- check_status_create(
  transaction = transaction, 
  env = envir)

status
} else {print("Action is not recognized")}
}

}

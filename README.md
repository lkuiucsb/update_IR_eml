# update_IR_eml
This repository is for the R scripts that update the intellectual rights in the EML documents for the datasets that are published in the Environmental Data Initiative (EDI) repository: https://edirepository.org/. The EML generated from the scripts use the data tables stored in the EDI, so no need to upload the data table again. 

The first script "1_update_intellectual_right.R" reads in the EML for the latest version of data packages and replaces the content using the "boilerplate_intellectualright_update.xml". The current script replaces the following content/nodes in the EML: schemaLocation, system, context, access, contact, distribution, intellectualRights, publisher, project, pubDate. Depending on your needs, you could comment out the EML nodes that you don't need to replace. 

Edit the boilerplate content to include the nodes you want to replace before executing the "update_intellectual_right.R". Current boilerplate has all the SBCLTER content in it. 

The second script "2_push_EDI.R" is optional to the users. This script pushes the new EMLs to the EDI repository in a R environment. You want to enter the login information and choose the environment (staging or production) before executing the script. Many people like to handle this part of the work mannually in the EDI environment.  
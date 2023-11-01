# To run
# put all the individual count files in a folder (ex, count_indi) and provide the folder path as input
# the output would be a merge matrix table called miRNA_piRNA_trimmed_expression_value.csv in the count_indi folder
# Usage: Rscript miRNA_count_matrix_merging.R /path/ti/folder/count_indi


library(tidyverse)
library(readxl) 

if (length(args)==0) {
  stop("Please provide a folder path", call.=FALSE)
}

# list the files in the count folder
args = commandArgs(trailingOnly=TRUE)
files<-list.files(args[1])

all<-"" #set all to empty

for (i in 1:length(files)){
  
  file_name<-strsplit(files[i], split = "_S")[[1]][1]  #extract column name from file name
  
  #read in individual count table
  count<-(read_excel(paste0(args[1],"/",files[i]))
          %>%select(-CPM)
          %>%dplyr::rename_with(~file_name,Count) 
  )
  
  if (i==1){   # join the tables
    all<-count
  }else{
    all<-full_join(all, count, by="Name")
  }
}

final<-(all
        %>%mutate_if(is.character, ~replace(., is.na(.), 0))
        %>%write_csv(paste0(args[1],"/miRNA_piRNA_trimmed_expression_value.csv"))
)
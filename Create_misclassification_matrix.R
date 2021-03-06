
#---------------------
# Load packages
#---------------------

library(survey)
library(reshape2)
library(ggplot2)
library(ggthemes)
library(xtable)


#---------------------------
# Begin functions
#---------------------------

### function to create misclassification table with row and col pcts

misclmat <- function(ehrrace, survrace){
  colp <- format(round(prop.table(table(ehrrace, survrace),2) * 100, 1), nsmall = 1)
  rowp <- format(round(prop.table(table(ehrrace, survrace),1) * 100, 1), nsmall = 1)
  miscllist <- list()
  for(i in 1:ncol(colp)){
    miscllist[[i]] <- paste0("[", rowp[,i], "] (", colp[,i], ")")
  }
  misclmat <- do.call("rbind", miscllist)
  colnames(misclmat) <- rownames(misclmat) <- c("White", "Black", "Asian", "Other", "Hispanic")
  miscltable <- xtable(misclmat)
  print.xtable(miscltable, include.rownames = TRUE)
}

### function to create misclassification table with n and row or col pct

misclmat_npct <- function(ehrrace, survrace, colp){
  n <- table(ehrrace, survrace)
  if(colp==1){
    pct <- format(round(prop.table(table(ehrrace, survrace),2) * 100, 1), nsmall = 1)
  }else{
    pct <- format(round(prop.table(table(ehrrace, survrace),1) * 100, 1), nsmall = 1)
  }
  miscllist <- list()
  for(i in 1:ncol(pct)){
    miscllist[[i]] <- paste0(n[,i], " (", pct[,i], ")")
  }
  misclmat <- do.call("rbind", miscllist)
  colnames(misclmat) <- rownames(misclmat) <- c("White", "Black", "Asian", "Other", "Hispanic")
  miscltable <- xtable(misclmat)
  print.xtable(miscltable, include.rownames = TRUE)
}

#----------------------------------
# End of functions
#----------------------------------



#------------------------------
# Load analytical data set
#------------------------------

setwd("") ### ENTER PATH HERE
load("analdata.Rdata")


#------------------------------------------
# Overall misclassification matrix
#------------------------------------------

misclmat_npct(findata$e.race.eth.5, findata$s.race.eth.5, colp = 0)


#-------------------------------------------
# Misclassification matrix by trust
#-------------------------------------------

### Trust = 0
trust0 <- subset(findata, findata$s.trust == 0)
misclmat_npct(trust0$e.race.eth.5, trust0$s.race.eth.5, colp = 0)

### Trust = 1
trust1 <- subset(findata, findata$s.trust == 1)
misclmat_npct(trust1$e.race.eth.5, trust1$s.race.eth.5, colp = 0)


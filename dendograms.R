#!/usr/bin/env Rscript

library(getopt)

spec = matrix(c(
  'data','d', 1, "character",
  'help'         ,'h', 0, "logical"
), byrow=TRUE, ncol=4)
opt = getopt(spec)

if ( !is.null(opt$help) ) {
  cat(getopt(spec, usage=TRUE))
  q(status=1)
}
if ( is.null(opt$gfa) ) {
  print("-data missing")
  q(status=1)
}

# t <- read.table(opt$data)
t <- read.table("~/rds/rds-durbin-group-8b3VcZwY7rY/projects/cichlid/pio/projects/20220201_kmers_analysis/13species")
colnames(t) <- c("sample1", "sample2", "total", "common")

#### JUST FOR 13 SPECIES
t[t$sample1=="GRCh38_full_analysis_set_plus_decoy_hla",]$sample1 <- "Human"
t[t$sample2=="GRCh38_full_analysis_set_plus_decoy_hla",]$sample2 <- "Human"
t[t$sample1=="GCA_905319855.2",]$sample1 <- "Canis lupus"
t[t$sample2=="GCA_905319855.2",]$sample2 <- "Canis lupus"
t[t$sample1=="GCA_015227675.2",]$sample1 <- "Rattus norvegicus"
t[t$sample2=="GCA_015227675.2",]$sample2 <- "Rattus norvegicus"
t[t$sample1=="GCA_902459465.3",]$sample1 <- "Asterias rubens"
t[t$sample2=="GCA_902459465.3",]$sample2 <- "Asterias rubens"
t[t$sample1=="GCA_907165065.1",]$sample1 <- "Caprimulgus europaeus"
t[t$sample2=="GCA_907165065.1",]$sample2 <- "Caprimulgus europaeus"
t[t$sample1=="GCA_905475345.1",]$sample1 <- "Vespula Vulgaris"
t[t$sample2=="GCA_905475345.1",]$sample2 <- "Vespula Vulgaris"
t[t$sample1=="GCA_922984935.1",]$sample1 <- "Meles meles"
t[t$sample2=="GCA_922984935.1",]$sample2 <- "Meles meles"
t[t$sample1=="GCA_907165235.1",]$sample1 <- "Zeuzera pyrina"
t[t$sample2=="GCA_907165235.1",]$sample2 <- "Zeuzera pyrina"
t[t$sample1=="GCA_905310635.1",]$sample1 <- "Eimeria tenella"
t[t$sample2=="GCA_905310635.1",]$sample2 <- "Eimeria tenella"
t[t$sample1=="ponAbe3",]$sample1 <- "Pongo abelii"
t[t$sample2=="ponAbe3",]$sample2 <- "Pongo abelii"
t[t$sample1=="gorGor6",]$sample1 <- "Gorilla gorilla"
t[t$sample2=="gorGor6",]$sample2 <- "Gorilla gorilla"
t[t$sample1=="nomLeu3",]$sample1 <- "Nomascus leucogenys"
t[t$sample2=="nomLeu3",]$sample2 <- "Nomascus leucogenys"
t[t$sample1=="panTro6",]$sample1 <- "Pan troglodytes"
t[t$sample2=="panTro6",]$sample2 <- "Pan troglodytes"




# create distance
t$d <- 1-t$common/t$total
t <- t[-c(3,4)]
# order the rows to have them shorted for the reshape later
t <- t[order(t$sample1),]

# reshape to long form. Move column with names to rownames and remove it
tr <- reshape(t, timevar= "sample2", idvar="sample1", direction = "wide")
rownames(tr) <- tr[,1]
tr[,1] <- NA
tr <- tr[order(-rowSums(is.na(tr))),]
tr <- tr[order(colSums(is.na(tr)))]
tr <- rbind(rep(NA, ncol(tr)),tr)
colnames(tr) <- sub("d.", "", colnames(tr))
rownames(tr)[1] <- colnames(tr)[1]
colnames(tr)[ncol(tr)] <- rownames(tr)[nrow(tr)]
tr[is.na(tr)] <- 0
plot(hclust(as.dist(tr)))
library(ape)
plot(nj(as.dist(tr)))

### TODO
# modify to read the exit of pairwise and do a dendogram with it


# 
# 
# m <- matrix(c(100,12.7,13.89,4.04,11.07,1.76,3.19,0.59,
#               100,100,12.48,4.06,11,1.78,3.19,0.57,
#               100,100,100,3.95,10.78,1.75,3.13,0.59,
#               100,100,100,100,4.54,2.56,3.48,0.66,
#               100,100,100,100,100,2.11,3.59,0.71,
#               100,100,100,100,100,100,3.19,0.6,
#               100,100,100,100,100,100,100,0.58,
#               100,100,100,100,100,100,100,100)
#               , nrow=8, ncol=8)
# colnames(m) <- c("Wolf", "Rat", "Badger", "Starfish", "Nightjar", "Wasp", "Leopard moth","Eimeria")
# n <- 100-m
# plot(hclust(as.dist(n)))
# # 
# # m <- matrix(c(100,3.95,10.78,1.75,3.13,0.59,
#               100,100,4.54,2.56,3.48,0.66,
#               100,100,100,2.11,3.59,0.71,
#               100,100,100,100,3.19,0.6,
#               100,100,100,100,100,0.58,
#               100,100,100,100,100,100)
#             , nrow=6, ncol=6)
# colnames(m) <- c("AfunF3", "Fun402", "Fun414", "ColuKW18", "Gamb150", "Gamb470")
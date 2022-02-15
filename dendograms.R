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

t <- read.table(opt$data)
t <- t[order(t[,1])]
colnames(t) <- c("sample1", "sample2", "total", "common")
tt <- t[-c(4)]
tc <- t[-c(3)]
tr <- reshape(tc, timevar= "sample2", idvar="sample1", direction = "wide")
rownames(tr) <- tr[,1]
tr <- tr[-c(1)]
colnames(tr) <- sub("*common.", "", colnames(tr))
tr <- tr[,c(rownames(tr))[c(-1)]]
tr <- cbind(rep(NA, nrow(tr)), tr)
colnames(tr)[1] <- rownames(tr)[1]


### TODO
# modify to read the exit of pairwise and do a dendogram with it

read

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
# 
# m <- matrix(c(100,3.95,10.78,1.75,3.13,0.59,
#               100,100,4.54,2.56,3.48,0.66,
#               100,100,100,2.11,3.59,0.71,
#               100,100,100,100,3.19,0.6,
#               100,100,100,100,100,0.58,
#               100,100,100,100,100,100)
#             , nrow=6, ncol=6)
# colnames(m) <- c("AfunF3", "Fun402", "Fun414", "ColuKW18", "Gamb150", "Gamb470")
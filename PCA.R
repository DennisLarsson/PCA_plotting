require(adegenet)
#convert file to gtx, while doing so make sure that all specimen from same group are together. If you used PGDspider, make sure that a populations definition file is used and make sure the popmap is organized as follows:
#pop1_1 pop1
#pop1_2 pop1
#pop2_1 pop2
#pop2_1 pop2
#pop3_1 pop3
#pop3_2 pop3
#pop4_1 pop4
#pop4_2 pop4
#where pop1 and pop2 belong to the same group and same for pop3 and pop4. If, for example, pop1 and pop3 are in the same group, then pop3 should follow pop1, then pop2 and pop4. Some is the case for how the popdata file should be arrange. She more details about the popdata file in the readme.

object1 <- read.genetix("/path/to/myOrganism.gtx")
#optional important method for structure formated file, but more options have to be entered for use with caution and patients.
#object1 <- read.structure("/path/to/myOrganism.stru", n.ind = 82, n.loc = 2000, onerowperind = FALSE, col.lab = 1, col.pop = 2, row.marknames = 1, NA.char = "-9", ask = FALSE)

popnames <- read.csv("/home/biogeoanalysis/RAD/spicatumPhylogeography/06populations_9snps_50miss_inPop/PCA_popdata_reduced.csv")

X <- tab(object1, freq = TRUE, NA.method = "mean")

pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3) #function to calculate PCs
#pca1$eig
#pca1$li
powerVal1 = round((pca1$eig[1]/sum(pca1$eig))*100,digits = 2) #calclates proportion of three first PCs compared to all PCs.
powerVal2 = round((pca1$eig[2]/sum(pca1$eig))*100,digits = 2)
powerVal3 = round((pca1$eig[3]/sum(pca1$eig))*100,digits = 2)


#------------------------------------------------------------------------------------------------------------------
###Barplot of eigenvalues
barplot(pca1$eig[1:10], xlab="component", ylab="eigen value")
#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC2 labels
indvnames <- as.vector(labels(pca1$li)[[1]])

plot.default(x=pca1$li[,1], y=pca1$li[,2], xlab="PC1", ylab="PC2",xlim=c(min(pca1$li,1),max(pca1$li,1)), ylim=c(min(pca1$li,2),max(pca1$li,2)))
text(pca1$li[,1], pca1$li[,2], labels=indvnames, cex= 0.7, pos = 4, main = "PCA plot of PC1 vs PC2 text labels")

plot.default(x=pca1$li[,1], y=pca1$li[,3], xlab="PC1", ylab="PC3",xlim=c(min(pca1$li,1),max(pca1$li,1)), ylim=c(min(pca1$li,3),max(pca1$li,3)))
text(pca1$li[,1], pca1$li[,3], labels=indvnames, cex= 0.7, pos = 4, main = "PCA plot of PC1 vs PC3 text labels")

#plot.default(x=pca1$li[,2], y=pca1$li[,3], xlab="PC2", ylab="PC3",xlim=c(min(pca1$li,2),max(pca1$li,2)), ylim=c(min(pca1$li,3),max(pca1$li,3)))
#text(pca1$li[,2], pca1$li[,3], labels=indvnames, cex= 0.7, pos = 4, main = "PCA plot of PC2 vs PC3 text labels")


#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC2 region
plot(pca1$li[1,1],pca1$li[1,2], col=as.character(popnames$regioncolor[1]), pch=popnames$regionshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC2 -", powerVal2,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,2]),max(pca1$li[,2])), main = "PCA plot of PC1 vs PC2 per region")

abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=2

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,2], col=as.character(popnames$regioncolor[i]), pch=popnames$regionshape[i])
  i = i+1
}

legend(x="topright", legend=unique(popnames$region), col = unique(as.character(popnames$regioncolor)), pch = unique(popnames$regionshape), cex=1)


#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC3 region
plot(pca1$li[1,1],pca1$li[1,3], col=as.character(popnames$regioncolor[1]), pch=popnames$regionshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC3 -", powerVal3,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,3]),max(pca1$li[,3])), main = "PCA plot of PC1 vs PC3 per region")

abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=2

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,3], col=as.character(popnames$regioncolor[i]), pch=popnames$regionshape[i])
  i = i+1
}

legend(x="bottomleft", legend=unique(popnames$region), col = unique(as.character(popnames$regioncolor)), pch = unique(popnames$regionshape), cex=1)


#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC2 pop
plot(pca1$li[1,1],pca1$li[1,2], col=popnames$popcolor[1], pch=popnames$popshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC2 -", powerVal2,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,2]),max(pca1$li[,2])), main = "PCA plot of PC1 vs PC2 per pop")
abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=2

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,2], col=popnames$popcolor[i], pch=popnames$popshape[i])
  i = i+1
}

legend(x="bottomleft", legend=unique(popnames$pop), col = unique(as.character(popnames$popcolor)), pch = unique(popnames$popshape), cex=0.55, ncol=3)


#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC3 pop
plot(pca1$li[1,1],pca1$li[1,3], col=popnames$popcolor[1], pch=popnames$popshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC3 -", powerVal3,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,3]),max(pca1$li[,3])), main = "PCA plot of PC1 vs PC3 per pop")
abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=2

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,3], col=popnames$popcolor[i], pch=popnames$popshape[i])
  i = i+1
}

legend(x="bottomright", legend=unique(popnames$pop), col = unique(as.character(popnames$popcolor)), pch = unique(popnames$popshape), cex=0.52, ncol=3)



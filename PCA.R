library(adegenet)
#if you dont have adegenet installed, install using: install.packages("adegenet")

setwd("/path/to/workDirectory/")
infile<-"spicatum.stru"
outputfile.name <-"spicatum"

popnames <- read.csv("/path/to/spicatum.csv")

#make sure to edit n.ind to the number of individuals your dataset has and n.loc to the number of loci you have.
object1 <- read.structure(infile, n.ind = 89, n.loc = 29494, onerowperind = FALSE, col.lab = 1, col.pop = 2, row.marknames = 1, 
                          NA.char = "-9", ask = FALSE)

X <- tab(object1, freq = TRUE, NA.method = "mean")

pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 5)


powerVal1 = round((pca1$eig[1]/sum(pca1$eig))*100,digits = 2)
powerVal2 = round((pca1$eig[2]/sum(pca1$eig))*100,digits = 2)
powerVal3 = round((pca1$eig[3]/sum(pca1$eig))*100,digits = 2)

pdf(file=paste("PCA_",outputfile.name,".pdf",sep=""), height = 8, width = 8, title = infile)
#------------------------------------------------------------------------------------------------------------------
###Barplot of eigenvalues
barplot(pca1$eig[1:10], xlab="component", ylab="eigen value")
#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC2 labels
indvnames <- as.vector(labels(pca1$li)[[1]])

plot.default(x=pca1$li[,1], y=pca1$li[,2], xlab="PC1", ylab="PC2",xlim=c(min(pca1$li,1),max(pca1$li,1)), ylim=c(min(pca1$li,2),max(pca1$li,2)), main = "PCA plot of PC1 vs PC2 text labels")
text(pca1$li[,1], pca1$li[,2], labels=indvnames, cex= 0.45, pos = 4)

plot.default(x=pca1$li[,1], y=pca1$li[,3], xlab="PC1", ylab="PC3",xlim=c(min(pca1$li,1),max(pca1$li,1)), ylim=c(min(pca1$li,3),max(pca1$li,3)), main = "PCA plot of PC1 vs PC3 text labels")
text(pca1$li[,1], pca1$li[,3], labels=indvnames, cex= 0.45, pos = 4)


#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC2 pop
plot(pca1$li[1,1],pca1$li[1,2], col=as.character(popnames$popcolor[1]), pch=popnames$popshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC2 -", powerVal2,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,2]),max(pca1$li[,2])), main = "PCA plot of PC1 vs PC2 per pop")

abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=1

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,2], col=as.character(popnames$popcolor[i]), pch=popnames$popshape[i])
  #text(pca1$li[i,1], pca1$li[i,2], labels=popnames$ind, cex= 0.45, pos = 4)
  i = i+1
}

legend(x="topright", legend=unique(popnames$pop), col = unique(as.character(popnames$popcolor)), pch = unique(popnames$popshape), cex=1)


#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC3 pop
plot(pca1$li[1,1],pca1$li[1,3], col=as.character(popnames$popcolor[1]), pch=popnames$popshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC3 -", powerVal3,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,3]),max(pca1$li[,3])), main = "PCA plot of PC1 vs PC3 per pop")

abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=1

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,3], col=as.character(popnames$popcolor[i]), pch=popnames$popshape[i])
  i = i+1
}

legend(x="bottomright", legend=unique(popnames$pop), col = unique(as.character(popnames$popcolor)), pch = unique(popnames$popshape), cex=1)

dev.off()

#-------------------------------------------------------------------------------------------------------------------
###PC1 vs PC2 region
plot(pca1$li[1,1],pca1$li[1,2], col=as.character(popnames$regioncolor[1]), pch=popnames$regionshape[1], xlab=paste("PC1 -",powerVal1,"%"), ylab=paste("PC2 -", powerVal2,"%"),
     xlim=c(min(pca1$li[,1]),max(pca1$li[,1])), ylim=c(min(pca1$li[,2]),max(pca1$li[,2])), main = "PCA plot of PC1 vs PC2 per region")

abline(0,0, lty=5)
abline(0,180, lty=5)

x <- length(pca1$li[,1])
i=1

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,2], col=as.character(popnames$regioncolor[i]), pch=popnames$regionshape[i])
  #text(pca1$li[i,1], pca1$li[i,2], labels=popnames$ind, cex= 0.45, pos = 4)
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
i=1

while(i <= x){
  points(pca1$li[i,1], pca1$li[i,3], col=as.character(popnames$regioncolor[i]), pch=popnames$regionshape[i])
  i = i+1
}

legend(x="bottomright", legend=unique(popnames$region), col = unique(as.character(popnames$regioncolor)), pch = unique(popnames$regionshape), cex=1)

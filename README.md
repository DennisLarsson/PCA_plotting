# PCA_plotting
R script to calcuate principal components and plot them in R

For the PCA you first need to have a gtx (genetix) file, this can be most easily achieve by converting it in PGDspider. when
converting in PGDspider go to edit spid and then at the bottom of the vcf tab you will see an option for including a
populations file/map. enable this option and give the path to the new popmap that you created for the admixture plot with 
groups. this will make sure that your individuals are sorted in a much more easily managed way in the gtx file. The default 
for the rest should be good. Next go to the genetix tab (tabs are at the top) and make sure that the data type is set to SNP. 
now convert the file.

then use the R script PCA.R to compute the components plot them.

but to make sure we get an informative plot you first have to prepare a csv (comma separated vector) file with how you want 
to color and shape each individual in the plot. See example_popdata.csv for an example.

The first column is where you want to enter (copy paste) your individual name.
The second column is the name of the population.
Third codes which shape it should have when we plot per population (shape of the "dot" in r is coded with number, So here 1 = 
circle).
The fourth codes for color when we plot per population (color in R can be entered either as number (1 = black) or as text).
The fifth is the name of the overarching region you are plotting when we are plotting per region
The sixth column codes for the shape when we plot per region and finally the seventh column is the color of the regions when 
we plot per region.

You will notice in the R script that multiple plots are made: one bar plot of eigen values, two plots with just dots and 
labels, two plots where the defined regions are color and shape coded and two plots where the defined populations are color 
and shape coded. You should only change the path to the .gtx file (object1 <- read.genetix("/home/biogeoanalysis
/RAD/spicatumPhylogeography/06populations/spic_spl_50_nd_mxmaf10.gtx")) and the path to the csv file (popnames <- 
read.csv("/home/biogeoanalysis/RAD/spicatumPhylogeography/06populations_9snps_50miss_inPop/PCA_popdata_reduced.csv")).


You need to change the csv file to fit your project, just be very focused when you change the numbers and names, it is very 
easy to mess them up.

You should only have to edit things in the csv file, the R script should be independent (other than changing the paths to the
files). If your dots get the wrong color or shapes, it is most likely because the format in the csv file is wrong. Please 
double, triple and quadruple check that before asking me for help, I don't want to go through everything unless it is 
absolutely necessary. 

In my R script the color and shape name or number need to be unique for each group. You can not reuse the same color or 
shape, it will not be recognized by the function I am using and it will mess up the legend. you can of course reuse the same
color between columns but not within a column.

You also can't have more color/shape categories than you have groups (for example same color but different shape for two 
populations within a group) the maximum number of categories that you can have is the same number of groups you have (the 
number of categories shown in the legend).

Secondly, individuals belonging to the same group has to be next to each other in the list. For example, this works:
ind1 pop1 1 3 south 1 blue
ind2 pop1 1 3 south 1 blue
ind3 pop2 2 2 west  2 red
ind4 pop2 2 2 west  2 red

but this won't work:
ind1 pop1 1 3 south 1 blue
ind3 pop2 2 2 west  2 red
ind4 pop2 2 2 west  2 red
ind2 pop1 1 3 south 1 blue

and in regards to the first point, about categories, this is an example of what won't work:
ind1 pop1 1 3 south 1 blue
ind2 pop1 1 4 south 1 blue
ind3 pop2 2 2 west  2 red
ind4 pop2 2 2 west  5 red

you can see that we have two categories, either pop1 and pop2 or south and west, but we have more than two categories of 
color for the population (3,4 and 2) and more than two categories of shape for regions (1,2 and 5).

If your individuals aren't aligned like mentioned in the second point, you have to realign them (copy paste) in the .gtx file 
before running the script (scroll to the very bottom of the gtx to find the actual individuals).

if you have something like this:
D47
2
D471       110110 130130 120120 130130 130130 130130
D472       000000 130130 120120 130130 130130 130130
CP969
2
CP9692     000000 130130 120120 130130 130130 130130
CP9693     110110 130130 120120 130130 130130 130130
GMS171
2
GMS1711    130130 130130 100120 130130 110130 000000
GMS1712    110130 130130 120120 130130 110130 130130

but you want GMS171 after D47, then copy paste GMS171 to look like this:
D47
2
D471       110110 130130 120120 130130 130130 130130
D472       000000 130130 120120 130130 130130 130130
GMS171
2
GMS1711    130130 130130 100120 130130 110130 000000
GMS1712    110130 130130 120120 130130 110130 130130
CP969
2
CP9692     000000 130130 120120 130130 130130 130130
CP9693     110110 130130 120120 130130 130130 130130

be patient, it is very difficult for the computer to work in the gtx file with so much information so it will be very slow.

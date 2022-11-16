# Load the packages from this week's tutorial.
#In the tutorial we looked at the community as a whole and the swimmers which ultimately matched a prediction we had for their distribution.
#installing packages
library(spdep)
library(adespatial)
library(vegan)

#setting directory
setwd("C:/GitHub/wintersjb/code/week-10")

#reading csv excel files into the program
PatchLatLon.csv <- read.csv("PatchLatLon.csv", header=T)
BugsByPatch.csv <- read.csv("BugsByPatch.csv", header=T)
HabitatbyPatch.csv <- read.csv("HabitatbyPatch.csv", header=T)
Diptera.csv <- read.csv("Diptera.csv", header=T)
Trichoptera.csv <- read.csv("Trichoptera.csv", header=T)

#changing csv files into matrix
PatchLatLon.mat <- as.matrix(PatchLatLon.csv[,-1])
BugsByPatch.mat <- as.matrix(BugsByPatch.csv)
HabitatbyPatch.mat <- as.matrix(HabitatbyPatch.csv)
Diptera.mat <- as.matrix(Diptera.csv)
Trichoptera.mat <- as.matrix(Trichoptera.csv)

#creating a empty network
nb<-cell2nb(3,30,"queen") 
nb1 <- droplinks(nb, 19, sym=TRUE) 
nb2 <- droplinks(nb1, 22, sym=TRUE)
nb3 <- droplinks(nb2, 25, sym=TRUE)
nb4 <- droplinks(nb3, 30, sym=TRUE)

#turning the network into an aem matrix
bin.mat <- aem.build.binary(nb4, PatchLatLon.mat, unit.angle = "degrees", rot.angle = 90, rm.same.y = TRUE, plot.connexions = TRUE)

aem.ev <- aem(aem.build.binary=bin.mat)

#making the matrix a dataframe
aem.df <- aem.ev$vectors[c(-19,-22,-25,-30),]

#rda of BugsByPatch and the empty network frame
Space.rda <- rda(BugsByPatch.mat, as.data.frame(aem.df))
Space.r2a <- RsquareAdj(Space.rda)$adj.r.squared

#showing the most significant values in order
aem.fwd <- forward.sel(BugsByPatch.mat,aem.df, adjR2thresh=Space.r2a)
aem.fwd$order
#Part 1: Look at two other subsets of the community and determine the relative influence of space and habitat on each following the methods in the tutorial. (10 points)
#The options include groupings by taxonomy, where Diptera (true flies) have the strongest flight ability, Trichoptera the 2nd strongest, 
    #Ephememeroptera are 3rd, and non insects are 4th...because they don't have wings.
#Groupings by habits include the swimmers (off limits for the assignment) as most mobile, sprawlers as 2nd (they move in search of food, but not quickly),
    #and the clingers come in last (they might move up and down on individual rocks).

#rda of comparing diptera to spacial features 
DipteraSpace.rda <- rda(Diptera.mat, as.data.frame(aem.df))
DipteraSpace.r2a <- RsquareAdj(DipteraSpace.rda)$adj.r.squared

#showing the most significant values in order
Dipteraaem.fwd <- forward.sel(Diptera.mat,as.data.frame(aem.df), adjR2thresh=Space.r2a)

Dipteraaem.fwd

#rda and anova comparing diptera spacial features with no habitat features
DipteraSpaceNoHab.rda <- rda(Diptera.mat, as.data.frame(aem.df[,Dipteraaem.fwd$order]), HabitatbyPatch.mat)
DipteraSpaceNoHab.rda 
anova(DipteraSpaceNoHab.rda, perm.max = 10000)
RsquareAdj(DipteraSpaceNoHab.rda)

#rda and anova comparing diptera habitat features with no spacial features
DipteraHabNoSpace.rda <- rda(Diptera.mat, HabitatbyPatch.mat, as.data.frame(aem.df[,Dipteraaem.fwd$order]))
DipteraHabNoSpace.rda 
anova(DipteraHabNoSpace.rda, perm.max = 10000)
RsquareAdj(DipteraHabNoSpace.rda)

#rda of comparing trichoptera to spacial features 
TrichopteraSpace.rda <- rda(Trichoptera.mat, as.data.frame(aem.df))
TrichopteraSpace.r2a <- RsquareAdj(TrichopteraSpace.rda)$adj.r.squared

#showing the most significant values in order
Trichopteraaem.fwd <- forward.sel(Trichoptera.mat,as.data.frame(aem.df), adjR2thresh=Space.r2a)

Trichopteraaem.fwd

#rda and anova comparing trichoptera spacial features with no habitat features
TrichopteraSpaceNoHab.rda <- rda(Trichoptera.mat, as.data.frame(aem.df[,Trichopteraaem.fwd$order]), HabitatbyPatch.mat)
TrichopteraSpaceNoHab.rda 
anova(TrichopteraSpaceNoHab.rda, perm.max = 10000)
RsquareAdj(TrichopteraSpaceNoHab.rda)

#rda and anova comparing trichoptera habitat features with no spacial features
TrichopteraHabNoSpace.rda <- rda(Trichoptera.mat, HabitatbyPatch.mat, as.data.frame(aem.df[,Trichopteraaem.fwd$order]))
TrichopteraHabNoSpace.rda 
anova(TrichopteraHabNoSpace.rda, perm.max = 10000)
RsquareAdj(TrichopteraHabNoSpace.rda)


#Part 2: What is your interpretation of the pattern for each group individually, and the two in comparison, based on their mobility? (5 points)
#My interpretation based on the pattern for diptera and trichoptera individually is that there is a correlation to the amount of space they cover based on mobility, while together the data seems to show that there is a much higher correlation between the amount of space they cover based on mobility rather than the amount of habitat between both groups.
#I think I understand what you are talking about, but where are the results to back it up! You don't identify what pattern you are talking about here or in part 1.

#Part 3: For each of your chosen groups of bugs, perform variable selection for the habitat data rather than the AEM data. Which habitat variables are significant for each? (10 points)
  # Definitions for the habitat column names:

    #Inorg = total suspended inorganic solids in the water column
    #Organ = total suspended organic solids in the water column
    #Chla = Chlorophyll a concentration from benthic rocks collected in-stream
    #BOM = total benthic organic matter in the sample
    #Depth = water depth
    #Flow	= water velocity where samples were collected
    #Fines = Percent of the substrate as "fines" i.e. small particles too small to measure
    #AveAr = The average size of rocks where each sample was collected

#rda of BugsByPatch and HabitatbyPatch
Habitat.rda <- rda(BugsByPatch.mat, as.data.frame(HabitatbyPatch.mat))
Habitat.r2a <- RsquareAdj(Habitat.rda)$adj.r.squared

#showing the most significant values in order
hab.fwd <- forward.sel(BugsByPatch.mat,HabitatbyPatch.mat, adjR2thresh=Habitat.r2a)
hab.fwd

#rda of comparing diptera to habitat features
DipteraHabitat.rda <- rda(Diptera.mat, as.data.frame(HabitatbyPatch.mat))
DipteraHabitat.r2a <- RsquareAdj(DipteraHabitat.rda)$adj.r.squared

#showing the most significant values in order
Dipterahab.fwd <- forward.sel(Diptera.mat,as.data.frame(HabitatbyPatch.mat), adjR2thresh=Habitat.r2a)

Dipterahab.fwd

#rda and anova comparing diptera spacial features with no habitat features
DipteraSpaceNoHab.rda <- rda(Diptera.mat, as.data.frame(HabitatbyPatch.mat[,Dipterahab.fwd$order]), HabitatbyPatch.mat)
DipteraSpaceNoHab.rda 
anova(DipteraSpaceNoHab.rda, perm.max = 10000)
RsquareAdj(DipteraSpaceNoHab.rda)

#rda and anova comparing diptera habitat features with no spacial features
DipteraHabNoSpace.rda <- rda(Diptera.mat, HabitatbyPatch.mat, as.data.frame(HabitatbyPatch.mat[,Dipterahab.fwd$order]))
DipteraHabNoSpace.rda 
anova(DipteraHabNoSpace.rda, perm.max = 10000)
RsquareAdj(DipteraHabNoSpace.rda)

#rda of comparing trichoptera to habitat features
TrichopteraHabitat.rda <- rda(Trichoptera.mat, as.data.frame(HabitatbyPatch.mat))
TrichopteraHabitat.r2a <- RsquareAdj(TrichopteraHabitat.rda)$adj.r.squared

#showing the most significant values in order
Trichopterahab.fwd <- forward.sel(Trichoptera.mat,as.data.frame(HabitatbyPatch.mat), adjR2thresh=Habitat.r2a)

Trichopterahab.fwd 

#rda and anova comparing trichoptera spacial features with no habitat features
TrichopteraSpaceNoHab.rda <- rda(Trichoptera.mat, as.data.frame(HabitatbyPatch.mat[,Trichopterahab.fwd$order]), HabitatbyPatch.mat)
TrichopteraSpaceNoHab.rda 
anova(TrichopteraSpaceNoHab.rda, perm.max = 10000)
RsquareAdj(TrichopteraSpaceNoHab.rda)

#rda and anova comparing diptera habitat features with no spacial features
TrichopteraHabNoSpace.rda <- rda(Trichoptera.mat, HabitatbyPatch.mat, as.data.frame(HabitatbyPatch.mat[,Trichopterahab.fwd$order]))
TrichopteraHabNoSpace.rda 
anova(TrichopteraHabNoSpace.rda, perm.max = 10000)
RsquareAdj(TrichopteraHabNoSpace.rda)


#Which habitat variables were important for each group?

#Part 4: How do you expect selecting both the spatial and the habitat variables would change the results of the RDAs from Part 1 above? (5 points)
  #(You do not need to redo the RDAs, unless you *want* to.)
#Based on my results, it seems that by including both habitat and spatial variables together that there is a much stronger correlation to the amount of space able to be traveled based on their mobility, while there is little to no significance in habitat as the most important factor seems to change between the diptera and the trichoptera, with no significance indicating habitat is as crucial.
#This might be true, but it's tangential to the question. Without selecting variables for habitat, you are likely overfitting that part of the model.
#So the "real" influence of space is likely much stronger than what you generated with the above models.
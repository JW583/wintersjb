setwd("C:/GitHub/wintersjb/code/final-project")
install.packages(c("sourcetools", "shiny"))
install.packages("poppr")
library(poppr)
library(vegan)
library(readxl)

genes.tibble <- read_excel("White_et_al_Brook_Trout_Introgression.xlsx", sheet = "Microsatellite Genotypes")
genes <- as.data.frame(genes.tibble)
head(genes)
trout.avg <- read.csv("Fig3_data_forMark.csv")
head(trout.avg)

genes.names <- paste(genes$ID)
genes$names <- genes.names
genes.means <- aggregate(x = genes, by = list(genes$names), FUN = "mean")
head(genes.means)

trout.avg.names <- paste(trout.avg$Locus.ID)
trout.avg$names <- trout.avg.names
trout.avg.means <- aggregate(x = trout.avg, by = list(trout.avg$names), FUN = "mean")
head(trout.avg.means)

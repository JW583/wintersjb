setwd("C:/GitHub/wintersjb/code/final-project")
library(vegan)

walleye.local <- read.csv("Kraus-et-al-MEE-telemetry-detection-data-for-Erie-Winnipeg.csv")
head(walleye.local)

water.quality <- read.csv("WB_WaterQuality.csv")
head(water.quality)

walleye.local.names <- paste(walleye.local$lattitude, walleye.local$longitude)
walleye.local$names <- walleye.local.names
walleye.local.means <- aggregate(x = walleye.local, by = list(walleye.local$names), FUN = "mean")
head(walleye.local.means)

water.quality.names <- paste(water.quality$lat, water.quality$long)
water.quality$names <- water.quality.names
water.quality.means <- aggregate(x = water.quality, by = list(water.quality$names), FUN = "mean")
head(water.quality.means)

walleye.local.means1 <- walleye.local.means[,-8:-9]
walleye.local.means2 <- walleye.local.means1[,-3:-5]
#walleye.local.means3 <- walleye.local.means2[2:29959,]
head(walleye.local.means2)

water.quality.means1 <- water.quality.means[,-7]
water.quality.means2 <- water.quality.means1[,-20]
water.quality.means3 <- water.quality.means2[,-12:-13]
head(water.quality.means3)
View(water.quality.means3)

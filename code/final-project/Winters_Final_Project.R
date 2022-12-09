setwd("C:/GitHub/wintersjb/code/final-project")
library(vegan)

walleye.local <- read.csv("Kraus-et-al-MEE-telemetry-detection-data-for-Erie-Winnipeg.csv")
head(walleye.local)

water.quality <- read.csv("WB_WaterQuality.csv")
head(water.quality)

#Merge the data spatially instead:
library(nngeo)

#create spatial features from the data frames:
walleye.local.sf <- st_as_sf(walleye.local,coords = c("lattitude", "longitude"))#They spelled latitude wrong - nice and confusing.
water.quality.sf <- st_as_sf(water.quality, coords = c("lat","long"))

#Merge them together by location
matched = st_join(walleye.local.sf, water.quality.sf, join = nngeo::st_nn, maxdist = 5000, k = 1, progress = FALSE)
subset(matched, species == "walleye")

walleye.water.qaulity <- matched[-1:-29958,] # NA column
head(walleye.water.qaulity)
View(walleye.water.qaulity)

colnames(walleye.water.qaulity)
mod1 <- lm(species ~ temp.mean + cond.mean + ph.mean + turb.mean + chloro.mean + do.percent.mean + do.ppm.mean, walleye.water.qaulity)
summary(mod1)

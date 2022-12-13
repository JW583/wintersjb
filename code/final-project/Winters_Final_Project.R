#setting the directory
setwd("C:/GitHub/wintersjb/code/final-project")
#importing packages needed for data analysis, spacial data merging, and graphs
library(vegan)
library(ggplot2)
library(nngeo)

#reading in the .csv data for walleye location points and viewing the data in an R table
walleye.local <- read.csv("Kraus-et-al-MEE-telemetry-detection-data-for-Erie-Winnipeg.csv")
head(walleye.local)

#reading in the .csv data for abiotic water quality measurements and viewing the data in an R table
water.quality <- read.csv("WB_WaterQuality.csv")
head(water.quality)

#creating spatial features from the data frames:
walleye.local.sf <- st_as_sf(walleye.local,coords = c("lattitude", "longitude"))
water.quality.sf <- st_as_sf(water.quality, coords = c("lat","long"))

#Merging them together by location geographic points
matched = st_join(walleye.local.sf, water.quality.sf, join = nngeo::st_nn, maxdist = 5000, k = 1, progress = FALSE)

#removing datapoints that do not include walleye or lake erie (thankfully categorized very neatly to have all walleye lake erie data after the others)
walleye.water.qaulity <- matched[-1:-29958,]

#viewing the merge as a R table and a dataframe output to ensure all data is there and organized
head(walleye.water.qaulity)
View(walleye.water.qaulity)

#reading out the column names of the data merge to have personal memory of what to call for comparisons
colnames(walleye.water.qaulity)

#Model 1 displaying a universal comparison to all the mean value average abiotic conditions per plot point of the walleye species throughout lake erie
mod1 <- lm(tagnumber ~ depth.mean + temp.mean + cond.mean + ph.mean + turb.mean + chloro.mean + do.percent.mean + do.ppm.mean + season, walleye.water.qaulity, na.action = na.exclude)
#summary of model 1
summary(mod1)
#ANOVA of model 1
anova(mod1)
#AIC of model 1
AIC(mod1)
#Residual plot of model 1 seeing how correlated the model factors are and seeing how good of a fit the overal model is
plot(mod1$residuals)
#Adjusted R squared summary of model 1
summary(mod1)$adj.r.squared

#model 2 removing the dissolved oxygen values as they showed the least significance in walleye location
mod2 <- lm(tagnumber ~ depth.mean + temp.mean + cond.mean + ph.mean + turb.mean + chloro.mean + season, walleye.water.qaulity, na.action = na.exclude)
#summary of model 2
summary(mod2)
#ANOVA of model 2
anova(mod2)
#AIC comparison with model 2 added
AIC(mod1,mod2)
#Residual plot of model 2 seeing how correlated the model factors are and seeing how good of a fit the overal model is
plot(mod2$residuals)
#Adjusted R squared summary of model 2
summary(mod2)$adj.r.squared

#model 3 removing conductivity values as they were the next least significant in determining walleye location
mod3 <- lm(tagnumber ~ depth.mean + temp.mean + ph.mean + turb.mean + chloro.mean + season, walleye.water.qaulity, na.action = na.exclude)
#summary of model 3
summary(mod3)
#ANOVA of model 3
anova(mod3)
#AIC comparison with model 3 added
AIC(mod1,mod2,mod3)
#Residual plot of model 3 seeing how correlated the model factors are and seeing how good of a fit the overal model is
plot(mod3$residuals)
#Adjusted R squared summary of model 3
summary(mod3)$adj.r.squared

#model 4 removing depth as that seems to be the next least important factor when dealing with walleye location
mod4 <- lm(tagnumber ~ ph.mean + turb.mean + chloro.mean + temp.mean + season, walleye.water.qaulity, na.action = na.exclude)
#summary of model 4
summary(mod4)
#ANOVA of model 4
anova(mod4)
#AIC comparison with model 4 added
AIC(mod1,mod2,mod3,mod4)
#Residual plot of model 4 seeing how correlated the model factors are and seeing how good of a fit the overal model is
plot(mod4$residuals)
#Adjusted R squared summary of model 4
summary(mod4)$adj.r.squared
#with model 4 complete, it seems to be that temperature, ph value, turbid water, and chloroform levels seem to be the biggest factors in walleye locations. 

#model 5 comparing all factors from above but multiplying temperature and ph value together to see if it holds more significance combined
mod5 <- lm(tagnumber ~ turb.mean + chloro.mean + temp.mean*ph.mean*season, walleye.water.qaulity, na.action = na.exclude)
#summary of model 5
summary(mod5)
#ANOVA of model 5
anova(mod5)
#AIC comparison with model 5 added
AIC(mod1,mod2,mod3,mod4,mod5)
#Residual plot of model 5 seeing how correlated the model factors are and seeing how good of a fit the overal model is
plot(mod5$residuals)
#Adjusted R squared summary of model 5
summary(mod5)$adj.r.squared

#model 6 comparing all factors from above but multiplying all together by comparison to tag number to see if all have equal weight when comparing abiotic factors to walleye locations
mod6 <- lm(tagnumber ~ turb.mean*chloro.mean*temp.mean*ph.mean*season, walleye.water.qaulity, na.action = na.exclude)
#summary of model 6
summary(mod6)
#ANOVA of model 6
anova(mod6)
#AIC comparison with model 6 added
AIC(mod1,mod2,mod3,mod4,mod5, mod6)
#Residual plot of model 6 seeing how correlated the model factors are and seeing how good of a fit the overal model is
plot(mod6$residuals)
#Adjusted R squared summary of model 6
summary(mod6)$adj.r.squared
#with all these models in place, we can see based on the AIC score that model 6 is the best representation of the data, and that from model 6 we can see that just about every abiotic factor has equal importance in determining walleye location preference, with the exception here being temperature in the water during the seasons alone without the other factors has no overbearing correlation. showing while all have their own significance on the walleye population, its actually a combination of all 4 factors with the current season being the biggest contributing picture to the walleye population and their spread throughout lake erie, with spring into summer seasons being a much more important factor than summer into fall when discussing the walleye population preferences. 

#barplot comparing the mean average of all important factors to each season showing which season has a greater factor in walleye success and disperal in lake erie 
ggplot(data = walleye.water.qaulity, mapping = aes(x = season, y = ph.mean + turb.mean + chloro.mean + temp.mean, color=season)) + 
  geom_bar(stat="identity", width=0.2, fill="white") + theme_minimal()
#scatterplot comparing the mean average of temperature with the tagnumber of each walleye to show the most important temperature range (in Celsius) for walleye success while displaying which season the factor has greater importance in
ggplot(data = walleye.water.qaulity, mapping = aes(x = temp.mean, y = tagnumber, color=season)) + 
  geom_point(stat="identity", fill="white") + theme_minimal()
#scatterplot comparing the mean average of Ph with the tagnumber of each walleye to show the most important Ph range for walleye success while displaying which season the factor has greater importance in
ggplot(data = walleye.water.qaulity, mapping = aes(x = ph.mean, y = tagnumber, color=season)) + 
  geom_point(stat="identity", fill="white") + theme_minimal()
#scatterplot comparing the mean average turbulants with the tagnumber of each walleye to show the most important turbulants range for walleye success while displaying which season the factor has greater importance in
ggplot(data = walleye.water.qaulity, mapping = aes(x = turb.mean, y = tagnumber, color=season)) + 
  geom_point(stat="identity", fill="white") + theme_minimal()
#scatterplot comparing the mean average chloroform quantity with the tagnumber of each walleye to show the most important chloroform quantity range for walleye success while displaying which season the factor has greater importance in
ggplot(data = walleye.water.qaulity, mapping = aes(x = chloro.mean, y = tagnumber, color=season)) + 
  geom_point(stat="identity", fill="white") + theme_minimal()




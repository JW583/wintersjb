# Read in the "Toscano_Griffen_Data.csv" data from GitHub and load the three packages we used in the tutorial this week.
# The paper these data came from is uploaded to Canvas as "Toscano&Griffen_2014_JAE..."
setwd("C:/GitHub/wintersjb/code/week-6")
df <- read.csv("Toscano_Griffen_Data.csv")
head(df)
library(MASS)
library(MuMIn)
library(mgcv)
# First create models with the same (y) and method (GLMM) as the published paper, using the GLMM function from the tutorial. 
glmm.mod <- glmmPQL(activity.level~eaten, family = gaussian, random = ~ 1 | block, data = df)
summary(glmm.mod)
  #Create two different models using the same 3 predictor (x) variables from the dataset. (4 points each) 
    # In one model only include additive effects.
    # In the other model include one interactive effect.
#additive effects model
glmm.mod2 <- glmmPQL(temperature~carapace.width + toadfish.cue.treatment + claw.width, family = gaussian, random = ~ 1 | block, data = df)
summary(glmm.mod2)
#interactive effect
glmm.mod3 <- glmmPQL(eaten~carapace.width + toadfish.cue.treatment + claw.width, family = gaussian, random = ~ 1 | block, data = df)
summary(glmm.mod3)
#There is no interactive effect in this model... interactive = *  ;  additive = +
    # Use a binomial distribution and block as a random effect in both models to match the paper's analyses. Remember ?family to find distribution names.
?family
# The authors used proportional consumption of prey as the (y) in their model, but did not include this in the dataset.
  # So we are going to create it - run the following line, assuming df= your data frame (feel free to change that):
df$prop.cons <- df$eaten/df$prey 

# (Q1) - The code in line 8 is performing two operations at once. What are they? (2 pts)

# it is creating a new variable along with dividing prey data from the eaten data
# (Q2) - Did the interactive effect change which variables predict proportional consumption? How, specifically, did the results change? (5 pts)
glmm.mod4 <- glmmPQL(prop.cons~carapace.width + toadfish.cue.treatment + claw.width, family = gaussian, random = ~ 1 | block, data = df)
summary(glmm.mod4)
#The interactive effect changed which variables predict proportional consumption, specifically now there is a correlation between claw width and consumption, along with a stronger correlation with carapace width.It does however lower the significance of toadfish cues affecting consumption.
#what are you calling the interactive effect? There is no interaction in this model.
# (Q3) - Plot the residuals of both models. Do you think either model is a good fit? Why or why not? (3 pts)
plot(glmm.mod3)
plot(glmm.mod4)
#out of the two present models, the model that is a good fit for this is model 4. Compared to the model 3 using eaten, it is alot more random and has more fitted data than that of model 3, which is very linear and not random in the slightest.
#All true, however neither is really a good fit because both have a pattern in the residuals.
# Re-run both models as generalized additive models instead (using gam). Then compare the AIC of both models. (4 points each)
gam.mod1 <- gam(eaten~carapace.width + toadfish.cue.treatment + claw.width, family = gaussian,random = list(block=~ 1), data = df)
gam.mod2 <- gam(prop.cons~carapace.width + toadfish.cue.treatment + claw.width, family = gaussian,random = list(block=~ 1), data = df)
summary(gam.mod1)
summary(gam.mod2)
AIC(gam.mod1) 
AIC(gam.mod2) 
# (Q4) - Which model is a better fit? (2 pt)
#gam.mod2 is the model with the better fit, as while they have very similar R-squared values, the model with prop.cons (gam.mod2) has a significantly lower AIC than that of the model with eaten (gam.mod1), making it the best approximation of the two.
#Actually not comparable because you used two different y variables.
# (Q5) - Based on the residuals of your generalized additive models, how confident are you in these results? (2 pts)
plot(gam.mod1$residuals)
plot(gam.mod2$residuals)
#based on the residuals of the additive models, I am very confident that the model with prop.cons (gam.mod2) is the best way to approximate the data within the set, due to the similar r-sqaure,low AIC, and non linearity of the residual plot. 
#There is still clearly a pattern in both sets of residuals.






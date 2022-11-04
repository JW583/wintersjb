# For this week it's time to start exploring your own ideas and questions in R.
  # There are at least five options in the dataset to create the following comparisons.

  library(readxl)
  library(vegan)
  setwd("C:/GitHub/wintersjb/code/week-9")
# (Q1 - 12 pts) Use the dataset from the tutorial to complete one redundancy analysis (RDA) with variance partitioning on a different community (NOT the nematodes).
  # Explain the ecological importance of your significant predictor variables, or the importance if none are significant for your community.
  
  #Creating the abiotic tibble
  abiotic.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Abiotic factors")
  abiotic <- as.data.frame(abiotic.tibble)
  head(abiotic)
  
  #creating the vegetation plots tibble
  veg.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Vegetation_plots_all_sites")
  veg <- as.data.frame(veg.tibble)
  head(veg)
  
  #sorting by names
  abiotic.names <- paste(abiotic$Site, abiotic$Land_Use, abiotic$Plot)
  abiotic$names <- abiotic.names

  veg.names <- paste(veg$Site, veg$Landuse, veg$plot)
  veg$names <- veg.names
  
  #aggregating the functions to find and sort the mean values by names column
  abiotic.means <- aggregate(x = abiotic, by = list(abiotic$names), FUN = "mean")
  head(abiotic.means)
  
  veg.means <- aggregate(x = veg, by = list(veg$names), FUN = "mean")
  head(veg.means)
  
  #adjusting the data to fit into the RDA function, reducing to 6 rows each and removing the NA columns  
  abiotic.means1 <- abiotic.means[,-16]
  abiotic.means1 <- abiotic.means1[14:19,]
  abiotic.means2 <- abiotic.means1[,-1:-6]
  abiotic.means2 <- sapply(abiotic.means2, as.numeric )
  abiotic.means2 <- as.data.frame(abiotic.means2) 
  
  veg.means1 <- veg.means [-98]
  veg.means2 <- as.data.frame(veg.means1[,-1:-4])
  veg.means2 <- sapply(veg.means2, as.numeric )
  
  #making sure it worked and deleted what it needed to
  head(abiotic.means2)
  head(veg.means2)
  
  View(abiotic.means2)
  View(veg.means2)
  
  #using the column names from abiotic factors then making a general RDA analysis to get a broad scope of the abiotic factors effects on the plant community sampled
  colnames(abiotic.means2)
  ord <- rda(veg.means2 ~ pH + totalN + Perc_ash + Kalium + Magnesium + Ca + Al + TotalP + OlsenP, abiotic.means2)
  ord
  anova(ord)  
  plot(ord)
  
  #running analysis test to see which factors might have the most impact on the community
  ord.int <- rda(veg.means2 ~1, abiotic.means2)
  
  step.mod <- ordistep(ord.int, scope = formula(ord), selection = "both")
  
  #My RDA test to see if there was any correlation between these 3 and the plant community, based on what I would have thought to potentially effect their success.
  ord2 <- rda(veg.means2 ~ pH + totalN + TotalP, abiotic.means2)
  ord2
  anova(ord2)
  plot(ord2)
  
  #For this RDA, I wanted to see if the overall pH, along with the amount of nitrogen and phosphorous in the soil, had any effect on the plant population, which the analysis showed that the amount of pH and nitrogen have little to no effect on the success of the plant community, while phosphourous seems to be heavily correlated to the communities success. This most likely means that the amount of phosphorous within the soul dictates how much a plant species is able to populate and thrive within the ecosystem. 
  
  # (Q2 - 12 pts) Then use the dataset from the tutorial to create a linear model related to your RDA. Try multiple predictors to find the best fit model.
  # Explain the ecological importance of the significant predictors, or lack of significant predictors.
  
  #second test based on the highest F value, both seem to be very prominent driving abiotic factors
  ord2 <- rda(veg.means2 ~ Magnesium + TotalP, abiotic.means2)
  ord2
  anova(ord2)
  plot(ord2)
  
  #third test to see if the other type of phosphorous had as big of an impact as the other two factors
  ord3 <- rda(veg.means2 ~ Magnesium + TotalP + OlsenP, abiotic.means2)
  ord3
  anova(ord3)
  plot(ord3)
  
  #seeing if pH had any important correlation with the other two prominent driving abiotic factors
  ord3 <- rda(veg.means2 ~ pH + Magnesium + TotalP, abiotic.means2)
  ord3
  anova(ord3)
  plot(ord3)

  #Based on these few test, these seemed to be the most likely factors based on the analysis to have a strong correlation the plant communities success, which based on my models, seems to be that model 2 would be the best fit to show the driving abiotic factors that formulate the plant communities within the plots. Based on the RDA both the amount of magnesium and total amount of phosphorous within the soil composition determines what kind and how abundant a specific plant community is within the plots, with there being more plant diversity overall in places with good amounts of magnesium and phosphorous within the soil, with diversity drastically decreasing with less of those resources present.

  # (Q3 - 6 pts) Provide a 3-4 sentence synthesis of how these results relate to one another and the value of considering both together for interpreting biotic-abiotic interactions.
  
  #Based on my results, both magnesium and phosphorous are highly important abiotic factors when determining the various plant species that can thrive in these communities. Both magnesium and phosphorous concentrations affect the soil chemestry within these locations, which these nutrients the plants would be able to take in and use to grow and multiply, in this case plant diversity seemed to be most abundant in places with higher concentration of these two elements, versus plots where these elements were lacking having an overall lower diversity and abundance. Tying this into a bigger picture, these plants most likely correlate to more oxygen and nitrogen within the community, allowing the invertebrates and nematodes to benefit from the fix and be more diverse in the location with more fauna diversity, creating a stronger and more stable community than to places that were lacking in these resources that hindered these plants species overall success.


# First, recreate Figure 4 from Herron et al. (2019). De novo origins of multicellularity in response to predation. Scientific Reports.
  # Search datadryad.org by the paper title and download the dataset. It will include .csv files and R scripts, organized by figure.
  # Save the script and change the working directory on lines 8 and 115 to match your GitHub repository. (6 points)
  # Export and save the plot you've created. (2 points)
  # Zoom into your plot to look at the distribution for different strains.

# Do all of the strains in the plot have the same distributions (yes/no)? (2 pt)
  #All of the strains in the plot do not have the same distribution, as the B strains tend to be more diverse in the amount of cells per propagule with much greater ranges than that of K.

# Based on these observations of your strain distributions, why did the authors use a Kruskal-Wallis test rather than ANOVA to compare the strains? (2 pts)
  #The authors most likely used a Kruskal-Wallis test rather than ANOVA when comparing the strains as Kurskal-Wallis is a more broad test that compares if possibilities are higher or lower than average, rather than ANOVA that tests specifically for if there is equality between values for a comparison.

# Use the fitdist() and gofstat() functions to compare the poisson, negative binomial, and logistic distributions for:
  # (1) - The number of cells of progeny (data$Num.Cells.Progeny)
  # (2) - The replication time (data$RepTime.sec)
      # 3 points each
    #HINT- "Num.Cells.Progeny" has defined breaks. To display results, use the formula with the "chisqbreaks" argument as follows:
      #gofstat(list(fit.1, fit.2, fit.3, etc), chisqbreaks=c(1,2,4,8,16,32,64))

setwd("C:/GitHub/wintersjb/code/week-5")
data <- read.csv("Figure4Data.csv", header=TRUE)

Progeny.col <- data$Num.Cells.Progeny
hist(Progeny.col, main = "Cell Progeny")

fit.poisson <- fitdist(Progeny.col, distr = "pois")
fit.logistic <- fitdist(Progeny.col, distr = "logis")
fit.nbinome <- fitdist(Progeny.col, distr = "nbinom")

Time.col <- data$RepTime.sec
hist(Time.col, main = "Rep Time")

fit.poisson <- fitdist(Time.col, distr = "pois")
fit.logistic <- fitdist(Time.col, distr = "logis")
fit.nbinome <- fitdist(Time.col, distr = "nbinom")

# Based on the AIC scores, which distribution is the best fit for: (4 pts)
  # (1) - The number of cells of progeny (data$Num.Cells.Progeny)?
  # (2) - The replication time (data$RepTime.sec)?


# Plot a generic histogram for the replication time (data$RepTime.sec) (2 pt)

# Based on the patterns of this histograms and Figure 4:
  #Give one hypothesis for an evolutionary process represented by the two tallest bars in your histogram. (6 pts)
  # Don't cheat by looking at the paper! 
    # This hypothesis does not need to be correct - it only needs to be ecologically rational based these two figures.









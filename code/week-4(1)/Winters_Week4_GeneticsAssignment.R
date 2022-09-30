# Look at the plot and model results for our Dryad data in the tutorial. Part 1: Without knowing which points represent which groups, 
  # give one explanation for why these data might be difficult to draw spatial inferences about genes.(3 points)
    
  #the data is particularly hard to draw spatial inferences about genes due to the lack of a key explainging the different colored plots. Without some form of key ontop of the lack of axis labels, the points of data become a jumbled mess that is hard to get a clear reading out of.
  #This is a good reason why the plot is tough to read, but doesn't address the underlying data.
# Part 2: Despite the drawbacks, give the result or interpretation that you feel most confident in (3 points), and EXPLAIN WHY (4 points).
    
    #Based on the limited information known from the plot, my interpretation is that the more dull colored dots are more genetically diverse than the lighter colored dots, with light blue being the least diverse and black being the most. My reasoning for this conclusion is due to the numbers on the x and y axis corresponding to the color plots on the graph the light blue dots are the most close together, which I interpret as being closley related or not as genetically distant. The darker colored points, especially the black points, is the most spread apart, which I interpret as being the most genetically distant.

# For your scripting assignment we will use the "ge_data" data frame found in the "stability" package.
  # Install the "stability" package, load it into your R environment, and use the data() function to load the "ge_data". (2 points)

#Installing and reading the stability package
install.packages("stability")
library(stability)
#grabbing/loading ge_data
data("ge_data")
#reading the references to understand the package function
help("ge_data")

# Create two linear models for Yield Response: one related to the Environment and one to the Genotype. (2 points each)
  # 'Yield Response' in this dataset is a measure of phenotype expression.
  # Hint: Look at the help file for this dataset.

#Ill be honest I have no idea if this is what you meant. I understood what the question was asking but not what a "linear model" is in respective, thus this could be completely wrong here.
#What you did below at line 36-43 is what I was looking for. Never a bad idea to plot the data too, just wasn't required this time.
#Plots of correlation between yield response and genotype and yield response and environment respectively 
plot(ge_data$Yield ~ ge_data$Gen)
plot(ge_data$Yield ~ ge_data$Env)

# Test the significance of both models and look at the model summary. (3 points each)
  # Which model is a better fit to explain the yield response, and WHY? (6 points)
  # Hint: Does one model seem more likely to be over-fitted?

#creating(?) and testing significance between yield response and genotype of the data set
mod.gene <- lm(ge_data$Yield ~ ge_data$Gen)
anova(mod.gene)
summary(mod.gene)

#creating(?) and testing significance between yield response and environment of the data set
mod.env <- lm(ge_data$Yield ~ ge_data$Env)
anova(mod.env)
summary(mod.env)

  #Out of both model output summaries, I believe the model comparing yield response to environment is the better fit to explain yield response. My reasoning for this is while comparing genotypes to yield response gives a similar response and proves the data significant, There is alot more clutter and morso over information than needed to prove a trend in the model, while comparing yield response to environment gives the same significance while being more uniform and giving data more relevant to comparison rather than an onslaught of data that isn't as necessary to find a correlation.
#Yep! Think about how to explain this in terms of R squared too.
# Which environment would be your very WORST choice for generating a strong yield response? (2 points)
  #Based on the environment summary, The worst choice for generating a strong yield response would be the environment KSK, as it has the lowest t value along with standard deviation, making it the least viable of the environments.
#So this question was about significance rather than a positive or negative response (notice it's asking strong, not positive). From your interpretation the answer is correct.

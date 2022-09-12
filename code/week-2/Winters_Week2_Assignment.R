# With the data frame you created last week you will:
#Data
a <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
b <- c(1,2,3,4,5,1,2,3,4,5,1,2,3,4,5)
c <- c(1,1.3,1.87,2,2.13,2.5,2.86,3,3.32,3.74,4,4.2,4.66,4.9,5)
d <- c('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o')
e <- c('a','b','c','a','b','c','a','b','c','a','b','c','a','b','c')

#frame creation
df <- as.data.frame(cbind(a,b,c,d,e))
df$b <- as.numeric(as.character(df$b))
df$c <- as.numeric(as.character(df$c))

#adding 16th row
add.row <- data.frame(16,1,5.5,"p","a")
colnames(add.row) <- colnames(df) 
df1 <- rbind(df, add.row)

#naming rows and removing organization data
row.names(df1) <- df1$d
df1 <- df1[,-4]
df1

# Create a barplot for one numeric column, grouped by the character vector with 3 unique values
  # Add error bars with mean and standard deviation to the plot
  # Change the x and y labels and add a title
  # Export the plot as a PDF that is 4 inches wide and 7 inches tall.

#establishing mean data
df.mean <- aggregate(df1$c ~df1$e, FUN = "mean")
df.mean

#renaming columns 
colnames(df.mean) <- c("Factor","Mean")
df.mean

#creating base plot
barplot(df.mean$Mean)

#labels
barplot(df.mean$Mean, names.arg = df.mean$Factor)

#establishing standard deviation data
df.sd <- aggregate(df1$c ~df1$e, FUN = "sd")

#renaming columns
colnames(df.sd) <- c("Factor","StanDev")
df.sd

#giving bar plot titles and y axis height variables
b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor, xlab = "Mean Average", ylab = "Factors", main = "The REAL Bar Plot", ylim = c(0,5))

#adding error bars for mean + standard deviation 
arrows(b.plot, df.mean$Mean-df.sd$StanDev,
       b.plot, df.mean$Mean+df.sd$StanDev,angle=90,code=3)

#Exporting bar plot as pdf
pdf( file = "Winters_barplot.pdf", width = 4, height = 7)
b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor, xlab = "Mean Average", ylab = "Factors", main = "The REAL Bar Plot", ylim = c(0,5))
arrows(b.plot, df.mean$Mean-df.sd$StanDev,
       b.plot, df.mean$Mean+df.sd$StanDev,angle=90,code=3)
dev.off()

# Create a scatter plot between two of your numeric columns.
  # Change the point shape and color to something NOT used in the example.
  # Change the x and y labels and add a title
  # Export the plot as a JPEG by using the "Export" button in the plotting pane.

#Creating scatter plot with axis labels and title and text change
par(family = "serif")
plot(df1$c ~ df1$a, xlab = "Quality", ylab = "Quantity", main = "The REAL Scatter Plot", cex.axis=0.8, cex.main = 1.5, cex.lab = 1.25, pch=8, col = "steelblue2", cex = 2)
# Upload both plots with the script used to create them to GitHub.
  # Follow the same file naming format as last week for the script.
  # Name plots as Lastname_barplot or Lastname_scatterplot. Save them to your "plots" folder.
setwd("C:/GitHub/wintersjb")
dev.off()

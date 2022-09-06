# Now it is time to create your own data frame using the tools we have learned this week.
# First, resave this script as: your last name_Week1_Assignment
  # e.g. mine would be Wilson_Week1_Assignemnt


# Create 3 numeric vectors and 2 character vectors that are each 15 values in length with the following structures:
  # One character vector with all unique values
  # One character vector with exactly 3 unique values
  # One numeric vector with all unique values
  # One numeric vector with some repeated values (number of your choosing)
  # One numeric vector with some decimal values (of your choosing)
a <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
b <- c(1,2,3,4,5,1,2,3,4,5,1,2,3,4,5)
c <- c(1,1.3,1.87,2,2.13,2.5,2.86,3,3.32,3.74,4,4.2,4.66,4.9,5)
d <- c('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o')
e <- c('a','b','c','a','b','c','a','b','c','a','b','c','a','b','c')

a
b
c
d
e
# Bind the vectors into a single data frame, rename the columns, and make the character vector with unique values the row names.
data <- cbind(a,b,c,d,e)
data
df <- as.data.frame(data)
df
colnames(df) <- c("Yes", "Maybe", "Mmmm", "Why", "No")
df
row.names(df) <- df$Why
df
# Remove the character vector with unique values from the data frame.
df.a <- df[,-4]
df.a
# Add 1 row with unique numeric values to the data frame.
p <- data.frame(16,1,5.5,"yeah")
p
colnames(p) <- colnames(df.a)    
rbind(df.a, p)

df.r <- rbind(df.a, "p")
df.r
row.names(df.r) <- c(row.names(df.a[1:3,]),"p")
df.r
# Export the data frame as a .csv file 
setwd("C:/GitHub/R4Eco_2022/Week1")
getwd()
smart_wd <- function (repo, folder=NULL) {
  if(missing(folder))
  {
    setwd(print(paste(if (Sys.info()[["sysname"]]=="Windows") {("C:/GitHub")} else {
      if (Sys.info()[["sysname"]]=="Darwin"){("~/GitHub")} else ("for Linux run: setwd('/home/[wintersjb]/GitHub')")
    },"/",repo, sep = "")))}
  else 
    
  {
    setwd(print(paste(if (Sys.info()[["sysname"]]=="Windows") {("C:/GitHub")} else {
      if (Sys.info()[["sysname"]]=="Darwin"){("~/GitHub")} else ("for Linux run: setwd('/home/[wintersjb]/GitHub')")
    },"/",repo, "/", folder, sep = "")))}
}
write.csv(df.r, file = "Week1.csv")
# Generate summary statistics of your data frame and copy them as text into your script under a new section heading.
#Column1		Column2		Column3	

#Mean	8	Mean	3	Mean	3.098666667
#Standard Error	1.154700538	Standard Error	0.377964473	Standard Error	0.334542853
#Median	8	Median	3	Median	3
#Mode	#N/A	Mode	1	Mode	#N/A
#Standard Deviation	4.472135955	Standard Deviation	1.463850109	Standard Deviation	1.295678899
#Sample Variance	20	Sample Variance	2.142857143	Sample Variance	1.67878381
#Kurtosis	-1.2	Kurtosis	-1.328205128	Kurtosis	-1.178000989
#Skewness	-3.66E-17	Skewness	0	Skewness	-0.019481058
#Range	14	Range	4	Range	4
#Minimum	1	Minimum	1	Minimum	1
#Maximum	15	Maximum	5	Maximum	5
#Sum	120	Sum	45	Sum	46.48
#15	15	15	15	15	15

# Push your script and your .csv file to GitHub in a new "Week1" folder.




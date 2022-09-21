# (1) Approximately how many hours ahead of Sunbury was the peak flow in Lewisburg during the 2011 flood? (1 pt)
  #Sunbury was approximately 3 hours ahead for the peak flow during the 2011 flood than Lewisburg.


# (2) Give one reason why information on the time between peak flow events up- and downstream could be valuable information? (3 pts)
 #One reason information on the time between peak flow events up and downstream could be valuable to predict flooding patterns for future events and what you could potentially expect if another occured.

# Package scavenger hunt! (8 pts each)

## (3) Using Google and ONLY packages from GitHub or CRAN:
    # Find a package that contains at least one function specifically designed to measure genetic drift.
    # Copy-paste into your script - and run - an example from the reference manual for a function within this package related to a measure of genetic drift. 
        # Depending on the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
    # After running the function example, manipulate a parameter within the function to create a new result. 
        # Common options might be allele frequency, population size, fitness level, etc. 
        # Add the results of this manipulation to your script (if in the console) or upload the new plot.
       
          # By manipulating these parameters you can see how it impacts the results.
          # This type of manipulation is one example of how theoretical ecology and modelling are used to predict patterns in nature.

#Installing the genetic drift package
install.packages("learnPopGen")

library(learnPopGen)

#Example of the genetic drift function
genetic.drift()
object<-genetic.drift(p0=0.7,show="heterozygosity")
plot(object,show="genotypes")

#Manipulated example of genetic drift function
object<-genetic.drift(p0=0.3,Ne=15,nrep=8,time=50,pause=0.1,show="heterozygosity")
plot(object,show="genotypes")

## (4) Using Google and ONLY packages from GitHub or CRAN:
    # Find a package that will generate standard diversity metrics for community ecology, specifically Simpson's Diversity Index.
    # Copy-paste into your script - and run - an example from the reference manual for a function to calculate Simpson's diversity. 
        # Depending on the example usage of the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
    # After running the function example, modify your script to generate another diversity metric that is NOT part of the example. 
        # If there are two diversity metrics in the example script, neither of these will count as the modified script.
        # Hint: If the function can "only" caluclate Simpson's diversity, the inverse of Simpson's diversity is another common metric. 
        # Add the results of this manipulation to your script (if in the console) or upload the new plot.
        
          # Diversity metrics are frequently used in community ecology for reasons ranging from a quick comparison between sites to understanding community stability.
          # Their calculation can be very tedious by hand - and very fast with a package designed for the operation.

#Installing the genetic drift package
install.packages("diverse")

library(diverse)

#Given Examples of the diversity function
data(pantheon)
diversity(pantheon)
diversity(pantheon, type='variety')
diversity(geese, type='berger-parker', category_row=TRUE)
#reading csv data matrix
path_to_file <- system.file("extdata", "PantheonMatrix.csv", package = "diverse")
X <- read_data(path = path_to_file)
diversity(data=X, type="gini")
diversity(data=X, type="rao-stirling", method="cosine")
diversity(data=X, type="all", method="jaccard")
print("             variety  entropy       HHI blau.index gini.simpson gini.simpson.C gini.simpson.R  simpson.D simpson.I simpson.R hill.numbers berger.parker.D
Canada            27 2.559899 0.1391628  0.8608372    0.8608372      0.1391628       7.185827 0.13174182 0.8682582  7.590604           27       0.3162393
Chile              7 1.626709 0.2396450  0.7603550    0.7603550      0.2396450       4.172840 0.20923077 0.7907692  4.779412            7       0.3846154
China             24 2.340469 0.1831446  0.8168554    0.8168554      0.1831446       5.460167 0.17480932 0.8251907  5.720519           24       0.3838384
Latvia            10 1.889159 0.2345679  0.7654321    0.7654321      0.2345679       4.263158 0.18954248 0.8104575  5.275862           10       0.4444444
New Zealand        9 2.106577 0.1326531  0.8673469    0.8673469      0.1326531       7.538462 0.06593407 0.9340659 15.166667            9       0.2142857
Portugal          11 1.610050 0.2899660  0.7100340    0.7100340      0.2899660       3.448680 0.28141136 0.7185886  3.553517           11       0.4285714
Saudi Arabia       7 1.331425 0.3453061  0.6546939    0.6546939      0.3453061       2.895981 0.32605042 0.6739496  3.067010            7       0.4857143
South Africa      16 2.440072 0.1211073  0.8788927    0.8788927      0.1211073       8.257143 0.09447415 0.9055258 10.584906           16       0.2647059
Uruguay            4 1.135551 0.3739612  0.6260388    0.6260388      0.3739612       2.674074 0.33918129 0.6608187  2.948276            4       0.5263158
Vietnam            4 1.168518 0.3719008  0.6280992    0.6280992      0.3719008       2.688889 0.30909091 0.6909091  3.235294            4       0.5454545
             berger.parker.I renyi.entropy  evenness hcdt.entropy rao.stirling
Canada              3.162162      3.295837 0.7767069           27    0.2535743
Chile               2.600000      1.945910 0.8359632            7    0.1798306
China               2.605263      3.178054 0.7364472           24    0.2527998
Latvia              2.250000      2.302585 0.8204514           10    0.2331496
New Zealand         4.666667      2.197225 0.9587447            9    0.2200316
Portugal            2.333333      2.397895 0.6714431           11    0.1956445
Saudi Arabia        2.058824      1.945910 0.6842170            7    0.2116735
South Africa        3.777778      2.772589 0.8800700           16    0.2618224
Uruguay             1.900000      1.386294 0.8191267            4    0.1273084
Vietnam             1.833333      1.386294 0.8429079            4    0.2341598")
#reading csv dataframe
path_to_file <- system.file("extdata", "PantheonEdges.csv", package = "diverse")
X <- read_data(path = path_to_file)
#hill numbers
diversity(data=X, type="td", q=1)
print("             hill.numbers
Canada          12.934513
Chile            5.087107
China           10.386105
Latvia           6.613805
New Zealand      8.220059
Portugal         5.003062
Saudi Arabia     3.786435
South Africa    11.473870
Uruguay          3.112887
Vietnam          3.217222")
#rao stirling with differente arguments
diversity(data=X, type="rao-stirling", method="euclidean", alpha=0, beta=1)
print (             "rao.stirling
                    Canada          0.4304186
                    Chile           0.3801775
                    China           0.4084277
                    Latvia          0.3827160
                    New Zealand     0.4336735
                    Portugal        0.3550170
                    Saudi Arabia    0.3273469
                    South Africa    0.4394464
                    Uruguay         0.3130194
                    Vietnam         0.3140496")
#more than one diversity measure
diversity(data=X, type=c('e','ev','bp','s'))
print(              "entropy  evenness berger.parker.D berger.parker.I  simpson.D simpson.I simpson.R
                    Canada       2.559899 0.7767069       0.3162393        3.162162 0.13174182 0.8682582  7.590604
                    Chile        1.626709 0.8359632       0.3846154        2.600000 0.20923077 0.7907692  4.779412
                    China        2.340469 0.7364472       0.3838384        2.605263 0.17480932 0.8251907  5.720519
                    Latvia       1.889159 0.8204514       0.4444444        2.250000 0.18954248 0.8104575  5.275862
                    New Zealand  2.106577 0.9587447       0.2142857        4.666667 0.06593407 0.9340659 15.166667
                    Portugal     1.610050 0.6714431       0.4285714        2.333333 0.28141136 0.7185886  3.553517
                    Saudi Arabia 1.331425 0.6842170       0.4857143        2.058824 0.32605042 0.6739496  3.067010
                    South Africa 2.440072 0.8800700       0.2647059        3.777778 0.09447415 0.9055258 10.584906
                    Uruguay      1.135551 0.8191267       0.5263158        1.900000 0.33918129 0.6608187  2.948276
                    Vietnam      1.168518 0.8429079       0.5454545        1.833333 0.30909091 0.6909091  3.235294")

#Manipulated version of the diversity function
diversity(geese, type = "simpson", category_row = TRUE, dis = NULL,
          method = "kullback", base = exp(5))
print("     simpson.D simpson.I simpson.R
1996 0.5534977 0.4465023  1.806692
1997 0.5674638 0.4325362  1.762227
1998 0.5886452 0.4113548  1.698816
1999 0.6150397 0.3849603  1.625911
2000 0.6392648 0.3607352  1.564297
2001 0.6622776 0.3377224  1.509941
2002 0.6767693 0.3232307  1.477608
2003 0.6838655 0.3161345  1.462276
2004 0.7149405 0.2850595  1.398718
2005 0.7160910 0.2839090  1.396471
2006 0.7245616 0.2754384  1.380145")

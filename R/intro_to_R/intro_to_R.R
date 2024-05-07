# MATH 4130K/6641 - Intro to R
#--------------------

# Help for a particular function
?mean
help(mean)
example(mean)

## scalars vs vectors
n	<-	10
x	<-  c(1,2,3,72) # This is a vector.  Created using the c() command.

n
x
x[3]
x[4]

# Matrices
A <- matrix(1:9, nrow=3, ncol=3)
A
A[1,1] # Element in row 1 column 1
A[2,] # Entire 2nd row
A[,3] # Entire 3rd column

# Loading a dataset called "VA" from the MASS package
# The dataset is: Veteran’s Administration lung cancer trial from Kalbfleisch & Prentice.
# If you don't have the package MASS, then install it using
# install.packages("MASS") 
library(MASS)
data("VA")

# Info about the data
help("VA")

# Print the first 6 rows of data
head(VA)

# Access particular variables in the dataset
VA$stime
VA$age

# Survival datasets usually have a "status" variable.  Usually
# 1 = event (e.g. death) and 0 = censored
VA$status
table(VA$status)

# For survival data, there is a special object in R called a "Surv" object
# At least two arguments are needed:
# 1. A "time" vector with survival or censoring times
# 2. A "status" vector specifying 1=event, 0=censored
library(survival)
s.obj <- Surv(VA$stime, VA$status)

# This object can be plotted using the plot() and survfit() functions.
# Set mark.tim=TRUE to put a mark for each censored observation.
plot(survfit(s.obj~1, data=VA), mark.time=TRUE,
     xlab="Days", ylab="Survival probability", col="darkred", lwd=1.5)

# By default, this plots a "Kaplan-Meier" estimate of the survival curve.
# We will learn more about this next time.


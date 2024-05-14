# Regression examples
# Using kidney data
data(cancer, package="survival")

# Exponential regression
library(survival)
exp.fit <- survreg(Surv(time,status) ~ age+sex+disease, data=kidney, 
                  dist = "exponential")
summary(exp.fit)

# Use "predict()" to get hazard ratio for a particular
# set of predictor variables
# Let's look at the hazard ratio for sex (2=female, 1=male)
x1 <- data.frame(age=30, sex=1, disease="GN", frail=2)
x2 <- data.frame(age=30, sex=2, disease="GN", frail=2)
pred1 <- predict(exp.fit, newdata = x1, type="response")
pred2 <- predict(exp.fit, newdata = x2, type="response")
pred2/pred1
# We can more easily caluclate hazard ratio for sex
# using the coefficient for sex:
exp(exp.fit$coefficients[3])

# Weibull regression
wr.fit <- survreg(Surv(time,status) ~ age+sex+disease, data=kidney, 
                  dist = "weibull")
summary(wr.fit)
# Hazard ratio for disease=GN vs. disease="Other"
exp(wr.fit$coefficients[4]) 

# Cox proportional hazards model
cph.fit <- coxph(Surv(time,status) ~ age+sex+disease, data=kidney)
summary(cph.fit)

#######################
##### Excercises ######
#######################
# Ex1: Estimate and interpret the hazard ratio for age in 
# all three regression models above.

# Ex2: In each of the three regression models above, estimate and
# interpret the hazard ratio between the following two individuals:
# Individual 1: 55 year-old male with disease "PKD"
# Individual 2: 25 year-old female with disease "Other"

# Ex3: Plot a curve of the estimated survival function in Weibull regression
# for a 55 year-old male with disease "PKD".
# Note: use the documentation for survreg
?survreg
# At the bottom, you will find the relationship between the
# "shape" and "scale" parameter in survreg, and the "shape"
# and "scale" parameter in pweibull().





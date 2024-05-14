# Plotting multiple survival curves and testing differences
# using the log-rank test.
 
library(MASS)
data("Melanoma")

# Merging "alive" and "died from other causes" categories
Melanoma$status <- ifelse(Melanoma$status %in% c(2,3), 0, 1)

# sex=0 is female, sex=1 is male
library(survival)
km.fit <- survfit(Surv(time, status)~sex, data=Melanoma)

plot(km.fit, mark.time=TRUE, lwd=2, col=c("orange","darkgreen"),
     xlab="Days", ylab="Survival probability",
     cex.lab=1.3, cex.axis=1.3)
legend("bottomleft", legend=c("Female","Male"), cex=0.8,
       col=c("orange","darkgreen"),
       lwd=2,
       lty=c(1,1))

# Log-rank test
survdiff(Surv(time, status)~sex, data=Melanoma)

#############################
# Recurrence times to infection in Kidney catheter data
library(survival)
data(cancer, package = "survival")

# The "kidney" dataset is one of many loaded when you load the "cancer" dataset
head(kidney)

# Let's plot 4 survival curves, one for each disease:
# GN, AN, PKD, Other (I'm not sure what these abbreviations stand for!)
fit <- survfit(Surv(time, status)~disease, data=kidney)

# Choosing colours for the 4 curves
cols <- rainbow(4)

plot(fit, mark.time=TRUE, lwd=2, col=cols,
     xlab="Days", ylab="Survival probability",
     cex.lab=1.3, cex.axis=1.3)
legend("topright", legend=levels(kidney$disease), cex=0.8,
       col=cols,
       lwd=2,
       lty=c(1,1,1,1))

# Log-rank test
survdiff(Surv(time, status)~disease, data=kidney)


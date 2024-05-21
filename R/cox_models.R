# More considerations in the Cox model
# Using kidney data
data(cancer, package="survival")
library(survival)

# Checking proportional hazards assumption using -log-log curve
# Check assumption for sex
# Create KM curves separately for sex
km <- survfit(Surv(time, status)~sex, data=kidney)
plot(km, fun="cloglog")

# Checking assumption for disease status
km.ds <- survfit(Surv(time, status)~disease, data=kidney)
plot(km.ds, fun="cloglog", col=rainbow(4))

# Cox proportional hazards model
cph.fit <- coxph(Surv(time,status) ~ age+sex+disease, data=kidney)
summary(cph.fit)

# Testing proportional hazards assumption
cz <- cox.zph(cph.fit)
cz

# Schoenfeld residual plot
plot(cz)

# Breslow estimator for survival
sf <- survfit(cph.fit)
plot(sf, xlab="Days", ylab="Proportion without infection", lwd=2, col="orangered")

# Stratified Cox model
scph.fit <- coxph(Surv(time,status) ~ age+disease+strata(sex), data=kidney)
summary(scph.fit)
cox.zph(scph.fit)

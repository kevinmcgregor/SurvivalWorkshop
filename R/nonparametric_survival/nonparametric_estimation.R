# Non-parametric estimation examples
# Kaplan-Meier and Nelson-Aalen

# Inputting 6-MP data (see Kaplan-Meier lecture)
t <- c(10, 7, 32, 23, 22, 6, 16, 34, 32, 25, 
       11, 20, 19, 6, 17, 35, 6, 13, 9, 6, 10)
delta <- c(1, 1, 0, 1, 1, 1, 1, 0, 0, 0,
           0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0)

# We can use the survfit() function to get the data in d_j, n_j format
# (i.e. event and number at risk format)
library(survival)
fit <- survfit(Surv(t, delta)~1)

# Extracting n_j and d_j
nj <- fit$n.risk
dj <- fit$n.event

# Kaplan-Meier
km <- cumprod(1-dj/nj)

# Estimating the variance
v.km <- km^2*cumsum(dj/(nj*(nj-dj)))

# Concatenating a 1 before the first event
km <- c(1, km)
# Event times
etimes <- c(0, fit$time)
v.km <- c(0, v.km)
  
# Plotting Kaplan-Meier curve
plot(etimes, km, type="s", ylim=c(0,1), xlab="Weeks", ylab="S(t)",
     col="red")
# Adding confidence intervals
lines(etimes, km-1.96*sqrt(v.km), type="s", lty=2, col="darkblue")
lines(etimes, km+1.96*sqrt(v.km), type="s", lty=2, col="darkblue")

# Alternative: plotting Kaplan-Meier using the built-in function
# (Note: this function constructs intervals in a slightly different way)
plot(fit)

########################
# Nelson-Aalen estimator of cumulative hazard
na <- cumsum(dj/nj)

# Estimating variance
v.na <- cumsum((nj-dj)*dj/((nj-1)*nj^2))

# Concatenating a 0
na <- c(0, na)
v.na <- c(0, v.na)

# Plotting Nelson-Aalen estimate of cumulative hazard
plot(etimes, na, type="s", ylim=c(0,1.5), xlab="Weeks", ylab="Cumualtive hazard",
     col="darkorange")
# Plotting confidence intervals
lines(etimes, na-1.96*sqrt(v.na), type="s", lty=2, col="firebrick")
lines(etimes, na+1.96*sqrt(v.na), type="s", lty=2, col="firebrick")



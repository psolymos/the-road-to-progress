load("example.RData")

# Pick a species
spp <- "Ovenbird"

# Copy the data
x1 <- X
# Add species 0/1 to column y
x1$y <- ifelse(Y[,spp] > 0, 1, 0)
# Count the number of 0s and 1s at the stations
tmp <- with(x1[x1$ToY >= 150, ], table(pkey, y))
# Take the subset with 1s
tmp <- tmp[tmp[,"1"] > 0,]
# Add indicator for species occurrence over the visits
x1$occ <- x1$pkey %in% rownames(tmp)

# Fit GAM model, condition on occurrence at the station, Morning only
m <- mgcv::gam(y ~ s(ToY), x1[x1$ToDc == "Morning" & x1$occ,], family=binomial)

# Predict prob given time of year
ToY <- seq(min(X$ToY), max(X$ToY), 1)
p <- predict(m, newdata=data.frame(ToY=ToY), type="response")
plot(p ~ ToY, type="l")

load("example.RData")

# All the species, exclude rare ones for now
s <- colSums(Y[X$ToY >= 150, ] > 0)
SPP <- colnames(Y)[s >= 100]

# placeholder for results
ToY <- seq(min(X$ToY), max(X$ToY), 1)
P <- matrix(0, length(ToY), length(SPP))
colnames(P) <- SPP

# Pick a species
#spp <- "Ovenbird"
fun <- function(spp) {

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
p <- predict(m, newdata=data.frame(ToY=ToY), type="response")
return(p)
}

Plist <- lapply(SPP, fun)
P <- do.call(cbind, Plist)

matplot(ToY, P, type="l", ylim=c(0,1), lty=1, col="#00000044")

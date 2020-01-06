library(mefa4)

#' Read in ABMI SM bird data from the QPAD workshop
tmp <- tempdir()
uri <- "https://github.com/psolymos/qpad-book/raw/master/_data/abmi/abmi.rda"
download.file(uri, file.path(tmp, "abmi.rda"))
load(file.path(tmp, "abmi.rda"))
#' Make survey x species table based on 1st 1-min:
#' exclude counts from >1min but don't drop visit labels
Y <- as.matrix(Xtab(~ visit + SpeciesID,
  data=abmi[is.na(abmi$det1) | abmi$det1 == "0-1min",],
  cdrop=c("NONE","SNI", "VNA", "DNC", "PNA")))
X <- droplevels(nonDuplicated(abmi, visit, TRUE)[rownames(y1),
  c("pkey", "visit", "ToY", "ToYc", "ToD", "ToDx", "ToDc")])

save(X, Y, file = "example.RData")

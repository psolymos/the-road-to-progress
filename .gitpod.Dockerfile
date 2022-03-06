FROM rocker/r-ver:4.1.2
RUN R -e 'install.packages(c("pbapply", "mgcv"))'

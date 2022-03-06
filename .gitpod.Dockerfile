FROM rocker/r-ver:4.1.2
RUN R -e 'install.packages(c("languageserver", "httpgd"))'
RUN R -e 'install.packages(c("pbapply", "mgcv"))'

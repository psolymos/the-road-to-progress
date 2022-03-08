FROM rocker/r-ver:4.1.2
RUN apt-get update -y
RUN apt-get install -y libxml2-dev
RUN R -e 'install.packages(c("languageserver", "httpgd"))'
RUN R -e 'install.packages(c("pbapply", "mgcv"))'

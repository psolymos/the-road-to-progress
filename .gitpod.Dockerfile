FROM gitpod/workspace-full
USER gitpod
RUN brew install R
RUN R -q -e "install.packages(c('pbapply', 'mgcv'))"

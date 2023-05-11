FROM eddelbuettel/r2u:jammy
RUN apt-get update && apt-get install -y git
RUN install.r languageserver httpgd pbapply mgcv

#----------------------------------------------------------------#
# Dockerfile to build a container for binary reverse engineering #
# and exploitation. Suitable for CTFs.                           #
#                                                                #
# See https://github.com/superkojiman/pwnbox for details.        #
#                                                                #
# To build: docker build -t superkojiman/pwnbox                  #
#----------------------------------------------------------------#

FROM ubuntu:18.04
MAINTAINER superkojiman@techorganic.com

ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

COPY install.sh /

RUN bash /install.sh

ENTRYPOINT ["/bin/bash"]

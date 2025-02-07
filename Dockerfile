FROM ubuntu:noble as base
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y locales build-essential git curl sudo ansible

# set locale
RUN locale-gen en_US en_US.UTF-8 && \
    dpkg-reconfigure locales 

# add sudo user with no password
RUN useradd -ms /bin/bash joey && \
    usermod -aG sudo joey
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER joey
WORKDIR /home/joey

# run ansible install script
COPY --chown=joey:joey . /home/joey/dotfiles/

ENV TERM=screen-256color
RUN ./dotfiles/ansible/install internal-container

# start container in zsh
ENTRYPOINT ["/bin/zsh"]

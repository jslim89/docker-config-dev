FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

ARG UID
ARG GID
ARG USER
ARG GROUP

USER root

RUN apt update -y
RUN apt install -y texlive-latex-extra
RUN apt install -y vim
RUN apt clean

RUN groupadd -g ${GID} ${GROUP} || true
RUN useradd -u ${UID} -g ${GROUP} -s /bin/sh -m ${USER}

RUN mkdir /files
RUN chown ${UID}:${GID} /files

USER ${UID}:${GID}

WORKDIR /files


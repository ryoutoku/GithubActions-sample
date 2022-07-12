# syntax=docker/dockerfile:1


###############################################
# set code
###############################################
FROM python:3.10.5-slim-buster as build_base


###############################################
# install modules for development
###############################################
FROM build_base as build_development

###############################################
# install modules for development
###############################################
FROM build_base as build_production


###############################################
# set environment base
###############################################
FROM python:3.10.5-slim-buster as environment_base

ENV PYTHONUNBUFFERED=1 \
    USER=django \
    WORKDIR=/app

# for security
RUN rm -rf /tmp && \
    chmod u-s /usr/bin/passwd && \
    chmod g-s /usr/bin/wall && \
    chmod u-s /usr/bin/chfn && \
    chmod u-s /usr/bin/gpasswd && \
    chmod u-s /usr/bin/chsh && \
    chmod u-s /bin/mount && \
    chmod u-s /bin/su && \
    chmod u-s /usr/bin/newgrp && \
    chmod g-s /usr/bin/expiry && \
    chmod g-s /usr/bin/chage && \
    chmod g-s /sbin/unix_chkpwd && \
    chmod u-s /bin/umount

RUN useradd -d /home/${USER} -m -s /bin/bash ${USER}
USER ${USER}

WORKDIR ${WORKDIR}


###############################################
# set environment for development
###############################################
FROM environment_base as development


###############################################
# set environment for production
###############################################
FROM environment_base as production
FROM ubuntu:trusty

RUN apt-get update -y && \
    apt-get install -y \
      wget \
      python

RUN wget -O bootstrap.py https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py && python bootstrap.py --no-interactive --application-choice=browser

# If you want to bust the cache, change the value below. Doing it here
# allows you still cache the above commands, but re-download and compile
# Firefox.
# RUN echo "cache-bust1"

ADD update-mc /
RUN  /update-mc
WORKDIR firefox

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

RUN hg clone https://hg.mozilla.org/mozilla-central/ firefox
WORKDIR firefox

RUN echo 'mk_add_options MOZ_MAKE_FLAGS="-s -j4"' > .mozconfig

RUN SHELL=/bin/bash ./mach build

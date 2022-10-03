FROM python:alpine

RUN apk update && apk upgrade                   # update system
RUN apk add --no-cache bash gawk sed grep bc    # install bash
RUN apk add --no-cache coreutils mediainfo nano openssh git ncurses # install tools
# install Python packages
RUN apk add --no-cache python3 py3-pip gcc musl-dev python3-dev libffi-dev openssl-dev cargo
RUN pip install --no-cache-dir -U wheel yt-dlp requests selenium beautifulsoup4 image pillow
# Install YT-DLP & VidHop dependencies
RUN apk add --no-cache ffmpeg jq
# RUN apk add moreutils && \

# Force docker build to recopy.
RUN rm -rf /vidhop
RUN rm -rf /opt/vidhop

RUN mkdir /vidhop  # media dir
RUN mkdir /opt/vidhop   # app dir

COPY vidhop/.bashrc /root/.bashrc
ADD vidhop /opt/vidhop
#RUN git clone https://github.com/wtechgo/vidhop-linux.git /opt/vidhop

# Install loader, enables `. vidhop`
RUN touch /usr/local/bin/vidhop && \
  echo '#!/bin/bash' >/usr/local/bin/vidhop && echo >>/usr/local/bin/vidhop && \
  echo ". /opt/vidhop/bin/loader" >>/usr/local/bin/vidhop && \
  chmod +x /usr/local/bin/vidhop

WORKDIR /vidhop

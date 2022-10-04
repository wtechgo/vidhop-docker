FROM python:alpine

RUN apk update && apk upgrade   # update system
RUN apk add --no-cache  coreutils util-linux binutils findutils grep iproute2   # replace BusyBox symlinks
RUN apk add --no-cache bash bash-doc bash-completion gawk sed grep bc    # install bash
RUN apk add --no-cache mediainfo nano openssh rsync git ncurses tor proxychains-ng # install tools   # install vidhop requirements
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
ADD vidhop/.bash_history /root/.bash_history
#RUN git clone https://github.com/wtechgo/vidhop-linux.git /opt/vidhop

# Install loader, enables `. vidhop`
RUN touch /usr/local/bin/vidhop && \
  echo '#!/bin/bash' >/usr/local/bin/vidhop && echo >>/usr/local/bin/vidhop && \
  echo ". /opt/vidhop/bin/loader" >>/usr/local/bin/vidhop && \
  chmod +x /usr/local/bin/vidhop

# Configure bash.
SHELL ["/bin/bash", "-ec"]
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
ENV HISTSIZE=500
ENV HISTFILESIZE=500
ENV HISTFILE=$HOME/.bash_history
RUN set -o history

WORKDIR /vidhop

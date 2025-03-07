FROM python:alpine

RUN apk update && apk upgrade                                                                        # update system
RUN apk add --no-cache coreutils util-linux binutils findutils grep iproute2                         # replace BusyBox symlinks
RUN apk add --no-cache bash bash-doc bash-completion gawk sed grep bc                                # install bash
RUN apk add --no-cache mediainfo nano openssh rsync git ncurses                                      # install vidhop requirements
RUN apk add --no-cache python3 py3-pip gcc musl-dev python3-dev libffi-dev openssl-dev cargo         # install python system packages
RUN apk add --no-cache ffmpeg                                                                        # required for yt-dlp
RUN apk add --no-cache jq                                                                            # JSON processing
RUN apk add --no-cache imagemagick tesseract-ocr                                                     # image processing
RUN apk add --no-cache tor proxychains-ng                                                            # deal with censored content
# install Python packages
RUN pip install --no-cache-dir -U wheel yt-dlp
#RUN pip install --no-cache-dir -U wheel yt-dlp requests selenium beautifulsoup4 image pillow

# RUN pip install --no-cache-dir -U facebook-scraper snscrape
# RUN apk add moreutils # adds ifdata command for network interface inspection

# Force docker build to recopy.
RUN rm -rf /vidhop
RUN rm -rf /opt/vidhop
RUN mkdir /vidhop  # media dir
RUN mkdir /opt/vidhop   # app dir

COPY vidhop/config/.bashrc /root/.bashrc
ADD vidhop /opt/vidhop
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
ENV HISTFILE=/root/.bash_history
RUN touch /root/.bash_history && set -o history

WORKDIR /vidhop

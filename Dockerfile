FROM frolvlad/alpine-bash:latest

COPY vidhop/.bashrc /root/.bashrc

RUN mkdir /root/VidHop
RUN mkdir /opt/vidhop
ADD vidhop /opt/vidhop

RUN apk update && \
    apk upgrade && \
    apk add ncurses

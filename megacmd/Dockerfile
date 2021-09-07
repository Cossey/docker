FROM debian:buster
ARG TARGETPLATFORM

LABEL maintainer="stewart.cossey@gmail.com"

RUN apt-get update && \
    apt-get install curl gnupg2 -y && \
    echo path-include /usr/share/doc/megacmd/* > /etc/dpkg/dpkg.cfg.d/docker

ADD mc.sh /

RUN bash -c "/mc.sh $TARGETPLATFORM" && \
    apt install ./megacmd.deb -y && \
    rm -rf ./megacmd.deb && \
    rm -rf ./mc.sh && \
    apt-get remove -y curl && \
    apt-get clean

COPY *.sh /

ENTRYPOINT bash ./entrypoint.sh
CMD /bin/bash
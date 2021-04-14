FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

EXPOSE 3702/udp 5357

RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add python3 && \
    rm -rf /tmp/*

ADD wsdd.py /
ADD start.sh /

RUN chmod +x ./start.sh

ENTRYPOINT [ "./start.sh" ]
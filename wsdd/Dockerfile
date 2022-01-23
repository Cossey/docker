FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

EXPOSE 3702/udp 5357

RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add python3 bash && \
    rm -rf /tmp/*

ADD /wsdd/wsdd.py /
ADD /wsdd/start.sh /

RUN chmod +x ./start.sh

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=1 \
  CMD pgrep -f wsdd.py

ENTRYPOINT [ "./start.sh" ]

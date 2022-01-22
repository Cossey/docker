FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk add --no-cache bash wget

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD /bin/bash /healthcheck.sh

COPY ./library.sh /
COPY duckdns/duckdns.sh /
COPY duckdns/healthcheck.sh /

CMD /bin/bash /duckdns.sh
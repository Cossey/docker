ARG VER
FROM alpine:${VER}

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk add --no-cache bash wget

COPY duckdns.sh /duckdns.sh

CMD /bin/bash /duckdns.sh
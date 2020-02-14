FROM alpine:latest

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk add --no-cache bash curl

COPY update.sh /update.sh

CMD /bin/bash /update.sh
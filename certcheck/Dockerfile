FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk add --no-cache bash curl openssl

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD /bin/bash /healthcheck.sh

COPY ./library.sh /
COPY certcheck/cclib.sh /
COPY certcheck/check-certs.sh /
COPY certcheck/healthcheck.sh /

CMD /bin/bash /check-certs.sh
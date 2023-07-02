FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk add --no-cache bash tar

COPY /library.sh /
COPY /filebackup/*.sh /

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=1 CMD /bin/bash healthcheck.sh

CMD /bin/bash backup.sh
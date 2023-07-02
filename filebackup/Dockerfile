FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk add --no-cache bash tar

COPY /filebackup/*.sh /
COPY /library.sh /

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=1 CMD /bin/bash healthcheck.sh

CMD /bin/bash backup.sh
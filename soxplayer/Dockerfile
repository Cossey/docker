FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"

RUN apk update \
    && apk add --no-cache sox nodejs npm

WORKDIR /app
COPY ./soxplayer/*.js ./
COPY ./soxplayer/package*.json ./

RUN npm i

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=1 \
    CMD node healthcheck.js
    
CMD [ "node", "program.js" ]
FROM debian:buster
ARG TARGETPLATFORM
ARG PSVER
LABEL maintainer="stewart.cossey@gmail.com"

RUN apt-get update \
    && apt-get install --no-install-recommends -y libunwind8 libicu63 libcurl4-openssl-dev cron wget ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

ADD ps.sh /
RUN bash -c "/ps.sh $PSVER $TARGETPLATFORM"

RUN rm -f ps.sh
FROM mono:latest as builder
ARG CVER

LABEL maintainer="stewart.cossey@gmail.com"

RUN apt-get update && apt-get install -y git wget

WORKDIR /usr/local/src
RUN git clone https://github.com/chocolatey/choco.git --depth 1 -b $CVER 

WORKDIR /usr/local/src/choco
RUN chmod +x build.sh && chmod +x zip.sh && ./build.sh

WORKDIR /var/crt
RUN wget https://certs.godaddy.com/repository/gd_bundle-g2.crt

FROM mono:slim
COPY --from=builder /usr/local/src/choco/build_output/chocolatey /opt/chocolatey
COPY --from=builder /var/crt/gd_bundle-g2.crt /gd_bundle-g2.crt

RUN apt-get update \
    && apt-get install -y libmono-microsoft-csharp4.0-cil libmono-system-componentmodel-dataannotations4.0-cil libmono-system-xml-linq4.0-cil libmono-windowsbase4.0-cil \
    && cert-sync --user /gd_bundle-g2.crt \
    && apt-get -q -y autoremove \
    && apt-get -q -y clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
RUN ln -s /opt/chocolatey

COPY choco.sh /usr/local/bin/choco

WORKDIR /root
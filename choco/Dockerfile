FROM mono:latest as builder

LABEL maintainer="stewart.cossey@gmail.com"

RUN apt-get update && apt-get install -y git

WORKDIR /usr/local/src
RUN git clone https://github.com/TheCakeIsNaOH/choco.git -b MonoFixV2

WORKDIR /usr/local/src/choco
RUN chmod +x build.sh && chmod +x zip.sh && ./build.sh

FROM mono:slim
COPY --from=builder /usr/local/src/choco/build_output/chocolatey /opt/chocolatey

RUN apt-get update \
    && apt-get install -y libmono-microsoft-csharp4.0-cil libmono-system-componentmodel-dataannotations4.0-cil libmono-system-xml-linq4.0-cil libmono-windowsbase4.0-cil \
    && apt-get -q -y autoremove \
    && apt-get -q -y clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
RUN ln -s /opt/chocolatey

COPY choco.sh /usr/local/bin/choco

WORKDIR /root
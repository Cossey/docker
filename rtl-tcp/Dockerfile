FROM alpine

LABEL maintainer="stewart.cossey@gmail.com"
EXPOSE 1234
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD pgrep -f rtl_tcp

RUN apk add --no-cache bash rtl-sdr

RUN echo 'blacklist dvb_usb_rtl28xxu' > /etc/modprobe.d/dvb_usb_rtl28xxu.conf

ADD /library.sh /
ADD /rtl-tcp/rtl-tcp.sh /

ENTRYPOINT ["/rtl-tcp.sh"]

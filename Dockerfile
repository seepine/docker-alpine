FROM alpine:3.18

LABEL maintainer="seepine <seepine@outlook.com>"

ENV NTP_SERVER=pool.ntp.org

RUN echo "ntpd -d -q -n -p \$NTP_SERVER" > /usr/local/bin/ntp.sh \
  && chmod +x /usr/local/bin/ntp.sh \
  && echo "*/30 * * * * ntp.sh" >> /etc/crontabs/root \
  && apk add --no-cache tzdata \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && apk del tzdata

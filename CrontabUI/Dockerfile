FROM alpine

ENV   CRON_PATH /etc/crontabs

RUN   mkdir /scripts; touch $CRON_PATH/root; chmod +x $CRON_PATH/root

WORKDIR /scripts

RUN   apk --no-cache add wget curl git nodejs npm python3 py3-pip supervisor jq tzdata moreutils \
      && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
      && echo "Asia/Shanghai" > /etc/timezone

RUN   git clone https://github.com/alseambusher/crontab-ui.git /crontab-ui \
      && cp /crontab-ui/supervisord.conf /etc/supervisord.conf \
      && cd /crontab-ui \
      && npm install

ENV   HOST 0.0.0.0
ENV   PORT 8000
ENV   CRON_IN_DOCKER true

EXPOSE $PORT

CMD ["supervisord", "-c", "/etc/supervisord.conf"]

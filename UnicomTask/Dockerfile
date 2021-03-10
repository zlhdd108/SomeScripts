FROM alpine
LABEL VERSION=1.0

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache python3 py3-pip tzdata moreutils git curl jq\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone


RUN mkdir /logs \
        && mkdir /scripts \
        && git clone https://github.com/srcrs/UnicomTask.git /unicomtask \
        && pip3 install -r requirements.txt \
        && cp /unicomtask/*.py /scripts \
        && cp /unicomtask/requirements.txt /scripts

COPY ./UnicomTask/crontab_list.sh /scripts
COPY ./UnicomTask/update.sh /usr/local/bin

RUN chmod +x /usr/local/bin/update.sh

WORKDIR /scripts

RUN crontab /scripts/crontab_list.sh

CMD [ "crond" ]
FROM alpine
LABEL VERSION=1.0

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache python3 py3-pip tzdata moreutils git curl jq\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /logs \
        && mkdir /UnicomTask \
        && cd  /UnicomTask \
        && git init \
        && git remote add -f origin https://github.com/srcrs/UnicomTask.git \
        && git config core.sparsecheckout true \
        && echo login.py >> .git/info/sparse-checkout \
        && echo main.py >> .git/info/sparse-checkout \
        && echo notify.py >> .git/info/sparse-checkout \
        && echo requirements.txt >> .git/info/sparse-checkout \
        && git pull origin main \
        && pip3 install --upgrade pip \
        && pip3 install -r requirements.txt
COPY ./UnicomTask/crontab_list.sh /UnicomTask
COPY ./UnicomTask/update.sh /usr/local/bin

RUN chmod +x /usr/local/bin/update.sh

WORKDIR /UnicomTask

RUN crontab /UnicomTask/crontab_list.sh

CMD [ "crond" ]
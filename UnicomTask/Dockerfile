FROM alpine
LABEL VERSION=1.0

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache python3 py3-pip tzdata moreutils git curl jq\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /logs \
        && mkdir /unicomtask \
        && cd  /unicomtask \
        && git init \
        && git remote add -f origin https://github.com/srcrs/UnicomTask.git \
        && git config core.sparsecheckout true \
        && echo login.py >> /unicomtask/.git/info/sparse-checkout \
        && echo main.py >> /unicomtask/.git/info/sparse-checkout \
        && echo notify.py >> /unicomtask/.git/info/sparse-checkout \
        && echo requirements.txt >> /unicomtask/.git/info/sparse-checkout \
        && git pull origin main --rebase \
        && pip3 install --upgrade pip \
        && pip3 install -r requirements.txt

COPY ./UnicomTask/crontab_list.sh /unicomtask
COPY ./UnicomTask/update.sh /usr/local/bin

RUN chmod +x /usr/local/bin/update.sh

WORKDIR /unicomtask

RUN crontab /unicomtask/crontab_list.sh

CMD [ "crond" ]
FROM alpine
LABEL VERSION=1.4

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache python3 py3-pip tzdata moreutils git curl jq\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN pip3 install --upgrade pip \
        && pip3 install telethon

# 配置镜像仓库配置相关文件夹
# 创建工作目录
RUN mkdir /logs \
        && mkdir /telethon \
        && mkdir /pss \
        && cd  /pss \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo Telethon/* >> /pss/.git/info/sparse-checkout \
        && git pull origin master \
        && cp /pss/Telethon/crontab_list.sh /pss/crontab_list.sh
        
# Github Action 构建
COPY ./Telethon/docker_entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker_entrypoint.sh \
        &&  crontab /pss/crontab_list.sh

WORKDIR /telethon

#镜像构建版本,每次调整构建文件更新
ENV BUILD_VERSION=1.4 \
        DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append

ENTRYPOINT ["docker_entrypoint.sh"]
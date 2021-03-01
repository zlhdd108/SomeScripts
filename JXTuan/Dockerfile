FROM alpine
LABEL VERSION=1.2

RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache tzdata moreutils git nodejs npm curl jq\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

# 配置镜像仓库配置相关文件夹
# 创建工作目录
RUN mkdir /logs \
        && mkdir /pss \
        && mkdir /scripts \
        && cd  /pss \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo JXTuan/* >> /pss/.git/info/sparse-checkout \
        && git pull origin master \
        && cp /pss/JXTuan/crontab_list.sh /pss/crontab_list.sh \
        && cp -f /pss/JXTuan/scripts/* /scripts \
        && cd /scripts \
        && npm install \
        && npm install qiniu

# Github Action 构建
COPY ./JXTuan/docker_entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker_entrypoint.sh \
        &&  crontab /pss/crontab_list.sh

#镜像构建版本,每次调整构建文件更新
ENV BUILD_VERSION=1.2 \
        DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append 

ENTRYPOINT ["docker_entrypoint.sh"]

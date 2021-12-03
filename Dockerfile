FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.12

# set version label
ARG HEIMDALL_RELEASE
LABEL build_version="ican1983 version:- v1.4.3_zh Build-date:- 2021-09-22 14:27"
LABEL maintainer="ican1983"

# environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache --upgrade \
	curl \
	php7-ctype \
	php7-curl \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-pdo_mysql \
	php7-tokenizer \
	php7-zip \
	tar && \
 echo "**** install heimdall ****" && \
 mkdir -p \
	/heimdall && \
 if [ -z ${HEIMDALL_RELEASE+x} ]; then \
	HEIMDALL_RELEASE=$(curl -sX GET "https://api.github.com/repos/ican1983/heimdall-plus/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 /heimdall/heimdall.tar.gz -L \
	"https://github.com/ican1983/heimdall-plus/archive/${HEIMDALL_RELEASE}.tar.gz" && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /
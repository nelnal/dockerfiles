FROM node:10.17.0-apline3.10

WORKDIR /srv
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

ARG ACCESS_PORT=10000
ARG DEST_NAME="test"
ARG DEST_HOST="localhost"
ARG DEST_PORT="1234"

COPY certs.pem /etc/stunnel/certs.pem
COPY key.pem /etc/stunnel/key.pem

RUN     : \
    &&  apk update \
    &&  apk add --no-cache stunnel libressl \
    # ennvar DEST_NAME, DEST_HOST, DEST_PORT が変更されていることを確認する
    &&  test "${DEST_NAME}" != "test" \
    &&  test "${DEST_HOST}:${DEST_PORT}" != "localhost" \
    # stunnel.conf ファイルを作成する
    &&  { \
          echo    "foreground = yes"; \
          echo    "debug = 7"; \
          echo    ""; \
          echo    "output = /var/log/stunnel.log"; \
          echo    "pid = /var/run/stunnel/stunnel.pid"; \
          echo    ""; \
          echo    "setuid = stunnel"; \
          echo    "setgid = stunnel"; \
          echo    "socket = l:TCP_NODELAY=1"; \
          echo    "socket = r:TCP_NODELAY=1"; \
          echo    ""; \
          echo -e "[${DEST_NAME:?}]"; \
          echo    "sslVersion = all"; \
          echo    "client = yes"; \
          echo    "delay = yes"; \
          echo -e "accept = ${ACCESS_PORT:?}"; \
          echo -e "connect = ${DEST_HOST:?}:${DEST_PORT:?}"; \
          echo    "verifyPeer = no"; \
          echo    "CApath = /etc/stunnel"; \
          echo    "cert = /etc/stunnel/certs.pem"; \
          echo    "key = /etc/stunnel/key.pem"; \
        } | tee /etc/stunnel/stunnel.conf \
    &&  chmod 600 /etc/stunnel/certs.pem \
    &&  chmod 600 /etc/stunnel/key.pem \
    &&  chown -R stunnel:stunnel /etc/stunnel/certs.pem \
    &&  chown -R stunnel:stunnel /etc/stunnel/key.pem \
    # ログライルの準備
    &&  touch /var/log/stunnel.log \
    &&  chown -R stunnel:stunnel /var/log/stunnel.log \
    # pid ファイルの配置場所の準備
    &&  touch /var/run/stunnel \
    &&  chown -R stunnel:stunnel /var/run/stunnel \
    &&  { \
          echo    "#!/bin/ash"; \
          echo    ""; \
          echo    "exec stunnel"; \
        } | tee /srv/launcher.sh
    &&  chmod +x /srv/launcher.sh \
    &&  :

CMD ["/srv/launcher.sh"]

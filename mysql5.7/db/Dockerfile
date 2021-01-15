FROM golang:1.12-stretch as builder

ENV   GOPATH=/go \
      GO11MODULE=on

RUN   : \
  &&  apt-get -y update \
  &&  go get -u github.com/k0kubun/sqldef \
  &&  :

WORKDIR /go/src/github.com/k0kubun/sqldef

RUN   : \
  &&  make \
  &&  :

## 2nd stage
FROM mysql:5.7

COPY --from=builder /go/bin/mysqldef /usr/local/bin

EXPOSE 3306

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci"]


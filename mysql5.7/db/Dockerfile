FROM golang:1.12-stretch as builder

RUN : \
    &&  apt -y update \
    &&  go get -u github.com/k0kubun/sqldef \
    &&  cd /go/src/github.com/k0kubun/sqldef \
    &&  make \
    &&  :

## 2nd stage
FROM mysql:5.7

COPY --from=builder /go/bin/mysqldef /usr/local/bin

EXPOSE 3306

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci"]


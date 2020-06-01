# stunnel 用の dockerfile

## 事前準備

### PKCS12 ファイルから証明書と秘密鍵を作成する

stunnel を使って SSL 通信を行う為に「CA 証明書」、「クライアント証明書」、「秘密鍵」が必要となります。
３つのデータを通信相手から提供してもらった場合は以下の手順で各設定ファイルを作成します。

```bash
# PKCS12 ファイルから CA 証明書を抜粋
$ openssl pkcs12 -in (p12 file) -cacerts -nokeys -out ca.pem

# PKCS12 ファイルからクライアント証明書を抜粋
$ openssl pkcs12 -in (p12 file) -clcerts -nokeys -out certs.pem

# PKCS12 ファイルから秘密鍵を抜粋
$ openssl pkcs12 -in (p12 file) -nocerts -nodes -out keys.pem
```

### 証明書の確認

```bash
$ keytool -list -v keystore (p12 file) -storetype PKCS12 -storepass foobar
```

## Dockerfile の使い方

### 事前準備

ビルド前にこのディレクトリに以下のファイルを配置する。

- `ca.pem`
- `certs.pem`
- `keys.pem`

### ビルド

```bash
$ docker build --build-arg ACCESS_PORT=10000 --build-arg DEST_NAME=customer --build-arg DEST_HOST=api.customer.com --build-arg DEST_PORT=1234 .
```

### 起動

```bash
$ docker run -d --rm --name test-server -v ${exec_dir}:/srv/app (docker image)
$ docker exec -it test-server sh -c 'cd xxx && (exec app)' 
```

### 注意

stunnel は外部とやりとりする実行プログラムと同じホストで動作することを想定しています。
別のサーバで動かさないように。


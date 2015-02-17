# nginx-confd

This docker is usefull for using nginx with confd.
For examples please look at [How To Use Confd and Etcd to Dynamically Reconfigure Services in CoreOS](https://www.digitalocean.com/community/tutorials/how-to-use-confd-and-etcd-to-dynamically-reconfigure-services-in-coreos)

## Build image

```bash
docker build -t jacekmarchwicki/nginx-confd .
```

If building fail you can debug via where `1b372b1f76f2` is partial build

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

## Push build version to repository

```bash
docker push jacekmarchwicki/nginx-confd
```

## Usage
Configure your `etcdctl`:

```bash
etcdctl mkdir /services/web/www/
etcdctl mkdir /services/web/www/servers/
etcdctl set /services/web/www/root 'www.example.com'
etcdctl set /services/web/www/servers/1 '{"ip": "10.0.0.3", "port": "80"}'
etcdctl set /services/web/www/servers/2 '{"ip": "10.0.0.4", "port": "80"}'

etcdctl mkdir /services/web/test/
etcdctl mkdir /services/web/test/servers/
etcdctl set /services/web/test/root 'test.example.com'
etcdctl set /services/web/test/servers/1 '{"ip": "10.0.0.1", "port": "80"}'
etcdctl set /services/web/test/servers/2 '{"ip": "10.0.0.2", "port": "80"}'
```

Change directory to your project directory, than run:

```bash
docker run \
  --name=nginx \
  --publish 80:80 \
  --publish 443:443 \
  jacekmarchwicki/nginx-confd
```


# docker-seafile

[Seafile](http://www.seafile.com/en/home/) server version 2.1.5

__This will require some interactive setup.__ Also, this launches the Seahub
web interface as a FastCGI process. You'll need a proxy setup, I've tested
this with my own [jprjr/debian-nginx](https://github.com/jprjr/docker-debian-nginx)
image.

`/srv/seafile` is exposed as a volume, you'll absolutely need to bind a volume.

## Known Issues

### WebDAV

This image does not support WebDAV. It seems like the guys over at Seafile
are distributing WsgiDAV with a custom backend for Seafile with the 
pre-compiled download of Seafile. I can't find any of that code in their
Github repos. I've opened [an issue](https://github.com/haiwen/seafile/issues/565) 
on this.

## Usage

### Build

```
$ docker build -t <repo name> .
```

### Initial (interactive setup)

```
# This downloads the Seahub web interface
$ docker run -v /path/to/data:/srv/seafile --entrypoint /opt/scripts/seahub_setup.sh jprjr/seafile
# This does an interactive setup
$ docker run -t -i -v /path/to/data:/srv/seafile --entrypoint /opt/scripts/seafile_setup.sh jprjr/seafile
# Afterwards, you'll probably want to explore /path/to/data and change configuration settings.
# Most importantly the server addresses for your particular proxy and whatnot.
```


### Run in foreground
```
$ docker run -p 8000 -p 8082 -v /path/to/data:/srv/seafile jprjr/seafile
```

### Run in background

```
$ docker run -d -p 8000 -p 8082 -v /path/to/data:/srv/seafile jprjr/seafile
```

## Versions

* Seafile 2.1.5

## Exposed ports

* 8000
* 8082

## Exposed volumes

* `/srv/seafile`

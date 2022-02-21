# GuGuProxy
Google反向代理

Fork from https://github.com/bohanyang/onemirror


## Usage

`docker run -p 80:80 taoskycn/guguproxy:v0.1`


## Tips
使用前置反代，需要转发host，否则无法正确重定向导致首页、设置等页面无法打开。

**Caddy1**
```
    proxy / http://127.0.0.1:xxxxx {
        header_upstream Host {host}
        header_upstream X-Real-IP {remote}
        header_upstream X-Forwarded-For {remote}
        header_upstream X-Forwarded-Proto {scheme}
    }
}
```
**Caddy2**
```
 reverse_proxy / http://127.0.0.1:xxxxx {
    header_up Host {http.request.remote.host}
    header_up X-Real-IP {http.request.remote.host}
    header_up X-Forwarded-For {http.request.remote.host}
    header_up X-Forwarded-Port {http.request.port}
    header_up X-Forwarded-Proto {http.request.scheme}
 }
```


## Update Logs

#### 2022-01-26
- 自动添加upstream到nginx配置

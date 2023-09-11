
# alpine Images

> 所有镜像基于 `UTC8 Asia/Shanghai` 时区，而非默认的 `UTC`

## As base image

### Dockerfile
```dockerfile
FROM seepine/alpine:17-jre
# Or
From seepine/alpine:glibc
```

### Options

- seepine/alpine
- seepine/alpine:wait
- seepine/alpine:glibc
- seepine/alpine:8-jre
- seepine/alpine:11-jre
- seepine/alpine:17-jre
- seepine/alpine:node

## Ntp

```dockerfile
FROM seepine/alpine:17-jre

# 自定义 npt 服务地址
#   会在执行同步命令 'ntpd -d -q -n -p $NTP_SERVER' 时使用, 
#   NTP_SERVER 默认值为 pool.ntp.org
# ENV NTP_SERVER=ntp.aliyun.com

# 如果需要的话，可以自定义时区
RUN apk add --no-cache tzdata \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

# 你的启动命令，crond表示启动定时器，会同步ntp，后方为真正执行的命令
ENTRYPOINT crond && java -jar demo.jar
```

## WaitForIt

```dockerfile
FROM seepine/alpine:17-jre

# 指定等待ip:port服务
ENV WAIT_FOR=192.168.100.100:3306
# 也支持多个，通过逗号隔开
ENV WAIT_FOR=192.168.100.100:3306,192.168.100.100:6379

# 增加wait.sh，会在wait阻塞，直至等待的服务都启动完毕
ENTRYPOINT crond && wait.sh && java -jar demo.jar
```

## Dockerfile 说明
本 Dockerfile 对应的镜像为: https://hub.docker.com/r/bbxytl/alpine-vim

## 文件说明:
- Dockerfile.simple: 基本功能的 vim , c 系列自带补全效果没有安装 ycm
- Dockerfile.complex-ycm: 装有 YouCompleteMe 自动补全插件的 vim
- Dockerfile: 等同于 Dockerfile.complex-ycm

## 镜像说明
镜像使用的dockerfile为:
https://github.com/bbxytldocker/alpine-vim

本 镜像 包含三个 tags: simple/complex/latest, 其中
- simple : 基本的 vim 配置和一些常用便捷插件;
- complex : 基于 YouCompleteMe 为补全插件的 vim 配置;
- latest: 即为 complex

配置仓库为: https://github.com/bbxytl/b-dotfiles

## 镜像使用
### 1. 从容器启动
```
docker run docker run -it --name my-vim -v ~/data:/home/developer/data bbxytl/alpine-vim
```

### 2. 启动容器
```
docker start -i my-vim
```

### 3. 关闭容器
```
docker stop my-vim
```



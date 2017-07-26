## Dockerfile 说明
本 Dockerfile 对应的镜像为: https://hub.docker.com/r/bbxytl/alpine-vim


本 镜像 包含两个 tags: simple/complex, 其中 simple 为基本的 vim 配置和一些常用便捷插件;
而 complex 为基于 YouCompleteMe 为补全插件的 vim 配置;
配置仓库为: http://github.com/bbxytl/b-dotfiles


## 文件说明:
- Dockerfile.simple: 基本功能的 vim , c 系列自带补全效果没有安装 ycm
- Dockerfile.complex-ycm: 装有 YouCompleteMe 自动补全插件的 vim
- Dockerfile: 等同于 Dockerfile.complex-ycm

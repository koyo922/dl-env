#!/usr/bin/env bash

# 找到非root用户安装的包
USER_SITE=$(python -m site --user-site)
mkdir -p $USER_SITE # 注意这个路径要在启动kernel之前建好
export PYTHONPATH=$USER_SITE:$PYTHONPATH
# 让当前用户使用local安装的可执行文件
export PATH="/home/me/.local/bin:${PATH}"

jupyter nbextension enable select_keymap/main
jupyter nbextension enable toc2/main

jupyter tensorboard enable --user
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888

#!/usr/bin/env bash

#-------------------- configuring user
# let current user using Aliyun pip mirror
mkdir -p $HOME/.pip/ && \
	printf '[global]\ntrusted-host = mirrors.aliyun.com\nindex-url = http://mirrors.aliyun.com/pypi/simple' > $HOME/.pip/pip.conf


#-------------------- python configs
# allowing usage of non-root install packages
USER_SITE=$(python -m site --user-site)
mkdir -p $USER_SITE # make sure it exists before starting the jupyter kernel
export PYTHONPATH=$USER_SITE:$PYTHONPATH


#-------------------- starting notebook
jupyter nbextension enable select_keymap/main
jupyter nbextension enable toc2/main

jupyter tensorboard enable --user
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.iopub_data_rate_limit=2147483647

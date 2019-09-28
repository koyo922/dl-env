#!/usr/bin/env bash

#-------------------- configuring user
export HOME=/home/me
mkdir -p $HOME/.jupyter/nbconfig
# let current user using Aliyun pip mirror
mkdir -p $HOME/.pip/ && \
	printf '[global]\ntrusted-host = mirrors.aliyun.com\nindex-url = http://mirrors.aliyun.com/pypi/simple' > $HOME/.pip/pip.conf
# setting default password
printf '{\n\
  "NotebookApp": {\n\
    "nbserver_extensions": {\n\
      "jupyter_nbextensions_configurator": true,\n\
      "jupyter_tensorboard": true\n\
    }, \n\
  "password": "sha1:e81dbc5d18c8:7c2d1ed88e9114fd17e30f1dffc35e66f6e20340"\n\
  }\n\
}' > $HOME/.jupyter/jupyter_notebook_config.json && \
	printf '{\n"nbext_hide_incompat": false\n}' > $HOME/.jupyter/nbconfig/common.json


#-------------------- python configs
# allowing usage of non-root install packages
USER_SITE=$(python -m site --user-site)
mkdir -p $USER_SITE # make sure it exists before starting the jupyter kernel
export PYTHONPATH=$PYTHONPATH:$USER_SITE
# allow current user to use the local executables
export PATH="$HOME/.local/bin:${PATH}"
export LANG="en_US.UTF-8"

jupyter nbextension enable select_keymap/main
jupyter nbextension enable toc2/main

jupyter tensorboard enable --user
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888

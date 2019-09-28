FROM tensorflow/tensorflow:latest-py3-jupyter

#-------------------- setting apt & zh_CN.UTF-8 & TimeZone
USER root
ENV TZ=Asia/Shanghai

# 注意这是 Ubuntu18.04 不是 16.04
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
	printf '\
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse\n\
' > /etc/apt/sources.list && \
	apt-get update

RUN apt-get install -y language-pack-zh-hans && \
	echo $TZ > /etc/timezone && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
	rm /etc/localtime && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	dpkg-reconfigure -f noninteractive tzdata && \
	apt-get clean


#-------------------- configuring pip, jupyter
# 让root用户使用内部镜像
RUN mkdir -p $HOME/.pip/ && \
	printf '[global]\ntrusted-host = mirrors.aliyun.com\nindex-url = http://mirrors.aliyun.com/pypi/simple' > $HOME/.pip/pip.conf
# 让root用户使用local安装的可执行文件
ENV PATH="$HOME/.local/bin:${PATH}"
RUN pip install jupyter_contrib_nbextensions && \
	jupyter contrib nbextension install && \
	jupyter nbextensions_configurator enable

# 系统基础包
RUN pip install Cython
# 数据
RUN pip install pandas scikit-learn matplotlib seaborn jupyter jupyter_tensorboard scikit-image
# DL框架
RUN pip install torch pytorch-nlp fastai pytorch_pretrained_bert keras
# 补充
RUN pip install pyfunctional fn tqdm enlighten


#-------------------- configuring user
ENV HOME /home/me
RUN mkdir -p $HOME/.jupyter/nbconfig
# setting default password
RUN printf '{\n\
  "NotebookApp": {\n\
    "nbserver_extensions": {\n\
      "jupyter_nbextensions_configurator": true,\n\
      "jupyter_tensorboard": true\n\
    }, \n\
  "password": "sha1:e81dbc5d18c8:7c2d1ed88e9114fd17e30f1dffc35e66f6e20340"\n\
  }\n\
}' > $HOME/.jupyter/jupyter_notebook_config.json && \
	printf '{\n"nbext_hide_incompat": false\n}' > $HOME/.jupyter/nbconfig/common.json
# 让当前用户使用内部镜像
RUN mkdir -p $HOME/.pip/ && \
	printf '[global]\ntrusted-host = mirrors.aliyun.com\nindex-url = http://mirrors.aliyun.com/pypi/simple' > $HOME/.pip/pip.conf
RUN chmod -R 1777 $HOME  # 趁还有root权限，把/home/me的权限都给到最高


#-------------------- configuring port & cmd
# tensorboard
EXPOSE 6006
# jupyter notebook
EXPOSE 8888
# more ports
EXPOSE 22 80 443 8000-9000

COPY start.sh /
CMD ["/start.sh"]

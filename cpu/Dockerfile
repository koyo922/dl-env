FROM tensorflow/tensorflow:latest-py3-jupyter

#-------------------- setting apt & zh_CN.UTF-8 & TimeZone
USER root
ENV TZ=Asia/Shanghai

# Not it's currently Ubuntu18.04 instead of 16.04
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

# `locales-all` is NECESSARY, or else `export LANG=en_US.UTF-8` would resolve to
# a non-exist locale, which causes `locale.getpreferredencoding() == 'ANSI_X3.4-1968'`
RUN apt-get install -y locales-all language-pack-zh-hans && \
	echo $TZ > /etc/timezone && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
	rm /etc/localtime && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	dpkg-reconfigure -f noninteractive tzdata && \
	apt-get clean


#-------------------- configuring pip, jupyter
# let root user using Aliyun pip mirror
RUN mkdir -p $HOME/.pip/ && \
	printf '[global]\ntrusted-host = mirrors.aliyun.com\nindex-url = http://mirrors.aliyun.com/pypi/simple' > $HOME/.pip/pip.conf
# allow root user to use the local executables
ENV PATH="$HOME/.local/bin:${PATH}"
RUN pip install jupyter_contrib_nbextensions && \
	jupyter contrib nbextension install && \
	jupyter nbextensions_configurator enable

# system basics
RUN pip install Cython
# data mungling
RUN pip install pandas scikit-learn matplotlib seaborn jupyter jupyter_tensorboard scikit-image
# DL frameworks
RUN pip install torch pytorch-nlp fastai pytorch_pretrained_bert keras
# supplimentaries
RUN pip install pyfunctional fn tqdm enlighten


#-------------------- configuring env & port & cmd
ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV HOME=/home/me
# allow current user to use the local executables
ENV PATH="$HOME/.local/bin:${PATH}"

# tensorboard
EXPOSE 6006
# jupyter notebook
EXPOSE 8888
# more ports
EXPOSE 22 80 443 8000-9000

COPY start.sh /
CMD ["/start.sh"]

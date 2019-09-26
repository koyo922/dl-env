FROM pytorch/pytorch:latest

#-------------------- setting zh_CN.UTF-8 & TimeZone & install conda for py3
USER root
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get install -y language-pack-zh-hans && \
	echo $TZ > /etc/timezone && \
	apt-get update && apt-get install -y tzdata && \
	rm /etc/localtime && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	dpkg-reconfigure -f noninteractive tzdata && \
	apt-get clean
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/ && \
	conda config --set show_channel_urls yes && \
	conda clean -ya

#-------------------- configuring user
RUN useradd -u 1000 -U -p ubuntu ubuntu && \
	mkdir -p /home/ubuntu && chown -R ubuntu /home/ubuntu
USER ubuntu
ENV HOME /home/ubuntu

#-------------------- configuring pip, jupyter
RUN mkdir -p $HOME/.pip/ && \
	printf '[global]\ntrusted-host = mirrors.aliyun.com\nindex-url = http://mirrors.aliyun.com/pypi/simple' > $HOME/.pip/pip.conf
ENV PATH="$HOME/.local/bin:${PATH}"
RUN pip install --user jupyter_contrib_nbextensions && \
	jupyter contrib nbextension install --user && \
	jupyter nbextensions_configurator enable --user
RUN pip install --user \
	Cython tensorflow pandas scikit-learn matplotlib seaborn jupyter jupyter_tensorboard \
	torchvision scikit-image pyfunctional tqdm enlighten fastai

# setting default password
RUN printf '{\n\
  "NotebookApp": {\n\
    "nbserver_extensions": {\n\
      "jupyter_nbextensions_configurator": true,\n\
      "jupyter_tensorboard": true\n\
    }, \n\
	"password": "sha1:e81dbc5d18c8:7c2d1ed88e9114fd17e30f1dffc35e66f6e20340"\n\
  }\n\
}' > $HOME/.jupyter/jupyter_notebook_config.json 

#-------------------- configuring port & cmd
# tensorboard
EXPOSE 6006
# jupyter notebook
EXPOSE 8888
# more ports
EXPOSE 22 80 443 8000-9000

COPY start.sh /
CMD ["/start.sh"]

FROM jupyter/tensorflow-notebook

# default TimeZone
USER root
ENV TZ=Asia/Shanghai
RUN echo $TZ > /etc/timezone && \
	apt-get update && apt-get install -y tzdata && \
	rm /etc/localtime && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	dpkg-reconfigure -f noninteractive tzdata && \
	apt-get clean

# add conda/pip installed packages into LD_LIBRARY_PATH
# http://blog.csdn.net/u011534057/article/details/51659999
# http://blog.csdn.net/l297969586/article/details/76590055
RUN echo "/opt/conda/lib/" >> /etc/ld.so.conf && \
	ldconfig

# NOT NEEDED for py2 conda env, nor root env
# add /usr/lib/x86_64-linux-gnu/ to libpath for anaconda ld, during pysndfile install
# https://github.com/cocodataset/cocoapi/issues/94
# cd /opt/conda/envs/py35-pyannote-audio/compiler_compat/ && mv ld ld.bin
# vi ld
# #!/bin/sh
# /opt/conda/envs/py35-pyannote-audio/compiler_compat/ld.bin -L/usr/lib/x86_64-linux-gnu/ $*
# chmod +x ld

# setting vim key-mode for jupyter lab (not of much use) and default password
COPY ./commands.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/
COPY ./jupyter_notebook_config.json /home/jovyan/.jupyter/
# set aliyun mirror for PyPI
COPY ./pip.conf /home/jovyan/.pip/
# git
COPY ./.gitconfig /home/jovyan/
# set Tsinghua-Univ mirror for conda
# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
	conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
	conda config --set show_channel_urls yes
# CRITICAL TO CHOWN, OR ELSE NBEXTENSIONS WILL NOT WORK
RUN chown -R jovyan:users /home/jovyan/

# install python2 kernel
USER jovyan
RUN conda create -n py27 python=2.7 ipykernel numpy scipy pandas \
	&& source activate py27 \
	&& python -m ipykernel install --user

# upgrade packages
RUN pip install -U jupyterlab pandas numpy scipy

# install nbextensions_configurator & default nbextensions
RUN pip install jupyter_contrib_nbextensions \
	&& jupyter contrib nbextension install --user \
	&& jupyter nbextensions_configurator enable --user

# enabling vim_binding (only classic mode works)
RUN mkdir -p $(jupyter --data-dir)/nbextensions \
	&& cd $(jupyter --data-dir)/nbextensions \
	&& git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding \
	&& chmod -R go-w vim_binding \
	&& jupyter nbextension enable freeze/main \
	&& jupyter nbextension enable codefolding/edit \
	&& jupyter nbextension enable toc2/main \
	&& jupyter nbextension enable collapsible_headings/main \
	&& jupyter nbextension enable highlighter/highlighter \
	&& jupyter nbextension enable notify/notify \
	&& jupyter nbextension enable table_beautifier/main \
	&& jupyter nbextension enable vim_binding/vim_binding

# lab mode does not support nbextensions, which is not convinient
ENTRYPOINT ["start.sh", "jupyter", "lab"]

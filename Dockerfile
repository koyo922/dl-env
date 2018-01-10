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

# setting vim key-mode for jupyter lab (not of much use)
COPY ./commands.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/
# default password
COPY ./jupyter_notebook_config.json /home/jovyan/.jupyter/

# CRITICAL TO CHOWN, OR ELSE NBEXTENSIONS WILL NOT WORK
RUN chown -R jovyan:users /home/jovyan/.jupyter

# install nbextensions_configurator & default nbextensions
# enabling vim_binding (only classic mode works)
USER jovyan
RUN pip install -U jupyterlab
RUN pip install jupyter_contrib_nbextensions \
	&& jupyter contrib nbextension install --user \
	&& jupyter nbextensions_configurator enable --user \
	&& jupyter nbextension enable vim_binding/vim_binding

# lab mode does not support nbextensions, which is not convinient
ENTRYPOINT ["start.sh", "jupyter", "lab"]

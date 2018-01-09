FROM jupyter/tensorflow-notebook
# setting vim key-mode for jupyter lab (not of much use)
COPY ./commands.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/
# default password
COPY ./jupyter_notebook_config.json /home/jovyan/.jupyter/

# CRITICAL TO CHOWN, OR ELSE NBEXTENSIONS WILL NOT WORK
USER root
RUN chown -R jovyan:users /home/jovyan/.jupyter
USER jovyan

# install nbextensions_configurator & default nbextensions
# enabling vim_binding (only classic mode works)
RUN pip install jupyter_contrib_nbextensions \
	&& jupyter contrib nbextension install --user \
	&& jupyter nbextensions_configurator enable --user \
	&& jupyter nbextension enable vim_binding/vim_binding

# lab mode does not support nbextensions, which is not convinient
# ENTRYPOINT ["start.sh", "jupyter", "lab"]

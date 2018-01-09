FROM jupyter/tensorflow-notebook
COPY ./jupyter_notebook_config.json /home/jovyan/.jupyter/
COPY ./commands.jupyterlab-settings /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/codemirror-extension/
ENTRYPOINT ["start.sh", "jupyter", "lab"]

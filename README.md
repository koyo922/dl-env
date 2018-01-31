# my_jupyter_lab_docker
Docker files for my jupyter notebook/lab configuration  
**开箱即用** 的jupyter notebook/lab 环境  

> CAUTION:
> This Docker image only supports CPU environment.
> If you need GPU support, please read https://github.com/floydhub/dl-docker

## Features
* common packages included(via base Docker image):
	* Python3.6/Anaconda
	* TensorFlow1.3/Keras
	* numpy/pandas
	* ...
* time zone default to Asia/Shanghai
* latest version of jupyter lab
* keyword-binding set to: `vim`
* a default password
* batteries-included nbextensions
* auto-build at https://hub.docker.com/r/koyo922/my_jupyter_lab_docker/
* also a Python2.7 kernel for Jupyter

## Usage
```bash
mkdir -p ~/tf_notebook/
chmod -R 777 ~/tf_notebook/
# note that the directory should be readable for `jovyan` user inside docker
# the 'jupyter lab' mode is nice, but does not support nbextensions, which is inconvinient for vim users
# click Help/Start Classic Notebook at anytime, or modify the url from .../lab/ to .../notebook/ to use classic mode
# add something like `-e "TZ=Asia/Shanghai"` and rebuild the image, if you need to use another time zone setting
docker run --name tf_notebook -d -p 8888:8888 \
	-v ~/tf_notebook:/home/jovyan/work \
	koyo922/my_jupyter_lab_docker
# remeber to relogin after restarting the container, password is needed only at the first time
```

## Reference
* https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook
* https://github.com/ipython-contrib/jupyter_contrib_nbextensions

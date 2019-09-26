# dl-env

Docker files for my deep learning env.

**开箱即用的深度学习环境(含有 jupyter notebook, 支持CUDA的PyTorch, fastai, etc. )**

## Features

- common packages included(via base Docker image):
	- Python3.6/Anaconda
	- PyTorch latest
- extra packages
	- fastai
	- numpy/pandas
	- ...
- time zone default to Asia/Shanghai
- a default password
- GUI-based `nbextension_configurator`
- auto-build at https://hub.docker.com/r/koyo922/dl-env/
- NOTE: add something like `-e "TZ=Asia/Shanghai"` and rebuild the image, if you need to use another time zone setting

## Usage

```bash
mkdir -p ~/workspace && cd ~/workspace
nvidia-docker run -it --rm -d -p 8888:8888 -p 8000-8100:8000-8100 \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	-v $PWD:/workspace \
	--name dl \
	koyo922/dl-env
# remeber to re-login after restarting the container, password is needed only at the first time
```

## Reference

- https://github.com/jxcodetw/docker-jupyter-pytorch/blob/master/Dockerfile
- https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook

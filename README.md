# jupyter-fastai

Docker files for my jupyter notebook configuration with fastai

**开箱即用的jupyter notebook 环境(含有支持CUDA的PyTorch, fastai)**

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
- auto-build at https://hub.docker.com/r/koyo922/jupyter-fastai/
- NOTE: add something like `-e "TZ=Asia/Shanghai"` and rebuild the image, if you need to use another time zone setting

## Usage

```bash
mkdir -p ~/workspace
nvidia-docker run -it --rm -d -p 8888:8888 -p 8000-8100:8000-8100 \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	-v $PWD:/workspace \
	--name jf \
	koyo922/jupyter-fastai
# remeber to re-login after restarting the container, password is needed only at the first time
```

## Reference

- https://github.com/jxcodetw/docker-jupyter-pytorch/blob/master/Dockerfile
- https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook
- https://github.com/ipython-contrib/jupyter-fastai

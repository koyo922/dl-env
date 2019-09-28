# dl-env

Docker files for my deep learning env, with CUDA-supported-PyTorch, fastai, Tensorflow, Keras etc.

**开箱即用的深度学习环境(含有 jupyter notebook, 支持CUDA的PyTorch, fastai, Tensorflow, Keras, etc. )**

## Features

- common packages included(via base Docker image):
	- Python3.6/Anaconda
	- Tensorflow latest
- extra packages
	- PyTorch latest
	- fastai
	- Keras
	- numpy/pandas
	- ...
- time zone default to Asia/Shanghai
- a default password
- GUI-based `nbextension_configurator`
- auto-build at https://hub.docker.com/r/koyo922/dl-env/
- NOTE: add something like `-e "TZ=Asia/Shanghai"` and rebuild the image, if you need to use another time zone setting

## Usage

```bash
mkdir -p ~/workspace/home/me && cd ~/workspace
nvidia-docker run -it -p 8888:8888 -p 8000-8100:8000-8100 \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	-v $PWD:/workspace -v $PWD/home/me:/home/me -w /workspace \
	--name dl \
	koyo922/dl-env:gpu

# for CPU machine, please modify the above `nvidia-docker` into `docker`, and `koyo922/dl-env:gpu` into `koyo922/dl-env:cpu`
```

Note:
- How to access the jupyter server
	1. read the docker container output
	2. look for something like `http://(4cd7fac856a5 or 127.0.0.1):8888/?token=4c5bf6171097f89ced23ed52a84aced0f6f7e3a24b777554`
	3. copy it to you web browser address bar
	4. modify the hostname part `(4cd7fac856a5 or 127.0.0.1)` with its Internet IP
	5. hit enter
- To install new packages in notebooks, you need `pip install --user ...`
- `nvidia-driver` 参考官网正常安装即可。阿里云上除`vgn5i`以外的GPU机器都支持自动安装驱动和CUDA，启动实例时勾上就好
- `nvidia-docker` 请参考这里安装 https://zhuanlan.zhihu.com/p/76464450

## Reference

- https://zhuanlan.zhihu.com/p/59617018
- https://github.com/jxcodetw/docker-jupyter-pytorch/blob/master/Dockerfile
- https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook

# dl-env

Docker files for my deep learning env.

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
mkdir -p ~/workspace && cd ~/workspace
# nvidia-driver参考官网正常安装即可。阿里云上除`vgn5i`以外的GPU机器都支持自动安装驱动和CUDA，启动实例时勾上就好
# nvidia-docker请参考这里安装 https://zhuanlan.zhihu.com/p/76464450
nvidia-docker run -it -p 8888:8888 -p 8000-8100:8000-8100 \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	-v $PWD:/workspace \
	--name dl \
	koyo922/dl-env:gpu

# for CPU machine, please modify the above `nvidia-docker` into `docker`, and `koyo922/dl-env:gpu` into `koyo922/dl-env:cpu`
```

Note:
- Default password is `apeman`, to change it need 2 steps:
	1. Open a new bash, run `docker exec -u root -it dl bash -c 'jupyter notebook password && chmod -R 1777 /home/me/'`, and type your new password twice.
	2. then `docker restart dl`
	3. [optional] to see the realtime log; return to the original bash where you started container, run `docker attach dl`
- To install new packages in notebooks, you need `pip install --user ...`

## Reference

- https://zhuanlan.zhihu.com/p/59617018
- https://github.com/jxcodetw/docker-jupyter-pytorch/blob/master/Dockerfile
- https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook

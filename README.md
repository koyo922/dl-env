# my_jupyter_lab_docker
docker file for my jupyter_lab configuration
based on https://github.com/jupyter/docker-stacks/tree/master/tensorflow-notebook

Usage:

```bash
mkdir -p ~/tf_notebook/
chmod -R 777 ~/tf_notebook/
# note that the directory should be readable for `jovyan` user inside docker
docker run --name tf_notebook -d -p 8888:8888 \
		   -v ~/tf_notebook:/home/jovyan/work \
		   koyo922/tf-notebook start.sh \
		   jupyter lab
```

Defails:
* keyword-binding set to: `vim`
* a default password

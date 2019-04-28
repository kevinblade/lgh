FROM tensorflow/tensorflow:latest-py3

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# JupyterHub
ARG JUPYTERHUB_RUNTIME_DIR=/srv/jupyterhub
ARG JUPYTERHUB_USER_GROUP=jupyterhub
ARG JUPYTERHUB_CONFIG_FILE=jupyter_config.py

USER root

RUN groupadd ${JUPYTERHUB_USER_GROUP} && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash admin -p "$(openssl passwd -1 admin)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user1 -p "$(openssl passwd -1 user1)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user2 -p "$(openssl passwd -1 user2)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user3 -p "$(openssl passwd -1 user3)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user4 -p "$(openssl passwd -1 user4)"

# Installing npm, nodejs
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Installing http-proxy
RUN npm install -g configurable-http-proxy core-js@3

# Installing python packages
RUN pip install sqlalchemy==1.2.19 tornado jinja2==2.10.0 traitlets requests scikit-learn pandas jupyterlab==0.35.4 jupyterlab-server==0.2.0 jupyterhub

# Run JupyterHub as Docker main process
LABEL org.jupyter.service="jupyterhub"

# Installing jupyterlab-hub for adding Hub menu on JupyterLab
RUN jupyter labextension install @jupyterlab/hub-extension

RUN mkdir -p ${JUPYTERHUB_RUNTIME_DIR}

# Copy jupyter_config.py to container
COPY ${JUPYTERHUB_CONFIG_FILE} ${JUPYTERHUB_RUNTIME_DIR}/${JUPYTERHUB_CONFIG_FILE}

EXPOSE 8000

CMD ["jupyterhub", "-f", "${JUPYTERHUB_RUNTIME_DIR}/${JUPYTERHUB_CONFIG_FILE}"]
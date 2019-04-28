FROM ubuntu:latest

USER root

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Anaconda3
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y curl openssl \
  wget bzip2 ca-certificates \
  libglib2.0-0 libxext6 libsm6 libxrender1 \
  git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
  /bin/bash ~/anaconda.sh -b -p /opt/conda && \
  rm ~/anaconda.sh && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc

# RUN apt-get install -y curl grep sed dpkg && \
#   TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
#   curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
#   dpkg -i tini.deb && \
#   rm tini.deb && \
# apt-get clean

# JupyterHub
ARG JUPYTERHUB_RUNTIME_DIR=/srv/jupyterhub
ARG JUPYTERHUB_USER_GROUP=jupyterhub
ARG JUPYTERHUB_CONFIG_FILE=jupyterhub_config.py

RUN groupadd ${JUPYTERHUB_USER_GROUP} && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash admin -p "$(openssl passwd -1 admin)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user1 -p "$(openssl passwd -1 user1)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user2 -p "$(openssl passwd -1 user2)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user3 -p "$(openssl passwd -1 user3)" && \
  useradd -g ${JUPYTERHUB_USER_GROUP} -ms /bin/bash user4 -p "$(openssl passwd -1 user4)"

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Installing http-proxy
RUN npm install -g configurable-http-proxy

# Installing python packages
RUN conda install -y sqlalchemy tornado jinja2 traitlets requests scikit-learn pandas jupyterlab jupyterlab_server tensorflow
RUN conda install -y --override-channels -c conda-forge airflow airflow-with-async \
  airflow-with-azure_blob_storage airflow-with-celery airflow-with-cgroups \
  airflow-with-crypto airflow-with-dask airflow-with-databricks airflow-with-datadog airflow-with-docker \
  airflow-with-druid airflow-with-elasticsearch airflow-with-emr airflow-with-github_enterprise \
  airflow-with-jdbc airflow-with-jenkins airflow-with-jira airflow-with-kubernetes \
  airflow-with-ldap airflow-with-mongo airflow-with-mssql airflow-with-mysql airflow-with-password \
  airflow-with-postgres airflow-with-redis airflow-with-s3 airflow-with-salesforce airflow-with-samba \
  airflow-with-sendgrid airflow-with-slack airflow-with-ssh airflow-with-statsd airflow-with-vertica \
  airflow-with-winrm
# RUN conda install -y -c conda-forge/label/cf201901 airflow-with-azure_cosmos 
RUN conda install -y --override-channels -c conda-forge asciimatics jupyterhub

RUN wget https://dvc.org/deb/dvc.list -O /etc/apt/sources.list.d/dvc.list
RUN apt-get update
RUN apt-get install dvc

RUN mkdir -p ${JUPYTERHUB_RUNTIME_DIR}

# Copy jupyter_config.py to container
COPY ${JUPYTERHUB_CONFIG_FILE} ${JUPYTERHUB_RUNTIME_DIR}/${JUPYTERHUB_CONFIG_FILE}
COPY entrypoint.sh ./

# Installing jupyterlab-hub for adding Hub menu on JupyterLab
# RUN conda activate
RUN . /opt/conda/etc/profile.d/conda.sh && \
  conda activate base && \
  jupyter labextension install @jupyterlab/hub-extension

EXPOSE 8000

RUN chmod +x entrypoint.sh

CMD "./entrypoint.sh"
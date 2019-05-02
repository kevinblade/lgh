# run-containers.sh
#!/bin/bash

export POSTGRES_CONTAINER_NAME=aml-postgres
export POSTGRES_PORT=5432
export POSTGRES_LOCAL_MOUNT=/data/pgdata
export POSTGRES_CONTAINER_MOUNT=/var/lib/postgresql/data

export GOGS_CONTAINER_NAME=aml-gogs
export GOGS_UI_PORT=10080
export GOGS_LOCAL_MOUNT=/data/gogs
export GOGS_CONTAINER_MOUNT=/data

export AML_CONTAINER_NAME=aml-container

export AIRFLOW_UI_PORT=5601
export AIRFLOW_LOCAL_MOUNT=/data/mlsapp/mls
export AIRFLOW_CONTAINER_MOUNT=/home/airflow

export JUPYTER_UI_PORT=8000

# PostgreSQL 컨테이너 실행
docker run --rm -it -d --name $POSTGRES_CONTAINER_NAME \
  -p $POSTGRES_PORT:5432 \
  -v $POSTGRES_LOCAL_MOUNT:$POSTGRES_CONTAINER_MOUNT \
  postgres

# Gogs 컨테이너 실행
docker run --rm -it -d --name $GOGS_CONTAINER_NAME \
  -p 10022:22 \
  -p $GOGS_UI_PORT:3000 \
  -v $GOGS_LOCAL_MOUNT:$GOGS_CONTAINER_MOUNT \
  gogs/gogs

# AML 컨테이너 실행
docker run -itd --name $AML_CONTAINER_NAME \
  -p $AIRFLOW_UI_PORT:8080 \
  -p $JUPYTER_UI_PORT:8000 \
  --link $GOGS_CONTAINER_NAME:gogs \
  --link $POSTGRES_CONTAINER_NAME:postgresql \
  -v $AIRFLOW_LOCAL_MOUNT:$AIRFLOW_CONTAINER_MOUNT \
  aml/anaconda3

# Initialize database for airflow
docker exec -it -d $AML_CONTAINER_NAME airflow initdb
# Execute a web server for airflow
docker exec -it -d $AML_CONTAINER_NAME airflow webserver
# Execute a scheduler for airflow
docker exec -it -d $AML_CONTAINER_NAME airflow scheduler

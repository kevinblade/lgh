# run-containers.sh
#!/bin/bash

# 기존 모든 컨테이너 종료 및 삭제
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# PostgreSQL 관련 환경 변수 설정
export POSTGRES_CONTAINER_NAME=aml-postgres
export POSTGRES_PORT=5432
export POSTGRES_LOCAL_MOUNT=/data/pgdata
export POSTGRES_CONTAINER_MOUNT=/var/lib/postgresql/data

# Gogs 관련 환경 변수 설정
export GOGS_CONTAINER_NAME=aml-gogs
export GOGS_UI_PORT=10080
export GOGS_LOCAL_MOUNT=/data/gogs
export GOGS_CONTAINER_MOUNT=/data

# AML 컨테이너 관련 환경 변수
export AML_CONTAINER_NAME=aml-container
export AIRFLOW_UI_PORT=5601
export AIRFLOW_LOCAL_MOUNT=/data/mlsapp/mls
export AIRFLOW_CONTAINER_MOUNT=/home/airflow

# Jupyterhub 관련 환경 변수
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

# Airflow를 위한 PostgreSQL DB 초기화
docker exec -it -d $AML_CONTAINER_NAME airflow initdb

# Airflow 웹 서버 실행
docker exec -it -d $AML_CONTAINER_NAME airflow webserver

# Airflow scheduler 실행
docker exec -it -d $AML_CONTAINER_NAME airflow scheduler

# run-aml.sh
#!/bin/bash

# 기존 컨테이너 종료 및 삭제
docker stop aml-container
docker rm aml-container

# PostgreSQL 관련 환경 변수 설정
export POSTGRES_CONTAINER_NAME=aml-postgres

# Gogs 관련 환경 변수 설정
export GOGS_CONTAINER_NAME=aml-gogs

# AML 컨테이너 관련 환경 변수
export AML_CONTAINER_NAME=aml-container
export AIRFLOW_UI_PORT=5601
export AIRFLOW_LOCAL_MOUNT=/data/mlsapp/mls
export AIRFLOW_CONTAINER_MOUNT=/home/mlsapp/mls

# Jupyterhub 관련 환경 변수
export JUPYTER_UI_PORT=8000

# AML 컨테이너 실행
docker run -itd --name $AML_CONTAINER_NAME \
  -p $AIRFLOW_UI_PORT:8080 \
  -p $JUPYTER_UI_PORT:8000 \
  --link $GOGS_CONTAINER_NAME:gogs \
  --link $POSTGRES_CONTAINER_NAME:postgresql \
  -v $AIRFLOW_LOCAL_MOUNT:$AIRFLOW_CONTAINER_MOUNT \
  aml/anaconda3

# MLS용 소스코드 폴더
docker exec -it aml-container mkdir -p $AIRFLOW_CONTAINER_MOUNT

# Airflow를 위한 PostgreSQL DB 초기화
docker exec -it $AML_CONTAINER_NAME airflow initdb

# Airflow 웹 서버 실행
docker exec -it -d $AML_CONTAINER_NAME airflow webserver

# Airflow scheduler 실행
docker exec -it -d $AML_CONTAINER_NAME airflow scheduler

docker logs $AML_CONTAINER_NAME
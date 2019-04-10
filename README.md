# LGH 하나은행 머신러닝기반 STR룰 고도화 프로젝트

## - 사전 준비 (local 환경)
  - kubernetes 설치
    - Docker Desktop을 설치하면 Kubernetes가 포함되어 설치가 됩니다. Kubernetes 사용여부를 설정하세요. 자세한 사항: https://www.docker.com/products/docker-desktop
- ksonnet 설치
  - Liux: https://www.kubeflow.org/docs/components/ksonnet/
  - macOS: https://ksonnet.io/get-started/

## - kubeflow 설치
```
$ export KUBEFLOW_SRC="kubeflow 설치 경로"
$ mkdir ${KUBEFLOW_SRC}
$ cd ${KUBEFLOW_SRC}
$ export KUBEFLOW_TAG=v0.4.1
$ curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash
```

## - 응용 프로그램 설정 및 Kubeflow에 배포
```
$ export KUBEFLOW_SRC="kubeflow 설치 경로"
$ export KFAPP=kf-demo-app
$ cd ${KUBEFLOW_SRC}
$ ${KUBEFLOW_SRC}/scripts/kfctl.sh init ${KFAPP} --platform none
$ cd ${KFAPP}
$ ${KUBEFLOW_SRC}/scripts/kfctl.sh generate k8s
$ ${KUBEFLOW_SRC}/scripts/kfctl.sh apply k8s
```

## - Kubeflow에서 배포 삭제
```
$ cd ${KUBEFLOW_SRC}/${KFAPP}
$ ${KUBEFLOW_SRC}/scripts/kfctl.sh delete k8s
```
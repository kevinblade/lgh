# LGH 하나은행 머신러닝기반 STR룰 고도화 프로젝트

## - 사전 준비 (local 환경)

- kubernetes 설치
  - Docker Desktop을 설치하면 Kubernetes가 포함되어 설치가 됩니다. Kubernetes 사용여부를 설정하세요. 자세한 사항: https://www.docker.com/products/docker-desktop
- ksonnet 설치
  - Liux: https://www.kubeflow.org/docs/components/ksonnet/
  - macOS: https://ksonnet.io/get-started/

## - ksonnet을 이용한 KubeFlow 설치

- 주의:
  - Memory:16Gb, CPU:8Core인 macOS에서 실행되는 Docker Desktop의 경우
  - Preferences > Advanced 에서 다음 설정을 권장합니다.
  - Memory: 4GB+
  - Swap: 2Gb+

```
# install ksonnet
$ brew install ksonnet/tap/ks
$ ks version
ksonnet version: 0.13.1
jsonnet version: v0.11.2
client-go version: kubernetes-1.10.4

# install kubeflow
$ export KUBEFLOW_TAG=v0.4.1
$ export KUBEFLOW_SRC=$(pwd)/kubeflow_src # 본인 환경에 맞게 변경하세요.
$ export KFAPP=lgh-kubeflow               # 본인 환경에 맞게 변경하세요.

$ mkdir ${KUBEFLOW_SRC} && cd ${KUBEFLOW_SRC}
$ curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash

$ sh ${KUBEFLOW_SRC}/scripts/kfctl.sh init ${KFAPP} --platform none
$ cd ${KFAPP}
$ sh ${KUBEFLOW_SRC}/scripts/kfctl.sh generate k8s
$ sh ${KUBEFLOW_SRC}/scripts/kfctl.sh apply k8s
```

## - 설치된 Kubeflow 삭제

```
$ cd ${KUBEFLOW_SRC}/${KFAPP}
$ sh ${KUBEFLOW_SRC}/scripts/kfctl.sh delete k8s
```

## - Kubeflow 실행 및 웹 UI

```
$ kubectl port-forward -n kubeflow `kubectl get pods -n kubeflow --selector=service=ambassador -o jsonpath='{.items[0].metadata.name}'` 8080:80
```

- 브라우저에서 http://localhost:8080/ 로 접속

## Kubernetes Dashboard 설치

```
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
# 로컬에서 접속하기 위해서는 보안 채널을 만들기 위해서 다음 명령을 사용한다.
$ kubectl proxy
```

- 브라우저에서 http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/ 로 접속

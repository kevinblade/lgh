# LGH 하나은행 머신러닝기반 STR룰 고도화 프로젝트

## 1. Install Kubeflow

- kubernetes 설치
  - Docker Desktop을 설치하면 Kubernetes가 포함되어 설치가 됩니다. Kubernetes 사용여부를 설정하세요. 자세한 사항: https://www.docker.com/products/docker-desktop
- ksonnet 설치
  - Liux: https://www.kubeflow.org/docs/components/ksonnet/
  - macOS: https://ksonnet.io/get-started/
- kubeflow 설치
  ```
  # 다운로드
  $ kfdownload.sh
  # kfsetup.sh 파일에서 KFAPP을 수정한 후 실행.
  $ kfsetup.sh
  ```

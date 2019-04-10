KUBEFLOW_TAG=v0.4.1
KUBEFLOW_SRC=$(pwd)/src/${KUBEFLOW_TAG}
KFAPP=kf-app
cd ${KUBEFLOW_SRC}
./scripts/kfctl.sh init ${KFAPP} --platform none
cd ${KFAPP}
../scripts/kfctl.sh generate k8s
../scripts/kfctl.sh apply k8s
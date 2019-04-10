KUBEFLOW_TAG=v0.4.1
KUBEFLOW_SRC=$(pwd)/src/${KUBEFLOW_TAG}
KFAPP=kf-app
cd ${KUBEFLOW_SRC}/${KFAPP}
../scripts/kfctl.sh delete k8s

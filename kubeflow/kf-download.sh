KUBEFLOW_TAG=v0.4.1
KUBEFLOW_SRC=$(pwd)/src/${KUBEFLOW_TAG}
mkdir -p ${KUBEFLOW_SRC}
cd ${KUBEFLOW_SRC}
curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash
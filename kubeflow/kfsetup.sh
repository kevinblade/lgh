KUBEFLOW_TAG=v0.4.1
KUBEFLOW_SRC="src/${KUBEFLOW_TAG}"
KFAPP=kf-demo-app

${KUBEFLOW_SRC}/scripts/kfctl.sh init ${KFAPP} --platform none
cd ${KFAPP}
${KUBEFLOW_SRC}/scripts/kfctl.sh generate k8s
${KUBEFLOW_SRC}/scripts/kfctl.sh apply k8s
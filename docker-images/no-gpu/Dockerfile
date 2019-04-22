FROM tensorflow/tensorflow:latest-py3

USER root

WORKDIR /workspace
RUN chmod a+rwx /workspace

# Installing python packages
RUN pip install scikit-learn pandas apache-airflow[postgres] dvc jupyter jupyterlab==0.35.4 jupyterlab-server==0.2.0

# Configuring access to Jupyter
RUN mkdir /workspace/notebooks

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "lab", "--allow-root", "--notebook-dir=/workspace/notebooks", "--ip 0.0.0.0", "--port=8888", "--no-browser"]
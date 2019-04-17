# docker pull from nVIDIA NGC image for tensorflow
FROM nvcr.io/nvidia/tensorflow:19.03-py3

# Setting working folder
WORKDIR /workspace
RUN chmod a+rwx /workspace

# Installing python packages
RUN pip install scikit-learn pandas apache-airflow[postgres] dvc jupyter

# Configuring access to Jupyter
RUN mkdir /workspace/notebooks
RUN mkdir /workspace/.jupyter
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /workspace/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/workspace/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
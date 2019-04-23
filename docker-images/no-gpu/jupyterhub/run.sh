#!/bin/bash

docker run --rm -it -p 9200:8000 -v $HOME/data:/data lgh-aml-container:no-gpu-jupyterhub

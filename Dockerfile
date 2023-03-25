# Dockerfile to run StyleGAN2 ADA - Copyright 2020 by Jeff Heaton
# Licensed under the MIT license
# GitHub: https://github.com/jeffheaton/docker-stylegan2-ada
# DockerHub: https://hub.docker.com/r/heatonresearch/stylegan2-ada
# 
FROM nvcr.io/nvidia/tensorflow:21.06-tf1-py3

ENV DNNLIB_CACHE_DIR=/home/.cache 

RUN apt-get update && \
    apt-get -y install git && \
    mkdir /home/.cache && \
    chmod 777 /home/.cache && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -Rf /tmp/* 

RUN cd /home && \
    git clone https://github.com/NVlabs/stylegan2-ada.git

RUN pip install --upgrade pip && \
    pip install scipy==1.3.3 requests==2.22.0 Pillow==6.2.1 h5py==2.9.0 imageio==2.9.0 \ 
    imageio-ffmpeg==0.4.2 tqdm==4.49.0 boto3==1.16.25 && \
    rm -Rf /tmp/*

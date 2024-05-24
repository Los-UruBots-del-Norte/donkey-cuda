#!/bin/sh
docker build . -t donkey-cuda
docker run -d donkey-cuda -p 8889:8888 --gpus all
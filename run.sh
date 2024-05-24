#!/bin/sh
docker build . -t donkey-cuda
docker run -d donkey-cuda --gpus all
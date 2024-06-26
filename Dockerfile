# FROM nvidia/cuda:11.8.0-base-ubuntu20.04
FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu20.04

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update && apt-get install -y git python3 python3-pip wget

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

RUN conda init bash \
    && . ~/.bashrc \
    && conda create --name donkey -y \
    && conda activate donkey

RUN conda install python=3.11 -y
RUN conda install cudatoolkit tensorflow-gpu cuddnn -c pytorch -y
RUN conda install -c conda-forge jupyterlab -y
RUN pip install --upgrade pip wheel setuptools requests
RUN pip install donkeycar[pc]

# RUN mkdir projects && cd projects && git clone https://github.com/autorope/donkeycar
# RUN cd projects/donkeycar && pip install -e .[pc]

RUN python --version
FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu20.04

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update && apt-get install -y git python3.11 wget
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.11 get-pip.py
RUN python3.11 -m pip install tensorflow[and-cuda]==2.15.1

RUN python3.11 -m pip install --upgrade pip wheel setuptools requests
RUN python3.11 -m pip install ipykernel
RUN python3.11 -m pip install jupyterlab

RUN mkdir -p /root/notebooks/train

WORKDIR /root/notebooks/train

RUN git clone https://github.com/autorope/donkeycar

RUN cd donkeycar && git checkout main && pip install -e .[pc]

RUN donkey createcar --path ./mycar

COPY ./replace/training.py /root/notebooks/train/donkeycar/donkeycar/pipeline/training.py
COPY ./replace/myconfig.py /root/notebooks/train/mycar/myconfig.py
COPY ./replace/Donkey.ipynb /root/notebooks/train/Donkey.ipynb


# CMD ["jupyter", "lab","--allow-root"]
CMD ["jupyter", "lab", "--ip='*'", "--port=8888", "--allow-root"]
EXPOSE 8888



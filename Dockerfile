FROM nvidia/cuda:11.8.0-base-ubuntu20.04

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
RUN conda install cudatoolkit=11 -c pytorch -y
RUN conda install -c conda-forge jupyterlab -y
RUN pip install --upgrade pip wheel setuptools requests
RUN pip install donkeycar[pc]

# RUN mkdir projects && cd projects && git clone https://github.com/autorope/donkeycar
# RUN cd projects/donkeycar && pip install -e .[pc]

RUN python --version

RUN donkey createcar --path ~/mycar

WORKDIR /root/mycar

CMD ["jupyter", "lab","--allow-root"]

EXPOSE 8888



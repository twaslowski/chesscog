FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

# Install Python 3.8
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt install -y python3.8 python3-pip && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Install poetry
RUN pip install --upgrade pip && \
    pip install poetry


# Setup data mount
RUN mkdir -p /data
ENV DATA_DIR /data
VOLUME /data

# Install dependencies
RUN mkdir -p /chess
WORKDIR /chess
COPY poetry.lock pyproject.toml ./
RUN poetry install

# Copy files
COPY chesscog ./chesscog


CMD python -m chesscog.occupancy_classifier.train
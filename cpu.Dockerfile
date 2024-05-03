FROM python:3.8

# Install poetry
RUN pip install --upgrade pip && \
    pip install poetry && \
    poetry config virtualenvs.create false

# Install dependencies
RUN mkdir -p /chess
WORKDIR /chess
COPY ./pyproject.toml ./poetry.lock* ./
RUN poetry install --no-root
ENV PYTHONPATH "/chess:${PYTHONPATH}"

# Setup config mount
RUN mkdir -p /config
ENV CONFIG_DIR /config
COPY ./config/* /config/

COPY chesscog ./chesscog

# Get models
RUN mkdir -p /models
ENV MODELS_DIR /models
RUN python -m chesscog.piece_classifier.download_models
RUN python -m chesscog.occupancy_classifier.download_models

# Copy files

ENTRYPOINT ["python", "-m", "chesscog.recognition.recognition"]
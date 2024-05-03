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

# Setup models mount
RUN mkdir -p /chess/models
ENV MODELS_DIR /chess/models
COPY ./models/* /chess/models/

# Copy files
COPY chesscog ./chesscog

ENTRYPOINT ["python", "-m", "chesscog.recognition.recognition"]
FROM python:3.10-slim AS backend-base
ENV LANG C.UTF-8
SHELL ["/bin/bash",  "-o", "pipefail", "-c"]
RUN useradd -ms /bin/bash notroot
USER notroot
ENV PYTHONFAULTHANDLER=1 \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=30 \
  PATH="/home/notroot/.local/bin:${PATH}"
WORKDIR /home/notroot/app/

FROM backend-base AS runner
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src src

# syntax=docker/dockerfile:1
FROM debian:bookworm-slim

# Install TeX Live and required utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    ghostscript \
    poppler-utils \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENV TEX_FILE=cv.tex
ENV WATCH=false

ENTRYPOINT []
CMD ["/entrypoint.sh"]

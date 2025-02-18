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

ENV TEX_FILE=cv.tex
ENV WATCH=false

CMD sh -c '
  if [ ! -f "$TEX_FILE" ]; then 
    echo "Error: File $TEX_FILE not found!" >&2
    exit 1
  fi
  
  pdflatex "$TEX_FILE" || { echo "Initial compilation failed" >&2; exit 1; }
  
  if [ "$WATCH" = "true" ]; then 
    echo "Watching for changes..."
    while inotifywait -e modify "$TEX_FILE"; do 
      echo "File changed, recompiling..."
      pdflatex "$TEX_FILE" || echo "Recompilation failed" >&2
    done
  fi
'

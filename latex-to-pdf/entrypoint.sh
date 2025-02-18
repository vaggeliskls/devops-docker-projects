#!/bin/sh

if [ ! -f "$TEX_FILE" ]; then 
    echo "Error: File $TEX_FILE not found!" >&2
    exit 1
fi

pdflatex "$TEX_FILE" || { echo "Initial compilation failed" >&2; exit 1; }

if [ "$WATCH" = "true" ]; then 
    while inotifywait -e modify "$TEX_FILE"; do 
        pdflatex "$TEX_FILE" || echo "Recompilation failed" >&2
    done
fi
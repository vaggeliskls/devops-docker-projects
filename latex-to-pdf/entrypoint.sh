#!/bin/sh

if [ ! -f "$TEX_FILE" ]; then 
    echo "Error: File $TEX_FILE not found!" >&2
    exit 1
fi

pdflatex "$TEX_FILE" || { echo "Initial compilation failed" >&2; exit 1; }
echo "-> Initial compilation successful"

# we use interval due to windows issue with inotify and fwatch
# Set sleep interval from env or default to 2 seconds
INTERVAL=${INTERVAL:-2}

if [ "$WATCH" = "true" ]; then 
    echo "-> Watching for changes in $TEX_FILE (Polling every $SLEEP_INTERVAL seconds)"
    LAST_MOD_TIME=$(stat -c %Y "$TEX_FILE")
    while true; do
        sleep "$INTERVAL"
        NEW_MOD_TIME=$(stat -c %Y "$TEX_FILE")

        if [ "$NEW_MOD_TIME" != "$LAST_MOD_TIME" ]; then
            echo "-> File changed, recompiling"
            pdflatex "$TEX_FILE" || echo "Recompilation failed" >&2
            LAST_MOD_TIME=$NEW_MOD_TIME
        fi
    done
fi
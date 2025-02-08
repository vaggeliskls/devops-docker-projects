FROM alpine:3.21

# Install necessary packages, including tzdata to set the timezone
RUN apk add --no-cache docker-cli curl tzdata

# Set the timezone (e.g., UTC or your desired timezone)
ENV TZ="Europe/Athens"

# Copy the check-disk script into the container
COPY --chmod=0775 check-disk.sh /check-disk.sh

# Run the check-disk script every x seconds by default
CMD ["/bin/sh", "-c", "while true; do /check-disk.sh; sleep ${CHECK_INTERVAL:-5}; done"]

FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Copy only required SMCTL tools (smctl binary and PKCS11 library)
RUN mkdir -p /opt/smctl
COPY tools/smctl /opt/smctl/
COPY tools/smpkcs11.so /opt/smctl/

# Make smctl executable and create symlinks
RUN chmod +x /opt/smctl/smctl && \
    ln -s /opt/smctl/smctl /usr/local/bin/smctl

# Install Jsign for Windows code signing using .deb package
RUN wget -q https://github.com/ebourg/jsign/releases/download/7.4/jsign_7.4_all.deb -O /tmp/jsign.deb && \
    dpkg -i /tmp/jsign.deb && \
    rm /tmp/jsign.deb

# Create PKCS11 configuration file for Jsign
RUN mkdir -p /etc/digicert && \
    echo 'name = signingmanager' > /etc/digicert/pkcs11.cfg && \
    echo 'library = /opt/smctl/smpkcs11.so' >> /etc/digicert/pkcs11.cfg && \
    echo 'slotListIndex = 0' >> /etc/digicert/pkcs11.cfg

ENV SM_HOST="https://clientauth.one.digicert.com"
ENV SM_CLIENT_CERT_FILE="/app/sign.p12"
ENV SM_API_KEY=""
ENV SM_CLIENT_CERT_PASSWORD=""
# or smctl credentials save value1 value2
# jsign --keystore /etc/digicert/pkcs11.cfg --storepass NONE --storetype PKCS11 --alias <alias> --tsaurl http://timestamp.digicert.com /app/file.exe
# smctl sign --keypair-alias <alias> --config-file /etc/digicert/pkcs11.cfg --input /app/file.exe --verbose
# Set working directory
WORKDIR /app

CMD ["/bin/bash"]

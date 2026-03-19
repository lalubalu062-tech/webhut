FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Update aur zaroori packages install karein (XRDP add kiya hai)
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-terminal xrdp dbus-x11 curl wget python3 \
    firefox-esr nano sudo

# XRDP aur XFCE setup
RUN adduser xrdp ssl-cert
RUN echo "xfce4-session" > ~/.xsession

# Bore Tunnel download aur install karein
RUN wget https://github.com/ekzhang/bore/releases/download/v0.4.1/bore-v0.4.1-x86_64-unknown-linux-musl.tar.gz && \
    tar -xf bore-v0.4.1-x86_64-unknown-linux-musl.tar.gz && \
    mv bore /usr/local/bin/ && \
    rm bore-v0.4.1-x86_64-unknown-linux-musl.tar.gz

# Ek RDP user banayein (Username: admin, Password: adminpassword)
RUN useradd -m -s /bin/bash admin && \
    echo "admin:adminpassword" | chpasswd && \
    usermod -aG sudo admin

# Start script copy karein
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Render default port
EXPOSE 10000

CMD ["/start.sh"]


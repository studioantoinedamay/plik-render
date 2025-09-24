# Image de base Ubuntu
FROM ubuntu:22.04

# Installer curl et unzip
RUN apt-get update && \
    apt-get install -y curl unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Télécharger le binaire Plik officiel et le placer dans /usr/local/bin
RUN curl -L -o /tmp/plik.zip https://github.com/root-gg/plik/releases/download/v1.3.8/plik-1.3.8-linux-amd64.zip && \
    unzip /tmp/plik.zip -d /tmp && \
    mv /tmp/plik-1.3.8-linux-amd64/server/plikd /usr/local/bin/plikd && \
    chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration
COPY plikd.cfg /plikd.cfg

# Exposer le port par défaut
EXPOSE 8080

# Lancer plikd
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

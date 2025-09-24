# Utiliser Ubuntu comme image de base
FROM ubuntu:22.04

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y curl tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Télécharger et extraire plikd officiel
RUN curl -L https://github.com/root-gg/plik/releases/download/v1.3.8/plik-1.3.8-linux-amd64.tar.gz \
    -o /tmp/plik.tar.gz && \
    tar -xzf /tmp/plik.tar.gz -C /tmp plik-1.3.8-linux-amd64/server/plikd && \
    mv /tmp/plik-1.3.8-linux-amd64/server/plikd /usr/local/bin/plikd && \
    chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration dans le container
COPY plikd.cfg /plikd.cfg

# Exposer le port par défaut
EXPOSE 8080

# Lancer plikd avec la configuration
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

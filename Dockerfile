# Utiliser Ubuntu 22.04 comme image de base
FROM ubuntu:22.04

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y curl tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Télécharger le binaire Plik officiel, l'extraire et le rendre exécutable
RUN curl -L -o /tmp/plik.tar.gz https://github.com/root-gg/plik/releases/download/v1.3.8/plik-1.3.8-linux-amd64.tar.gz && \
    tar -xzf /tmp/plik.tar.gz -C /tmp && \
    mv /tmp/plik-1.3.8-linux-amd64/server/plikd /usr/local/bin/plikd && \
    chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration Plik
COPY plikd.cfg /plikd.cfg

# Exposer le port par défaut
EXPOSE 8080

# Commande de lancement
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

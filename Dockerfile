# Image de base
FROM ubuntu:22.04

# Installer rclone et dépendances
RUN apt-get update && \
    apt-get install -y rclone ca-certificates curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration Plik
COPY plikd.cfg /plikd.cfg

# Copier l'interface web
COPY webapp/dist /webapp/dist

# Copier le script de démarrage
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exposer le port
EXPOSE 8080

# Lancer le script au démarrage
CMD ["/start.sh"]

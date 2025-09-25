# Image de base Ubuntu
FROM ubuntu:22.04

# Installer rclone et dépendances
RUN apt-get update && \
    apt-get install -y rclone ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire Plik
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration Plik
COPY plikd.cfg /plikd.cfg

# Copier le dossier webapp pour l'interface
COPY webapp/dist /webapp/dist

# Copier l'entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposer le port
EXPOSE 8080

# Utiliser l'entrypoint pour générer rclone.conf et lancer Plik
ENTRYPOINT ["/entrypoint.sh"]

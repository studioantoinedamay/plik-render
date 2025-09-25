# Image de base fournie par Render
FROM ubuntu:22.04

# Installer rclone et dépendances
RUN apt-get update && \
    apt-get install -y rclone ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration de Plik
COPY plikd.cfg /plikd.cfg

# Créer le dossier pour rclone et copier le fichier de configuration
RUN mkdir -p /root/.config/rclone
COPY rclone.conf /root/.config/rclone/rclone.conf

# Copier l'interface web
COPY webapp/dist /webapp/dist

# Exposer le port
EXPOSE 8080

# Lancer plikd avec la configuration
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

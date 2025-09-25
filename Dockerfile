# Base image
FROM ubuntu:22.04

# Installer rclone et ca-certificates
RUN apt-get update && \
    apt-get install -y rclone ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de config Plik
COPY plikd.cfg /plikd.cfg

# Créer le dossier pour rclone
RUN mkdir -p /root/.config/rclone

# Générer rclone.conf au démarrage
ENV RCLONE_CONF="/root/.config/rclone/rclone.conf"
CMD echo "[mega]" > $RCLONE_CONF && \
    echo "type = mega" >> $RCLONE_CONF && \
    echo "user = ${RCLONE_MEGA_USER}" >> $RCLONE_CONF && \
    echo "pass = ${RCLONE_MEGA_PASS}" >> $RCLONE_CONF && \
    /usr/local/bin/plikd --config /plikd.cfg

# Copier l'interface web
COPY webapp/dist /webapp/dist

# Exposer le port
EXPOSE 8080

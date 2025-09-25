# Image de base fournie par Render


FROM ubuntu:22.04


# Installer rclone et dépendances
RUN apt-get update && \
    apt-get install -y rclone ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd qui est déjà dans le repo
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration
COPY plikd.cfg /plikd.cfg

# Copier les fichiers de configuration
COPY plikd.cfg /plikd.cfg

# Créer le dossier pour rclone
RUN mkdir -p /root/.config/rclone

# Générer le rclone.conf à partir des variables d'environnement
RUN echo "[mega]" > /root/.config/rclone/rclone.conf && \
    echo "type = mega" >> /root/.config/rclone/rclone.conf && \
    echo "user = ${RCLONE_MEGA_USER}" >> /root/.config/rclone/rclone.conf && \
    echo "pass = ${RCLONE_MEGA_PASS}" >> /root/.config/rclone/rclone.conf

# Copier le dossier webapp/dist pour l’interface
COPY webapp/dist /webapp/dist

# Exposer le port
EXPOSE 8080

# Lancer plikd avec la configuration
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

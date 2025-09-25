# Image de base fournie par Render


FROM ubuntu:22.04


# Installer les dépendances
RUN apt-get update && \ apt-get install -y rclone ca-certificates && \ rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd qui est déjà dans le repo
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration
COPY plikd.cfg /plikd.cfg

# Copier les fichiers de configuration
COPY plikd.cfg /plikd.cfg
# Copier le fichier rclone.conf
COPY rclone.conf /root/.config/rclone/rclone.conf

# Copier le dossier webapp/dist pour l’interface
COPY webapp/dist /webapp/dist

# Exposer le port
EXPOSE 8080

# Lancer plikd avec la configuration
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

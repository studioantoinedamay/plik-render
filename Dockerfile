# Image de base
FROM ubuntu:22.04

# Installer rclone et dépendances
RUN apt-get update && \
    apt-get install -y rclone ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier la configuration plikd
COPY plikd.cfg /plikd.cfg

# Copier les fichiers pour l'interface web
COPY webapp/dist /webapp/dist

# Créer dossier rclone (vide, on génèrera le fichier au runtime)
RUN mkdir -p /root/.config/rclone

# Exposer le port
EXPOSE 8080

# Générer le fichier rclone.conf à partir des variables Render AU RUNTIME
CMD ["/bin/sh", "-c", "echo '[mega]\\ntype = mega\\nuser = $RCLONE_MEGA_USER\\npass = $RCLONE_MEGA_PASS' > /root/.config/rclone/rclone.conf && /usr/local/bin/plikd --config /plikd.cfg"]

# Image de base fournie par Render


FROM ubuntu:22.04


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \          # pour télécharger des fichiers si besoin
        tar \           # pour extraire des archives tar.gz
        unzip \         # pour extraire des fichiers zip
        rclone \        # pour connecter Plik à Mega
        ca-certificates \ # certificats SSL/TLS
        git \           # optionnel si tu veux cloner ou mettre à jour des repos
        wget \          # alternative à curl
        gnupg \         # utile pour certaines clés si besoin
        sudo \          # si commandes nécessitent sudo
    && rm -rf /var/lib/apt/lists/*

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

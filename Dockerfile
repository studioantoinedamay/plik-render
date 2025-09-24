FROM ubuntu:22.04

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copier le binaire plikd depuis ton repo
COPY plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration
COPY plikd.cfg /plikd.cfg

# Copier la webapp (si besoin)
COPY plik/webapp/dist /webapp/dist

# Exposer le port
EXPOSE 8080

# Commande de lancement
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

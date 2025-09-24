# Base image
FROM ubuntu:22.04

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y curl tar ca-certificates

# Copier l’exécutable Plik
COPY server/plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier la configuration
COPY server/plikd.cfg /plikd.cfg

# Exposer le port par défaut de Plik
EXPOSE 8080

# Commande pour lancer Plik au démarrage du container
CMD ["/usr/local/bin/plikd", "-c", "/plikd.cfg"]



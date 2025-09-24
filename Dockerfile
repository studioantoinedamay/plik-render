FROM ubuntu:22.04

# Installer les dépendances
RUN apt-get update && apt-get install -y curl tar ca-certificates

# Télécharger plikd officiel
RUN curl -L https://github.com/root-gg/plik/releases/download/v1.3.8/plik-1.3.8-linux-amd64.tar.gz \
    -o /tmp/plik.tar.gz && \
    tar -xzf /tmp/plik.tar.gz -C /usr/local/bin plik-1.3.8-linux-amd64/server/plikd && \
    chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration
COPY plikd.cfg /plikd.cfg

# Exposer le port
EXPOSE 8080

# Commande de lancement
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]



# Image de base Linux
FROM ubuntu:22.04

# Installer les dépendances
RUN apt-get update && apt-get install -y curl tar ca-certificates

# Copier l'exécutable Plik Linux et le rendre exécutable
COPY plik-1.3.8-linux-amd64/server/plikd /usr/local/bin/plikd
RUN chmod +x /usr/local/bin/plikd

# Copier le fichier de configuration
COPY plikd.cfg /plikd.cfg

# Exposer le port par défaut
EXPOSE 8080

# Commande de lancement
CMD ["/usr/local/bin/plikd", "--config", "/plikd.cfg"]

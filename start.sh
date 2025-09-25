#!/bin/bash

# Créer le dossier de configuration rclone
mkdir -p /root/.config/rclone

# Générer dynamiquement rclone.conf à partir des variables d'environnement
cat <<EOF >/root/.config/rclone/rclone.conf
[mega]
type = mega
user = ${RCLONE_MEGA_USER}
pass = ${RCLONE_MEGA_PASS}
EOF

echo "rclone.conf créé avec succès"

# Lancer Plik
exec /usr/local/bin/plikd --config /plikd.cfg

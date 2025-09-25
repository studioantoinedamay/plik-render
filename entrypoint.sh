#!/bin/bash
set -e

# Créer le dossier de config Rclone
mkdir -p /root/.config/rclone

# Générer rclone.conf à partir des variables d'environnement
cat <<EOF > /root/.config/rclone/rclone.conf
[mega]
type = mega
user = ${RCLONE_MEGA_USER}
pass = ${RCLONE_MEGA_PASS}
EOF

echo "[INFO] rclone.conf créé avec succès."

# Lancer Plik avec la config
exec /usr/local/bin/plikd --config /plikd.cfg

#!/bin/bash
mkdir -p /root/.config/rclone
cat <<EOF > /root/.config/rclone/rclone.conf
[mega]
type = mega
user = ${RCLONE_MEGA_USER}
pass = ${RCLONE_MEGA_PASS}
EOF

# Lancer Plik
exec /usr/local/bin/plikd --config /plikd.cfg

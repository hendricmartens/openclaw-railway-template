#!/bin/bash
set -e

chown -R openclaw:openclaw /data
chmod 700 /data

if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi

rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

# Ensure acpx config exists with correct defaults
mkdir -p /home/openclaw/.acpx
cat > /home/openclaw/.acpx/config.json << 'ACPX'
{"defaultAgent":"claude","defaultPermissions":"approve-all","nonInteractivePermissions":"deny","authPolicy":"skip","ttl":300}
ACPX
chown -R openclaw:openclaw /home/openclaw/.acpx

exec gosu openclaw node src/server.js
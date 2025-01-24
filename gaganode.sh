#!/bin/sh

TOKEN="obqbmxayydohqrhc9a977e15c9875e03"

cat <<'EOF'
   ____          ____         _   _             _
  / ___|  __ _  / ___|  __ _ | \ | |  ___    __| |  ___
 | |  _  / _` || |  _  / _` ||  \| | / _ \  / _` | / _ \
 | |_| || (_| || |_| || (_| || |\  || (_) || (_| ||  __/
  \____| \__,_| \____| \__,_||_| \_| \___/  \__,_| \___|
EOF

APPHUB_DIR="./apphub-linux"
if [ -d $APPHUB_DIR ]; then
    echo "Found apphub-linux directory: $APPHUB_DIR"
    cd "$APPHUB_DIR" || { echo "Failed to change directory to $APPHUB_DIR"; exit 1; }
else
    echo "apphub-linux directory not found."
    exit 1
fi

sudo ./apphub service remove && \
sudo ./apphub service install && \
sudo ./apphub service start

echo "\nNode Starting"
sleep 15

sudo ./apphub status && \
sudo ./apps/gaganode/gaganode config set --token="$TOKEN" && \
sudo ./apphub restart

sleep 15
sudo ./apphub status && \
sudo ./apphub log && \
sudo ./apps/gaganode/gaganode log

echo "\nToken: $TOKEN"

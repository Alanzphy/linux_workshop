#!/bin/bash

sudo apt-get update
sudo apt-get install -y figlet

mkdir -p ./system/legacy/backups/2026/hidden_config/auth/

if [ ! -z "$DISCORD_WEBHOOK" ]; then
    echo "$DISCORD_WEBHOOK" > ./system/legacy/backups/2026/hidden_config/auth/credenciales_discord.txt
fi
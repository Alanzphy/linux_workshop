#!/bin/bash

sudo apt-get update
sudo apt-get install -y figlet

# 2. Creamos el laberinto para la Búsqueda del Tesoro
# (Se creará una estructura de carpetas confusa dentro de su espacio de trabajo)
mkdir -p ./system/legacy/backups/2026/hidden_config/auth/

# 3. La Magia: Usamos la variable de entorno para crear el archivo localmente
# Si el secreto existe, lo guardamos en el archivo escondido.
if [ ! -z "$DISCORD_WEBHOOK" ]; then
    echo "$DISCORD_WEBHOOK" > ./system/legacy/backups/2026/hidden_config/auth/auth/credenciales_discord.txt
fi
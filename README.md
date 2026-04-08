

### Fase 1: Reconocimiento y Extracción
Encontrar la URL (Webhook) escondida.

* **`pwd`** : Para saber en qué ruta exacta te encuentras.
* **`ls -la`** : Lista todos los archivos (incluso los ocultos).
* **`cd <carpeta>`** : Para entrar a los directorios. (Usa `cd ..` para retroceder).
* **`find . -name "*.txt"`** : Busca en todo tu sistema cualquier archivo de texto.
* **`cat <archivo>`** : Lee el contenido de un archivo.

---

### Fase 2: Interceptando datos
Nos vamos a conectar al flujo de datos de los sensores y a guardar la evidencia.

**1. Ver el flujo:**
```bash
curl -sN https://iot-proxy.alan2203mx.workers.dev/stream
```

**2. Filtrar los datos (buscando en una zona especifica):**
```bash
curl -sN https://iot-proxy.alan2203mx.workers.dev/stream | grep --line-buffered "ZONA_NORTE"
```

**3. Creamos un archivo para guardar los datos filtrados**
```bash
curl -sN https://iot-proxy.alan2203mx.workers.dev/stream >> riego.log
```

_Presiona `Ctrl + \` para dividir la pantalla en dos. En el nuevo panel derecho, ejecuta `tail -f riego.log` para ver los datos en tiempo real.


### Fase 3: Creamos el script

**1. Abre el editor de texto:**

```bash
nano vigilante.sh
```

**2. El Código del "Vigilante" (Copia, pega y edita la URL de Discord):**
```bash
#!/bin/bash

WEBHOOK_URL="https://discord.com/api/webhooks/TU_URL_AQUI"

ULTIMA_LECTURA=$(grep "$1" riego.log | tail -n 1)
HUMEDAD=$(echo "$ULTIMA_LECTURA" | awk '{print $10}' | tr -d '%')

if [ -z "$HUMEDAD" ]; then
    echo "No hay datos para la zona: $1"
    exit 1
fi
if [ "$HUMEDAD" -lt 30 ]; then
    clear
    figlet "CRITICO"
    echo -e '\a'
    echo "Peligro en $1! la humedad esta al $HUMEDAD%"
    MENSAJE="Emergencia en $1: Humedad critica del $HUMEDAD%."
    curl -s -H "Content-Type: application/json" \
    -d "{\"content\":\"$MENSAJE\"}" \
    "$WEBHOOK_URL" > /dev/null
else
    echo "$1 estable, humedad al $HUMEDAD%."
fi
```
(Para guardar en nano: Presiona `Ctrl+O`, luego `Enter`. Para salir: `Ctrl+X`).

**3. Dale (Permisos de ejecución):**

```bash
chmod +x vigilante.sh
```

**4.Pruébalo pasándole una Zona como parámetro:**
```bash
./vigilante.sh ZONA_NORTE
```

**5. Atajo con Alias:**  Creamos un comando personalizado que reemplace todo lo anterior:

```bash
alias auditar='./vigilante.sh'
```

### Fase 4: Monitoreo Activo

Para no tener que escribir el comando a mano cada vez, obligaremos a Linux a ejecutar el  comando cada 2 segundos

```bash
watch -n 2 ./vigilante.sh ZONA_SUR
```

```bash
crontab -e
```

2. Agrega esta línea para ejecutar el script cada minuto:

```bash
* * * * * cd /ruta/a/tu/proyecto && ./vigilante.sh ZONA_SUR >> cron.log 2>&1
```


Por ultimo
registrate en el servidor enviando una peticion **Cambia "TuNombre" por tu nombre real o nickname (sin espacios).**


```bash
curl -X POST -d "alumno=TuNombre" https://board.alan2203mx.workers.dev/graduar
```

#!/bin/bash

# 1. Verificación de Superusuario (Sudo)
if [ "$(id -u)" -ne 0 ]; then
  echo "❌ Error: Por favor ejecuta este script con sudo."
  echo "   Uso: sudo sh ./usb_transf_optimization.sh"
  exit 1
fi

echo "--- Iniciando Optimización de Escritura USB (Linux Mint) ---"

# 2. Definir el valor: 350 MB en bytes
# 350 * 1024 * 1024 = 367001600 bytes (aproximado a 350.000.000 para redondear)
VALOR_BYTES="350000000"

# 3. Crear un archivo de configuración dedicado
# Usamos /etc/sysctl.d/ para no ensuciar el archivo principal del sistema.
ARCHIVO_CONF="/etc/sysctl.d/99-optimization-usb.conf"

echo "📝 Creando configuración en: $ARCHIVO_CONF"

# Escribimos las reglas en el archivo
bash -c "cat > $ARCHIVO_CONF" <<EOF
# Mejora para transferencia USB y feedback real
# Limita la caché de escritura a aprox 350MB
vm.dirty_bytes = $VALOR_BYTES
vm.dirty_background_bytes = $VALOR_BYTES
EOF

# 4. Recargar la configuración del sistema para aplicar cambios ya
echo "🔄 Aplicando cambios en el Kernel..."
sysctl --system > /dev/null 2>&1

echo "✅ ¡Éxito! La caché de memoria se ha ajustado a 350 MB."

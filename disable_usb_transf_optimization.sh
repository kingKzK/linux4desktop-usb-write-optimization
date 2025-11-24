#!/bin/bash

# 1. Verificación de Superusuario
if [ "$EUID" -ne 0 ]; then
  echo "❌ Error: Por favor ejecuta este script con sudo."
  echo "   Uso: sudo sh ./disable_usb_transf_optimization.sh"
  exit 1
fi

echo "--- Restaurando Configuración de Fábrica ---"

ARCHIVO_CONF="/etc/sysctl.d/99-optimization-usb.conf"

# 2. Verificar si el archivo existe y borrarlo
if [ -f "$ARCHIVO_CONF" ]; then
    echo "🗑️  Eliminando archivo de configuración personalizado..."
    rm "$ARCHIVO_CONF"
else
    echo "⚠️  No se encontró configuración personalizada. El sistema ya podría estar original."
fi

# 3. Importante: Restablecer valores en memoria RAM ahora mismo
# Al poner dirty_bytes en 0, el kernel vuelve a usar dirty_ratio (el comportamiento por defecto)
echo "🔄 Reseteando Kernel a valores por defecto..."
sysctl vm.dirty_bytes=0
sysctl vm.dirty_background_bytes=0

# Recargamos todo el sistema para asegurar
sysctl --system > /dev/null 2>&1

echo "✅ ¡Listo! El sistema ha vuelto a la normalidad (Caché por defecto)."

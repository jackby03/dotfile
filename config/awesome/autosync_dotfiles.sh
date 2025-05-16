#!/bin/bash
# Script para copiar toda la configuración de AwesomeWM a tu repositorio de dotfiles

SRC_DIR="$HOME/.config/awesome"
DST_DIR="$HOME/Downloads/dotfiles/config/awesome"

# Crear el destino si no existe
mkdir -p "$DST_DIR"

# Copiar todos los archivos y carpetas, preservando estructura y permisos, pero sin eliminar .git
rsync -av --delete --ignore-times "$SRC_DIR/" "$DST_DIR/"

echo "Copia completada de $SRC_DIR a $DST_DIR"

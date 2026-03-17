#!/bin/bash
# ======================================
# SIMULADOR DE "SERVIDOR ROTO"
# Práctica Linux para DAM
# ======================================
echo "----------------------------------"
echo "CREANDO SERVIDOR ROTO PARA PRACTICA"
echo "----------------------------------"

echo "Creando usuarios..."
useradd -m dev1
echo "dev1:1234" | chpasswd
useradd -m front1
echo "front1:1234" | chpasswd
useradd -m qa1
echo "qa1:1234" | chpasswd

echo "Usuarios creados (incompletos)"

echo "Creando grupos..."
groupadd backend
groupadd qa

echo "Grupos creados (incompletos)"

echo "Creando estructura del proyecto..."
mkdir -p /opt/taskflow
mkdir -p /opt/taskflow/frontend
mkdir -p /opt/taskflow/mobile
mkdir -p /opt/taskflow/logs

echo "Estructura creada con errores"

echo "Asignando propietarios incorrectos..."
chown dev1:qa /opt/taskflow/frontend

echo "Aplicando permisos incorrectos..."

chmod 777 /opt/taskflow/frontend
chmod 777 /opt/taskflow/mobile

echo "Creando proceso que consume recursos..."
sleep 10000 &

echo "Instalando nginx..."
apt update -y
apt install nginx -y

echo "Deteniendo servicio nginx..."
systemctl stop nginx

systemctl disable nginx
echo "----------------------------------"
echo "SERVIDOR ROTO CREADO"
echo "----------------------------------"
echo ""
echo "Errores introducidos:"
echo ""
echo "1. Falta usuario dev2"
echo "2. Usuario dev1 sin grupo backend"
echo "3. Grupo frontend inexistente"
echo "4. Carpeta /opt/taskflow/backend inexistente"
echo "5. Propietarios incorrectos"
echo "6. Permisos 777 inseguros"
echo "7. Usuario sin acceso correcto"
echo "8. Proceso sleep ejecutándose"
echo "9. Servicio nginx detenido"
echo "10. nginx no habilitado al inicio"
echo "11. estructura incompleta"
echo "12. permisos incorrectos en carpetas"
echo ""
echo "Los alumnos deben diagnosticar y arreglar el sistema."
echo ""

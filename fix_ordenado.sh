#!/bin/bash
# ====================================================
# SCRIPT DE RESOLUCIÓN - SERVIDOR TASKFLOW
# Solución a la Práctica Linux para DAM
# ====================================================
#
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

echo "Iniciando diagnóstico y reparación del sistema..."

# 1. Falta usuario dev2
echo "-> 1. Creando usuario dev2 (y asignando contraseña base)..."
sudo useradd -m dev2
echo "dev2:1234" | sudo chpasswd

# 3. Grupo frontend inexistente (Lo creamos antes de asignar el usuario)
echo "-> 3. Creando grupo frontend..."
sudo groupadd frontend

# 2. Usuario dev1 sin grupo backend (Y aprovechamos para organizar al resto)
echo "-> 2. Asignando usuarios a sus grupos correspondientes..."
sudo usermod -aG backend dev1
sudo usermod -aG backend dev2
sudo usermod -aG frontend front1

# 4 y 11. Carpeta /opt/taskflow/backend inexistente y estructura incompleta
echo "-> 4 y 11. Creando la estructura de carpetas faltante..."
sudo mkdir -p /opt/taskflow/backend

# 5 y 7. Propietarios incorrectos y usuario sin acceso correcto
echo "-> 5 y 7. Corrigiendo propietarios para asegurar el acceso..."
# Frontend estaba asignado a dev1:qa. Lo pasamos a su dueño y grupo reales.
sudo chown front1:frontend /opt/taskflow/frontend
# Asignamos el backend al equipo de backend
sudo chown dev1:backend /opt/taskflow/backend
# Asignamos mobile y logs al equipo de QA para que tengan control
sudo chown qa1:qa /opt/taskflow/mobile
sudo chown qa1:qa /opt/taskflow/logs

# 6 y 12. Permisos 777 inseguros y permisos incorrectos
echo "-> 6 y 12. Eliminando permisos 777 y aplicando 770 (Trabajo en equipo)..."
sudo chmod 770 /opt/taskflow/frontend
sudo chmod 770 /opt/taskflow/mobile
sudo chmod 770 /opt/taskflow/backend
sudo chmod 770 /opt/taskflow/logs

# 8. Proceso sleep ejecutándose
echo "-> 8. Deteniendo procesos zombi/consumidores de recursos..."
sudo pkill sleep

# 9. Servicio nginx detenido
echo "-> 9. Arrancando el servicio web nginx..."
sudo systemctl start nginx

# 10. nginx no habilitado al inicio
echo "-> 10. Habilitando nginx en el arranque del sistema..."
sudo systemctl enable nginx

echo "----------------------------------"
echo "¡TODOS LOS ERRORES SOLUCIONADOS!"
echo "El servidor TaskFlow vuelve a ser seguro y operativo."
echo "----------------------------------"

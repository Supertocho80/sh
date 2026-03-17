#!/bin/bash
# ====================================================
# RESOLUCIÓN PASO A PASO - SERVIDOR TASKFLOW
# ====================================================

echo "Iniciando reparación secuencial del sistema..."

# 1. Falta usuario dev2
echo "1. Creando usuario dev2..."
sudo useradd -m dev2
echo "dev2:1234" | sudo chpasswd

# 2. Usuario dev1 sin grupo backend
echo "2. Añadiendo dev1 al grupo backend..."
sudo usermod -aG backend dev1

# 3. Grupo frontend inexistente
echo "3. Creando el grupo frontend..."
sudo groupadd frontend

# 4. Carpeta /opt/taskflow/backend inexistente
echo "4. Creando carpeta backend..."
sudo mkdir -p /opt/taskflow/backend

# 5. Propietarios incorrectos
# (El script original asignó chown dev1:qa a la carpeta frontend)
echo "5. Corrigiendo propietario de la carpeta frontend..."
sudo chown front1:frontend /opt/taskflow/frontend

# 6. Permisos 777 inseguros
# (El script original puso 777 a frontend y mobile)
echo "6. Eliminando permisos 777 inseguros..."
sudo chmod 770 /opt/taskflow/frontend
sudo chmod 770 /opt/taskflow/mobile

# 7. Usuario sin acceso correcto
# (Los usuarios necesitan pertenecer a sus grupos para acceder a las carpetas con permisos 770)
echo "7. Asignando usuarios restantes a sus grupos para garantizar acceso..."
sudo usermod -aG frontend front1
sudo usermod -aG backend dev2
# qa1 ya tiene su grupo primario 'qa' por defecto, pero lo aseguramos
sudo usermod -aG qa qa1

# 8. Proceso sleep ejecutándose
echo "8. Matando el proceso sleep que consume recursos..."
sudo pkill sleep

# 9. Servicio nginx detenido
echo "9. Iniciando el servicio nginx..."
sudo systemctl start nginx

# 10. nginx no habilitado al inicio
echo "10. Habilitando nginx para que arranque con el sistema..."
sudo systemctl enable nginx

# 11. Estructura incompleta
# (Faltan asignar dueños lógicos al resto de carpetas para completar la estructura)
echo "11. Completando la estructura organizativa de las carpetas..."
sudo chown dev1:backend /opt/taskflow/backend
sudo chown qa1:qa /opt/taskflow/mobile
sudo chown qa1:qa /opt/taskflow/logs

# 12. Permisos incorrectos en carpetas
# (Aseguramos que TODAS las carpetas tengan el nivel de seguridad adecuado)
echo "12. Aplicando permisos definitivos de trabajo en equipo a todas las carpetas..."
sudo chmod 770 /opt/taskflow/backend
sudo chmod 770 /opt/taskflow/logs
# Damos permisos base a la carpeta raíz del proyecto
sudo chmod 755 /opt/taskflow

echo "----------------------------------"
echo "REPARACIÓN COMPLETADA DEL PASO 1 AL 12."
echo "----------------------------------"

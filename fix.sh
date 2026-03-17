#!/bin/bash
# ==========================================
# OPERACIÓN: RESCATE DEL SERVIDOR TASKFLOW
# SysAdmin Responsable: Gemini
# ==========================================

echo "Iniciando protocolo de rescate del sistema..."

# ------------------------------------------
# 1. RECONSTRUCCIÓN DE IDENTIDADES Y GRUPOS
# ------------------------------------------
echo "Restaurando usuarios y grupos faltantes..."

# Crear el grupo frontend que no existía
sudo groupadd frontend

# Crear el usuario dev2 con su directorio personal (/home)
sudo useradd -m dev2

# Asignar a los usuarios a sus grupos de trabajo correspondientes (Append Groups)
sudo usermod -aG backend dev1
sudo usermod -aG backend dev2
sudo usermod -aG frontend front1

# (Opcional pero recomendado según la topología de la empresa)
# Completar el resto del equipo frontend y mobile
sudo useradd -m front2
sudo usermod -aG frontend front2
sudo groupadd mobile
sudo useradd -m mobile1
sudo usermod -aG mobile mobile1


# ------------------------------------------
# 2. INTEGRIDAD ESTRUCTURAL
# ------------------------------------------
echo "Completando la arquitectura de directorios..."

# Crear las carpetas faltantes en el proyecto TaskFlow
sudo mkdir -p /opt/taskflow/backend
sudo mkdir -p /opt/taskflow/database


# ------------------------------------------
# 3. BLINDAJE DE ACCESO Y SEGURIDAD
# ------------------------------------------
echo "Aplicando políticas de seguridad y corrigiendo propietarios..."

# Transferir la propiedad correcta (Usuario:Grupo) a cada directorio
sudo chown dev1:backend /opt/taskflow/backend
sudo chown front1:frontend /opt/taskflow/frontend
sudo chown mobile1:mobile /opt/taskflow/mobile

# Modificar permisos al nivel "Trabajo en Equipo" (770)
# Propietario y Grupo tienen control total (rwx), otros no tienen acceso.
sudo chmod 770 /opt/taskflow/backend
sudo chmod 770 /opt/taskflow/frontend
sudo chmod 770 /opt/taskflow/mobile


# ------------------------------------------
# 4. MONITORIZACIÓN Y LIMPIEZA DE PROCESOS
# ------------------------------------------
echo "Neutralizando procesos intrusos..."

# Terminar el proceso rebelde que consume recursos
sudo pkill sleep


# ------------------------------------------
# 5. INFRAESTRUCTURA Y SERVICIOS
# ------------------------------------------
echo "Levantando servicios críticos..."

# Arrancar el servicio nginx
sudo systemctl start nginx

# Habilitar nginx para que arranque automáticamente al inicio del sistema
sudo systemctl enable nginx

echo "=========================================="
echo "¡RESCATE COMPLETADO CON ÉXITO!"
echo "El ecosistema ahora es seguro."
echo "=========================================="

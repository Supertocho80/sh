echo "1. Falta usuario dev2"
useradd -m dev2
echo "dev2:1234" | chpasswd

echo "2. Usuario dev1 sin grupo backend"
usermod -aG backend dev1

echo "3. Grupo frontend inexistente"
groupadd frontend

echo "4. Carpeta /opt/taskflow/backend inexistente"
mkdir -p /opt/taskflow/backend

echo "5. Propietarios incorrectos"
chown dev1:backend /opt/taskflow/backend
chown front1:frontend /opt/taskflow/frontend

echo "6. Permisos 777 inseguros"
chmod 770 /opt/taskflow/frontend
chmod 770 /opt/taskflow/mobile

echo "7. Usuario sin acceso correcto"
usermod -aG frontend front1

echo "8. Proceso sleep ejecutándose"
pkill sleep

echo "9. Servicio nginx detenido"
systemctl start nginx

echo "10. nginx no habilitado al inicio"
systemctl enable nginx

echo "11. estructura incompleta"
mkdir -p /opt/taskflow/database

echo "12. permisos incorrectos en carpetas"
chmod 770 /opt/taskflow/backend
chmod 770 /opt/taskflow/database
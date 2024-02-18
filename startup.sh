#!/bin/bash

su - oracle

# Establecer variables de entorno
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export ORACLE_SID=XE
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib

# Ajustar los permisos del directorio de logs
mkdir -p /opt/oracle/homes/OraDBHome21cXE/network/log/
chown oracle:oinstall /opt/oracle/homes/OraDBHome21cXE/network/log/
chmod 775 /opt/oracle/homes/OraDBHome21cXE/network/log/

# Iniciar el listener de Oracle
lsnrctl start 

# Iniciar la base de datos (opcionalmente, también puedes colocar aquí más comandos SQLPlus)
sqlplus / as sysdba <<EOF
STARTUP;
EXIT;
EOF

# Ejecutar el script de configuración de la base de datos
sqlplus / as sysdba @/home/oracle/sql_scripts/configure_database.sql

# Mantener el contenedor corriendo (si es necesario, dependiendo de tu configuración)
tail -f /dev/null

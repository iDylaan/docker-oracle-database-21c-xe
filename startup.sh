#!/bin/bash

# Configurar Oracle
/etc/init.d/oracle-xe-21c configure <<EOF
SYS_DBA_ADMIN_UTN
SYS_DBA_ADMIN_UTN
EOF

# Establecer variables de entorno
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export ORACLE_SID=XE
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export TNS_ADMIN=$ORACLE_HOME/network/admin
export LISTENER_ORA_PATH=$ORACLE_HOME/network/admin/samples/listener.ora

# Iniciar el listener de Oracle
lsnrctl start 

# Iniciar la base de datos (opcionalmente, también puedes colocar aquí más comandos SQLPlus)
sqlplus sys/SYS_DBA_ADMIN_UTN@XE as sysdba <<EOF
SELECT status FROM v\$instance;
EXIT;
EOF

# Mantener el contenedor corriendo (si es necesario, dependiendo de tu configuración)
tail -f /dev/null

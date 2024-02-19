#!/bin/bash

# Variables de entorno de Oracle
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export ORACLE_SID=XE
export ORACLE_CHARACTERSET=AL32UTF8 

# Establecer variables de entorno
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export TNS_ADMIN=$ORACLE_HOME/network/admin
export LISTENER_ORA_PATH=$ORACLE_HOME/network/admin/samples/listener.ora

# Configurar Oracle
# Verificar si la base de datos ya está configurada
if [ -f "/opt/oracle/config/.oracle_configured" ]; then
    echo "Oracle Database ya está configurada, omitiendo la configuración inicial."

    # Ejecutar comandos como el usuario oracle
    su - oracle -c "bash -c '
echo \"Configurando entorno Oracle\"
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib
export PATH=\$ORACLE_HOME/bin:\$PATH
export TNS_ADMIN=\$ORACLE_HOME/network/admin
export ORACLE_SID=XE

echo \"export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE\" >> ~/.bashrc
echo \"export LD_LIBRARY_PATH=\$ORACLE_HOME/lib\" >> ~/.bashrc
echo \"export PATH=\$ORACLE_HOME/bin:\$PATH\" >> ~/.bashrc
echo \"export TNS_ADMIN=\$ORACLE_HOME/network/admin\" >> ~/.bashrc

# No es necesario llamar a source ~/.bashrc aquí, ya que las variables ya están exportadas para esta sesión

# Iniciar el listener de Oracle
lsnrctl start

# Conectar a SQL*Plus y ejecutar comandos SQL
sqlplus / as sysdba <<EOF
startup;
alter system register;
exit;
EOF
'"

    export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
    export PATH=$ORACLE_HOME/bin:$PATH

    # Iniciar la base de datos (opcionalmente, también puedes colocar aquí más comandos SQLPlus)
    sqlplus sys/SYS_DBA_ADMIN_UTN@XE as sysdba <<EOF
SELECT status FROM v\$instance;
EXIT;
EOF

    # Mantener el contenedor corriendo (si es necesario, dependiendo de tu configuración)
    tail -f /dev/null

else
    echo "Configurando Oracle Database por primera vez..."
    mkdir -p /opt/oracle/config/
    # Coloca aquí los comandos de configuración inicial
    /etc/init.d/oracle-xe-21c configure <<EOF
SYS_DBA_ADMIN_UTN
SYS_DBA_ADMIN_UTN
EOF
    # Marcar la instancia como configurada para futuros inicios
    touch /opt/oracle/config/.oracle_configured

    # Configurar permisos de directorio para logs del listener
    mkdir -p /opt/oracle/homes/OraDBHome21cXE/network/log
    chown -R oracle:oinstall /opt/oracle/homes/OraDBHome21cXE
    chmod -R 775 /opt/oracle/homes/OraDBHome21cXE

    # Iniciar el listener de Oracle
    lsnrctl start 

    # Iniciar la base de datos (opcionalmente, también puedes colocar aquí más comandos SQLPlus)
    sqlplus sys/SYS_DBA_ADMIN_UTN@XE as sysdba <<EOF
SELECT status FROM v\$instance;
EXIT;
EOF

# Mantener el contenedor corriendo (si es necesario, dependiendo de tu configuración)
tail -f /dev/null

fi
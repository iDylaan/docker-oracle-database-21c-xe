FROM oraclelinux:8

# Establecer variables de entorno para la configuración automática
ENV ORACLE_DOCKER_INSTALL=true \
    ORACLE_BASE=/opt/oracle \
    ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE \
    ORACLE_SID=XE \
    ORACLE_PDB=XEPDB1 \
    ORACLE_PWD=SYS_DBA_ADMIN_UTN \
    ORACLE_CHARACTERSET=AL32UTF8

COPY oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm /tmp/

# Instalar las herramientas necesarias y limpiar la caché de yum en un solo paso
RUN yum -y update && \
    yum install -y expect && \
    yum -y install oracle-database-preinstall-21c && \
    yum -y localinstall /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm && \
    yum clean all

# Copiar los scripts locales y el archivo RPM de Oracle Database 21c XE al contenedor
COPY ./install-package.sh /tmp/install-package.sh
COPY ./db_install.rsp /tmp/db_install.rsp
COPY startup.sh /usr/local/bin/startup.sh

# Dar permiso de ejecución a los scripts
RUN chmod +x /tmp/install-package.sh /usr/local/bin/startup.sh /home/oracle/sql_scripts/config_database.sh /home/oracle/sql_scripts/startup_database.sh

# Ejecutar el script de instalación de paquetes adicionales
RUN /tmp/install-package.sh

# Cambiar la propiedad y ajustar los permisos de los directorios de Oracle
RUN chown -R oracle:oinstall /opt/oracle/ && chmod -R 775 /opt/oracle/

# Cambiar la propiedad y ajustar los permisos de oradism
RUN chown root:root /opt/oracle/product/21c/dbhomeXE/bin/oradism && \
    chmod 4755 /opt/oracle/product/21c/dbhomeXE/bin/oradism

# Exponer el puerto por defecto de Oracle
EXPOSE 1521

# Configurar el script para que se ejecute al iniciar el contenedor
CMD ["/usr/local/bin/startup.sh"]



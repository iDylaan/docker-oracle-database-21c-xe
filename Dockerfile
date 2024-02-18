FROM oraclelinux:8

# Establecer la variable de entorno necesaria para la instalación de Oracle en Docker
ENV ORACLE_DOCKER_INSTALL=true

# Instalar las herramientas necesarias y limpiar la caché de yum para mantener el tamaño de la imagen al mínimo
RUN yum -y update && \
    yum -y install oracle-database-preinstall-21c && \
    yum clean all

# Copiar los scripts locales y el archivo RPM de Oracle Database 21c XE al contenedor
COPY ./install-package.sh /tmp/install-package.sh
COPY ./db_install.rsp /tmp/db_install.rsp
COPY oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm /tmp/
COPY startup.sh /usr/local/bin/startup.sh
COPY scripts /home/oracle/sql_scripts

# Dar permiso de ejecución a los scripts
RUN chmod +x /tmp/install-package.sh /usr/local/bin/startup.sh /home/oracle/sql_scripts/config_database.sh /home/oracle/sql_scripts/startup_database.sh

# Ejecutar el script de instalación de paquetes adicionales
RUN /tmp/install-package.sh

# Instalar Oracle Database 21c XE
RUN yum -y localinstall /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# Cambiar la propiedad y ajustar los permisos de los directorios de Oracle
RUN chown -R oracle:oinstall /opt/oracle/ && chmod -R 775 /opt/oracle/

# Exponer el puerto por defecto de Oracle
EXPOSE 1521

# Configurar el script para que se ejecute al iniciar el contenedor
CMD ["/usr/local/bin/startup.sh"]



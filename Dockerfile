FROM oraclelinux:8

# Establecer variables de entorno para la configuración automática
ENV ORACLE_DOCKER_INSTALL=true 

# Copiar los scripts locales y el archivo RPM de Oracle Database 21c XE al contenedor
COPY oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm /tmp/
COPY ./install-package.sh /tmp/install-package.sh
COPY startup.sh /usr/local/bin/startup.sh

# Dar permiso de ejecución a los scripts
RUN chmod +x /tmp/install-package.sh /usr/local/bin/startup.sh

# Ejecutar el script de instalación de paquetes adicionales
RUN /tmp/install-package.sh

# Instalar las herramientas necesarias y limpiar la caché de yum en un solo paso
RUN dnf -y update && \
    dnf -y install oracle-database-preinstall-21c && \
    dnf -y localinstall /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm && \
    dnf clean all && \
    rm -f /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm && \
    rm -f /tmp/install-package.sh

# Cambiar la propiedad y ajustar los permisos de oradism
RUN chown root:root /opt/oracle/product/21c/dbhomeXE/bin/oradism && \
    chmod 4755 /opt/oracle/product/21c/dbhomeXE/bin/oradism

# Exponer el puerto por defecto de Oracle
EXPOSE 1521

# Configurar el script para que se ejecute al iniciar el contenedor
CMD ["/usr/local/bin/startup.sh"]



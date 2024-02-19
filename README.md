# Docker con Oracle Database 21c Express Edition

Se trata de un Docker Image lista para usar que contiene la base de datos Oracle 21c XE sobre Oracle Linux 8.4. El tamaño de esta imagen es de aprox. 9.1 GB comprimida, ya que la BD se instala con otro software.

## Prerequisitos

- Al menos 4 GB de RAM
- Al menos 25 GB de almacenamiento disponible
- Tener instalado WSL -> en caso de windows `wsl --install` ([Guía](https://www.youtube.com/shorts/ddfLijQ1t88))
- Tener instalado [Docker](https://docs.docker.com/get-docker/)
    - En Windows ([Guía](https://www.youtube.com/shorts/ddfLijQ1t88))
    - En MacOS ([Guía](https://www.youtube.com/watch?v=a30Enh1_aWI))
- Tener descargado [Oracle Database 21c Express Edition for Linux x64 (OL8)](https://www.oracle.com/mx/database/technologies/xe-downloads.html)

## Ejecutar Contenedor en Docker

Verifica si Docker Engine se está ejecutando:
*Se ejecuta cuando inicias Docker Desktop*

    +++bash
    docker info
    +++

**Si no lo está, reiniciar el equipo y comprueba nuevamente.**

*Si hay conexión con Docker, sigue los siguientes pasos:*

1. Arrastrar el `.rpm` de ***Oracle Database 21c Express Edition for Linux x64 (OL8)*** en la carpeta raíz, debería quedar algo así:  
   ![](./static/imgs/ODBS21cXE-Screenshot.png)

***Es necesario ejecutar los comandos desde la ruta raíz del proyecto, donde se encuentra el Dockerfile.***

2. Construir la imagen docker:

    +++bash
    docker build -t oracle-21c-xe .
    +++

   ![](./static/imgs/DockerBuildBASH.png)

3. Ejecutar el contenedor por primera vez:

    +++bash
    docker run -d -p 1521:1521 --name oracle-db oracle-21c-xe
    +++

4. Revisar la inicialización de la base de datos:

    +++bash
    docker logs -f oracle-db
    +++

***Esto puede tardar varios minutos***, pero debes esperar hasta que cargue por completo y veas algo como esto:  
![](./static/imgs/ODBS21cXELogger-Screenshot.png)

**¡Listo!** Ya puedes conectarte desde tu IDE preferido a Oracle Database 21c Express Edition. Ya puedes cerrar la terminal.

Para iniciar nuevamente el contenedor *(Esto se usa una vez detienes el contenedor y lo quieres volver a iniciar)*:

    +++bash
    docker start oracle-db
    +++

## **VARIABLES DE CONEXIÓN**

- Tipo: SYS_DBA
- Port: 1521
- SID: XE
- Username: sys
- Password: SYS_DBA_ADMIN_UTN

## Comandos Útiles

Verificar el contenedor:

    +++bash
    docker ps
    +++

Logs del contenedor *(Si necesitas ver los logs del contenedor)*:

    +++bash
    docker logs oracle-db
    +++

Iniciar el contenedor con el Bash desde la terminal:

    +++bash
    docker run -it --name oracle-db-test oracle-21c-xe bash
    +++

Detener el contenedor:

    +++bash
    docker stop oracle-db
    +++

Eliminar el contenedor:

    +++bash
    docker rm oracle-db
    +++

Conectarse a la Base de Datos de Oracle como el SYS_DBA *(Desde el CLI en la terminal)*:

    +++bash
    sqlplus sys/SYS_DBA_ADMIN_UTN@XE as sysdba
    +++

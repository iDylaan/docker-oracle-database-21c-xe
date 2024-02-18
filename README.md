# Pasos para ejecutar el docker con Oracle Database 21c Express Edition

*Verifica si Docker está ejecutándose*
```bash
docker info
```
*Si hay contexión con Docker sigue los siguientes pasos:*
-----------------------------------------------------------
## Contruir la Imagen Docker
```bash
docker build -t oracle-21c-xe .
```

## Ejecutar el Contenedor
```bash
docker run -d -p 1521:1521 --name oracle-db oracle-21c-xe
```

## Verificar el Contenedor
```bash
docker ps
```

## Logs el Contenedor
*Si necesitas ver los logs del contenedor*
```bash
docker logs oracle-db
```

## Iniciar el contenedor con el Bash desde la terminal
```bash
docker run -it --name oracle-db-test oracle-21c-xe bash
```

## Conectarse a la Base de Datos de Oracle como el SYS_DBA
*Desde el CLI en la terminal*
```bash
sqlplus sys/your_password@localhost:1521/XE as sysdba
```
*VARIABLES*
-Hostname: localhost
-Port: 1521
-SID: XE
-Username: tu_usuario
-Password: tu_contraseña

## Detener el Contenedor
```bash
docker stop oracle-db
```

## Eliminar el Contenedor
```bash
docker rm oracle-db
```

#!/bin/bash
# install-package.sh
# Script para instalar paquetes adicionales necesarios para Oracle Database 21c XE

# Actualizar el sistema
dnf -y update

# Instalar utilidades útiles y dependencias requeridas por Oracle
dnf -y install wget \
               unzip \
               tar \
               bc \
               binutils \
               compat-libcap1 \
               compat-libstdc++-33 \
               gcc \
               gcc-c++ \
               glibc \
               glibc-devel \
               ksh \
               libaio \
               libaio-devel \
               libgcc \
               libstdc++ \
               libstdc++-devel \
               libnsl \
               make \
               sysstat \
               xorg-x11-apps \
               xorg-x11-xauth \
               xorg-x11-utils \
               xorg-x11-xinit \
               libXtst \
               --setopt=tsflags=nodocs

# Limpiar la caché del gestor de paquetes para reducir el tamaño de la imagen
dnf clean all

# Verificar la instalación de paquetes (opcional)
# rpm -q wget unzip tar bc binutils compat-libcap1 compat-libstdc++-33 gcc gcc-c++ glibc glibc-devel ksh libaio libaio-devel libgcc libstdc++ libstdc++-devel libnsl make sysstat xorg-x11-apps xorg-x11-xauth xorg-x11-utils xorg-x11-xinit libXtst

echo "Paquetes adicionales instalados."

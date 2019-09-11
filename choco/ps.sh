#!/bin/bash
#Powershell Docker Container Installer
psv="$1"

case "$2" in
    linux/arm/v7)
        plat="linux-arm32"
        ;;
    linux/arm64)
        plat="linux-arm64"
        ;;
    linux/amd64)
        plat="linux-x64"
        ;;
esac
wget https://github.com/PowerShell/PowerShell/releases/download/v${psv}/powershell-${psv}-${plat}.tar.gz
mkdir ~/powershell
tar -xvf ./powershell-${psv}-${plat}.tar.gz -C ~/powershell
ln -s ~/powershell/pwsh /usr/bin/pwsh
ln -s ~/powershell/pwsh /usr/local/bin/powershell

rm powershell-${psv}-${plat}.tar.gz
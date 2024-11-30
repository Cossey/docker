#!/bin/bash
#Mega Container Version Installer
case "$1" in
    linux/arm/v7)
        curl -k https://mega.nz/linux/repo/Raspbian_10.0/armhf/megacmd_1.6.3-1.1_armhf.deb --output ./megacmd.deb
        ;;
    linux/386)
        curl -k https://mega.nz/linux/repo/Debian_10.0/i386/megacmd-Debian_10.0_i386.deb --output ./megacmd.deb
        ;;
    linux/amd64)
        curl -k https://mega.nz/linux/repo/Debian_10.0/amd64/megacmd-Debian_10.0_amd64.deb --output ./megacmd.deb
        ;;
esac
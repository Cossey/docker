#!/bin/bash
#Mega Container Version Installer
case "$1" in
    linux/arm/v7)
        curl -k https://mega.nz/linux/MEGAsync/Raspbian_10.0/armhf/megacmd_1.2.0-6.1_armhf.deb --output ./megacmd.deb
        ;;
    linux/386)
        curl -k https://mega.nz/linux/MEGAsync/Debian_10.0/i386/megacmd_1.4.0-3.1_i386.deb --output ./megacmd.deb
        ;;
    linux/amd64)
        curl -k https://mega.nz/linux/MEGAsync/Debian_10.0/amd64/megacmd_1.4.0-3.1_amd64.deb --output ./megacmd.deb
        ;;
esac
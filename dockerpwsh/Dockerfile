FROM docker

RUN apk add tar wget libgcc libstdc++ libintl icu-libs ca-certificates \
    && wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-alpine-x64.tar.gz \
    && mkdir ~/powershell \
    && tar -xvf ./powershell-7.0.0-linux-alpine-x64.tar.gz -C ~/powershell \
    && ln -s ~/powershell/pwsh /usr/bin/pwsh \
    && ln -s ~/powershell/pwsh /usr/local/bin/powershell \
    && rm /powershell-7.0.0-linux-alpine-x64.tar.gz


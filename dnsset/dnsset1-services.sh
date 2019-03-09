#!/usr/bin/env bash

if [[ $USER != root ]] ; then
    echo -e "This should be run as root."
else
    read -p "This will owerwride options for system services of dnscrypt-proxy and dnsmasq, creating files in /etc/systemd/system/. If OK, hit enter: [Y/n] " dset1

    if [[ $dset1 == "" ]] ; then
        mkdir /etc/systemd/system/dnscrypt-proxy.d && touch /etc/systemd/system/dnscrypt-proxy.d/override.conf &&
        echo -e "[Unit] \n
Description = DNSCrypt-proxy client \n
Documentation = https://github.com/jedisct1/dnscrypt-proxy/wiki \n \n

After = network-online.target \n
Wants = network-online.target nss-lookup.target \n
Before = nss-lookup.target \n
Wants = nss-lookup.target \n \n

[Service] \n
CapabilityBoundingSet=CAP_IPC_LOCK CAP_SETGIT CAP_SETUIP CAP_NET_BIND_SERVICE \n
NonBlocking=true \n
ExecStart=/usr/bin/dnscrypt-proxy  --config /etc/dnscrypt-proxy/dnscrypt-proxy.toml \n
DynamicUser=yes \n
ProtectSystem=strict \n
ProtectHome=yes \n
ProtectControlGroups=yes \n
ProtectKernelModules=yes \n
ProtectKernelTunables=yes \n
LockPersonality=yes \n
PrivateTmp=true \n
PrivateDevices=true \n
MemoryDenyWriteExecute=true \n
CacheDirectory=dnscrypt-proxy \n
LogsDirectory=dnscrypt-proxy \n
RuntimeDirectory=dnscrypt-proxy \n
AmbientCapabilitues=CAP_NET_BIND_SERVICE \n
NoNewPrivileges=yes \n
RestrictRealtime=true \n
RestrictAddressFamilies=AF_INET AF_INET6 \n
SystemCallFilter=~@clock @cpu-emulation @debug @keyring @ipc @module @mount @obsolete @raw-io \n \n

[Install] \n
WantedBy = multi-user.target" >/etc/systemd/system/dnscrypt-proxy.d/override.conf &&
        mkdir /etc/systemd/system/dnsmasq.service.d/ &&
        touch /etc/systemd/system/dnsmasq.service.d/override.conf &&
            echo -e "[Unit] \n \n
Description = DHCP and DNS caching server \n
After = network.target \n \n

[Service] \n
ExecStart= \n
ExecStart=/usr/bin/dnsmasq -k --enable-dbus --user=dnsmasq --conf-file=/etc/dnsmasq.conf --pid-file \n \n

[Install] \n
WantedBy = multi-user.target" >/etc/systemd/system/dnsmasq.service.d/override.conf

    elif [[ $dset1 == "n" ]]
         return 0
    else
        echo -e "${dset1} is not a recognized option."
    fi
fi

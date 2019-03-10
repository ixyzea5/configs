  These are configs for dnscrypt-proxy and dnsmasq DNS server. 
  Files from d-proxy dir belong in /etc/dnscrypt-proxy/.
*.sh is a script, that will override systemd configs for dnscrypt-proxy and dnsmasq services.
You will need both of them installed and configured similiar to mine.
Conf files belong /etc for dnsmasq and /etc/dnscrypt-proxy/ d-proxy. 
For facebook to work with this dnsmasq.conf, remove dns-hijack options for it's domains (address=/facebook.net/127.0.0.1 like).
If you use a firewall, allow local (for dns caching on 53000 port) and input on 53/tcp and 53/udp ports for dns service.

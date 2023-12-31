# Client-side tunnel config
[Interface]
Address = 172.27.66.2/24
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostUp = wg set %i private-key /private/wg1.key listen-port 51820 peer ${SERVER_PUBLIC_KEY} endpoint ${SERVER_ENDPOINT} allowed-ips 172.27.66.1 persistent-keepalive 10 
PostDown = iptables -D FORWARD -i wg1 -j ACCEPT; iptables -D FORWARD -o wg1 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


# Server-side tunnel config
[Interface]
Address = 172.27.66.1/24
PostUp = wg set %i private-key /private/wg0.key listen-port 51820 peer ${CLIENT_PUBLIC_KEY} allowed-ips 172.27.66.2/32,10.5.0.0/16
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostUp = ip route add 10.5.0.0/16 dev %i
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


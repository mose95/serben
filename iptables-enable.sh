#!/bin/sh

# Reset Chains and set default policy
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Allow all traffic for localhost
iptables -A INPUT -i lo -j ACCEPT

# Allow ping
iptables -A INPUT -i eth0 -p icmp --icmp-type 8 -j ACCEPT

# Allow incoming traffic from estabilished connection
iptables -A INPUT -i eth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT

## Bridge forward and nat
#  Allow input on bridge interface
iptables -A INPUT -i lxcbr0 -j ACCEPT
iptables -A INPUT -i docker0 -j ACCEPT
# Allow forward between eth0 and lxcbr0
iptables -A FORWARD -s 10.0.3.0/24 -o eth0 -j ACCEPT
iptables -A FORWARD -d 10.0.3.0/24 -o lxcbr0 -j ACCEPT
# Allow forward between eth0 and docker0
iptables -A FORWARD -s 172.17.0.0/24 -o eth0 -j ACCEPT
iptables -A FORWARD -d 172.17.0.0/24 -o docker0 -j ACCEPT
# Enable nat for bridge network
iptables -t nat -A POSTROUTING -s 10.0.3.0/24 ! -d 10.0.3.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.17.0.0/24 ! -d 172.17.0.0/24 -j MASQUERADE


# SSH
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 22 -j ACCEPT

# Samba
#iptables -A INPUT -i eth0 -p udp -m udp --dport 137 -j ACCEPT
#iptables -A INPUT -i eth0 -p udp -m udp --dport 138 -j ACCEPT
#iptables -A INPUT -i eth0 -p tcp -m tcp --dport 137 -j ACCEPT
#iptables -A INPUT -i eth0 -p tcp -m tcp --dport 139 -j ACCEPT
#iptables -A INPUT -i eth0 -p tcp -m tcp --dport 445 -j ACCEPT

# Teamspeak
iptables -A INPUT -i eth0 -p udp -m udp --dport 9987 -j ACCEPT
iptables -A INPUT -i eth0 -p udp -m udp --dport 9988 -j ACCEPT
iptables -A INPUT -i eth0 -p udp -m udp --dport 9999 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 10011 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 30033 -j ACCEPT

# Deluge
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 8112 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 6881:6891 -j ACCEPT
iptables -A INPUT -i eth0 -p udp -m udp --dport 6881:6891 -j ACCEPT

## Minecraft

iptables -A INPUT -i eth0 -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp -m tcp --dport 25565 -j ACCEPT
iptables -A INPUT -i eth0 -p udp -m udp --dport 25565 -j ACCEPT

## EOF ##

Schimbarea sursei de index.html in functie de ip:

sudo iptables -t nat -F

I. vreau sa trimit ceva de pe vm1-1:
pe vm1: sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.100.24:80
II. vreau sa trimit ceva de pe vm1-2
pe vm1: sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.100.219:80

III. vreau sa trimit de pe vm2-1
pe vm2: sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.101.178:80
IV. vreau sa trimit de pe vm2-2
pe vm2: sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.101.244:80

sudo iptables -t nat -A POSTROUTING -j MASQUERADE

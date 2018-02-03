$TTL    86400
@       IN      SOA     server1.example.com. root.localhost. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      server1.example.com.

$ORIGIN example.com.
server1 IN      A       {{ server1_ip }}
server2 IN      A       {{ server2_ip }}
wordpress       IN      CNAME   server2
mysql IN CNAME server1


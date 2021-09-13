#  Доступ из сети в Интернет 

## Схема

         INTERNET
    ------------------
            |
            |
           [1]                              .---- для доступа во вне нужно: `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`,
            |                               |    
            | * eth0: auto NAT              |
    ------------------    <-----------------'
    |   inetRouter   |    <------------------- маршруты на машине:
    ------------------                          * default via 10.0.2.2 dev eth0 
            | * eth1: 192.168.255.1             * 10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 - это рудимент Vagrant, не обращайте внимание
            |                                   * 192.168.0.0/24 via 192.168.255.2 dev eth1 - этот маршрут нужен для того, чтоб достучаться отсюда до 192.168.0.2, в том числе в раках ответа ping, сделанного из сети во вне 
           [2]                                  * 192.168.255.0/24 dev eth1 proto kernel scope link src 192.168.255.1
            |
            | * eth1: 192.168.255.2
    ------------------
    |  centralRouter |     <------------------- маршруты на машине:
    ------------------                          * default via 192.168.255.1 dev eth1 
            | * eth2: 192.168.0.1               * 10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 - это рудимент
            |                                   * 192.168.0.0/24 dev eth2 proto kernel scope link src 192.168.0.1
           [3]                                  * 192.168.255.0/24 dev eth1 proto kernel scope link src 192.168.255.2 
            |
            | * eth1: 192.168.0.2
    ------------------
    |  centralServer |      <------------------- маршруты на машине:
    ------------------                          * default via 192.168.0.1 dev eth1 
                                                * 10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 - это рудимент
                                                * 192.168.0.0/24 dev eth1 proto kernel scope link src 192.168.0.2
 
А вот если б было правило (оно тоже позволяет работать)
`iptables -t nat -A POSTROUTING -o eth0 ! -d 192.168.0.0/16 -j MASQUERADE`  - то оно что значит ?

"Сделается переподстановка ip из имеющегося в eth0, но это не для пакетов, идущих из-вне к сети 192.168.0.0/16"?

от чего защищает это правило
# RancherOS

### Disable IPv6

* IN-PLACE EDITING：`$ sudo ros config syslinux`

* DURING INSTALLATION：`$ sudo ros install -d /dev/sda -a "ipv6.disable=1"`

# Rancher

## Restore Rancher Server's MySQL data (v1.x)
`$ docker exec -i rancher-server /usr/bin/mysql -u root cattle < backup.sql`

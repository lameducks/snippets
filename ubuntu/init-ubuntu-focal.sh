#!/bin/bash

# Setup journald
sed -i 's/^#ForwardToSyslog=yes/ForwardToSyslog=no/' /etc/systemd/journald.conf 
systemctl restart systemd-journald

# Remove unnecessary packages
apt -y purge lxd-agent-loader open-iscsi rsyslog

# Remove unnecessary snaps
snap remove --purge lxd

# Update packages
apt -y update
apt -y full-upgrade

# Update snaps
snap refresh

# Install packages
apt -y install docker.io docker-compose jq
apt -y autoremove

# Mask unnecessary units
systemctl mask \
    apport-autoreport.path \
    apport-forward.socket \
    atd.service \
    blk-availability.service \
    lvm2-lvmpolld.socket \
    lvm2-monitor.service \
    mdcheck_continue.timer \
    mdcheck_start.timer \
    mdmonitor-oneshot.timer \
    motd-news.timer \
    multipathd.service \
    multipathd.socket \
    remote-fs.target \
    rsync.service

# Setup timezone and NTP server
timedatectl set-timezone Asia/Tokyo
sed -i 's/^#NTP=/NTP=ntp.jst.mfeed.ad.jp/' /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd

# Setup motd
sed -i 's/^printf/#printf/' /etc/update-motd.d/10-help-text
sed -i 's/^ENABLED=1/ENABLED=0/' /etc/default/motd-news

# Setup sshd
sed -i 's/^#AddressFamily any/AddressFamily inet/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# Setup Docker
sudo systemctl enable docker
cat << '_EOF_' > /etc/docker/daemon.json
{
  "log-driver": "journald"
}
_EOF_
sudo systemctl restart docker

# Sort password file and group file
pwck -s
grpck -s

# Cleanup
groupdel lxd
userdel lxd

rm -f \
    /var/log/auth.log* \
    /var/log/cloud-init.log* \
    /var/log/kern.log* \
    /var/log/mail.err* \
    /var/log/mail.log* \
    /var/log/syslog* \
    /var/log/ufw.log*

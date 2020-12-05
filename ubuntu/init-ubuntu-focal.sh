#!/bin/bash

# Remove unnecessary packages
apt -y purge lxd-agent-loader open-iscsi ubuntu-fan

# Remove unnecessary snaps
snap remove --purge lxd
groupdel lxd
userdel lxd

# Update packages
apt -y update
apt -y full-upgrade

# Update snaps
snap refresh

# Install packages
apt -y install jq
apt -y autoremove

# Mask unnecessary units
systemctl mask \
    atd.service \
    lvm2-lvmpolld.socket \
    lvm2-monitor.service \
    mdmonitor-oneshot.timer \
    motd-news.timer \
    remote-fs.target

# Setup timezone and NTP server
timedatectl set-timezone Asia/Tokyo
sed -i 's/^#NTP=/NTP=ntp.jst.mfeed.ad.jp/' /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd

# Setup motd
sed -i 's/^printf/#printf/' /etc/update-motd.d/10-help-text
sed -i 's/^ENABLED=1/ENABLED=0/' /etc/default/motd-news

# Sort password file and group file
pwck -s
grpck -s

# Remove unnecessary packages
apt -y purge apport

# Update packages
apt -y update
apt -y full-upgrade

# Install packages
apt -y install ntpdate unzip

# DateTime/NTP
timedatectl set-timezone Asia/Tokyo
sed -i 's/^#NTP=/NTP=ntp.jst.mfeed.ad.jp/' /etc/systemd/timesyncd.conf
ntpdate -b ntp.jst.mfeed.ad.jp

# Disable unnecessary services
systemctl disable accounts-daemon.service
systemctl disable atd.service
systemctl disable iscsi.service
systemctl disable iscsid.service
systemctl disable lvm2-monitor.service
systemctl disable lvm2-lvmetad.socket
systemctl disable lvm2-lvmpolld.socket
systemctl disable lxcfs.service
systemctl disable lxd-containers.service
systemctl disable lxd.socket
systemctl disable open-iscsi.service
systemctl disable remote-fs.target
systemctl disable snapd.autoimport.service
systemctl disable snapd.refresh.timer
systemctl disable snapd.service
systemctl disable snapd.socket
systemctl disable snapd.system-shutdown.service

# Boot loader (GRUB2)
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=""/GRUB_CMDLINE_LINUX_DEFAULT="apparmor=0 ipv6.disable=1"/' /etc/default/grub
update-grub

# Tuning kernel parameters
#cat << '_EOF_' > /etc/sysctl.d/60-tuning-parameters.conf
#net.ipv4.tcp_timestamps = 0
#vm.swappiness = 30
#_EOF_

# sshd
cat << '_EOF_' >> /etc/ssh/sshd_config
AllowGroups ssh-operators
_EOF_

# logrotated
sed -i 's/^# rotate log files weekly/# rotate log files daily/' /etc/logrotate.conf
sed -i 's/^weekly/daily/' /etc/logrotate.conf
sed -i 's/^# keep 4 weeks worth of backlogs/# keep 90 days worth of backlogs/' /etc/logrotate.conf
sed -i 's/^rotate 4/rotate 90/' /etc/logrotate.conf
sed -i 's/^#compress/compress\ndelaycompress/' /etc/logrotate.conf

# hosts
cat << _EOF_ > /etc/hosts
127.0.0.1 localhost localhost.localdomain
`ip route get 1 | awk '{print $NF;exit}'` `cat /etc/hostname`
_EOF_

# MOTD
sed -i 's/^printf/#printf/' /etc/update-motd.d/10-help-text

# Users and Groups
usermod -a -s /bin/bash -G root,adm,sudo,operator,systemd-journal,users,ssh-operators `logname`
pwck -s
grpck -s

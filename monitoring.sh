architecture=$(uname -a)
cpuphys=$(grep processor /proc/cpuinfo | wc -l)
# or (lscpu | grep 'Core(s) per socket:' | awk '{print $4}')
vcpu=$(nproc --all)
ramuse=$(free -m | grep 'Mem:' | awk '{printf"%d/%dMB (%.2f%%)", $3, $2, $3 * 100 / $2}')
diskuse=$(df -BM -t ext4 --total | grep 'total' | awk '{printf"%d/%.1fGb (%d%%)", $3, $2 / 1024, $5}')
cpuload=$(uptime | awk '{printf"%.1f%%", $9}')
lastboot=$(who -b | awk '{print $3, $4}')
#lvm=$(lsblk | grep 'lvm' | wc -l)
contcp=$(netstat -n | grep 'tcp' | wc -l)
estab=$(netstat -n | grep 'tcp' | awk '{print $6}')
usrlog=$(who | wc -l)
#ipaddr=$(hostname -I | awk '{print $1}')
ipaddr=$(ip a | grep 'inet 10' | awk '{printf"%.9s", $2}')
macaddr=$(ip a | grep 'ether' | awk '{print $2}')
qnsudo=$(cat /var/log/sudo/sudologs | grep 'COMMAND' | wc -l | awk '{$2="cmd"; print $0}')

if lsblk | grep 'lvm' | wc -l;
then lvm="yes"
else lvm="no"
fi

wall "
#Architecture: $architecture
#CPU physical : $cpuphys
#vCPU : $vcpu
#Memory Usage: $ramuse
#Disk Usage: $diskuse
#CPU load: $cpuload
#Last boot: $lastboot
#LVM use: $lvm
#Connexions TCP : $contcp $estab
#User log: $usrlog
#Network: IP $ipaddr ($macaddr)
#Sudo : $qnsudo
"
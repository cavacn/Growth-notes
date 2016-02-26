cd /var/
## 建立交换区
dd if=/dev/zero of=swapfile bs=1024 count=8192000
## 设置交换区
mkswap /var/swapfile
## 启动系统交换区
swapon swapfile
## 开机启动
echo "/var/swapfile swap swap defaults 0 0" >>/etc/fstab
## 输出信息查看
free -m

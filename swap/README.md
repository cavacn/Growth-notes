## Swap交换区(虚拟内存)设置

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


### How to use

#### 修改权限

    chmod 777 ./swap-8G.sh

#### 运行

    ./swap-8G.sh

#### 等待安装完成

    咳咳，这个可能要等个几分钟，耐心等待~~~

#!/bin/sh
# 切换到用户目录
cd ~
# 创建文件夹
mkdir cavacn-cmake-download
# 进入到新建文件夹
cd cavacn-cmake-download
# 下载cmake-2.6.2
wget https://cmake.org/files/v2.6/cmake-2.6.2.tar.gz

cd ~

mkdir cavacn-cmake-dist
cd cavacn-cmake-dist
tar -xvf ../cavacn-cmake-download/cmake-2.6.2.tar.gz
cd cmake-2.6.2
./configure
make
make install

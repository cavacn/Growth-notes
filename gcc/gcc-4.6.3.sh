#!/bin/sh
cd ~
mkdir cavacn-download
cd cavacn-download
# 下载
wget http://ftp.gnu.org/gnu/gcc/gcc-4.6.3/gcc-4.6.3.tar.gz
wget http://ftp.gnu.org/gnu/gmp/gmp-5.0.1.tar.bz2
wget http://ftp.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz
wget http://ftp.gnu.org/gnu/mpfr/mpfr-2.4.2.tar.gz

cd ~
mkdir dist
cd dist
# 解压
tar -xvf ../cavacn-download/gcc-4.6.3.tar.gz
tar -xvf ../cavacn-download/gmp-5.0.1.tar.bz2
tar -xvf ../cavacn-download/mpc-1.0.1.tar.gz
tar -xvf ../cavacn-download/mpfr-2.4.2.tar.gz

# 编译安装gmp
cd gmp-5.0.1
./configure --perfix=/usr/local/gmp-5.0.1
make
make install

# 编译安装mpfr
cd ../mpfr-2.4.2
./configure --prefix=/usr/local/mpfr-2.4.2 --with-gmp=/usr/local/gmp-5.0.1/
make
make install

# 编译安装mpc
cd ../mpc-1.0.1
./configure --prefix=/usr/local/mpc-1.0.1 --with-gmp=/usr/local/gmp-5.0.1/ --with-mpfr=/usr/local/mpfr-2.4.2/
make
make install

# 编译安装gcc
cd ../gcc-4.6.3
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gmp-5.0.1/lib/:/usr/local/mpfr-2.4.2/lib/:/usr/local/mpc-1.0.1/lib/
yum install glibc-devel.i686 -y
./configure --prefix=/usr/local/gcc-4.6.3 --with-gmp=/usr/local/gmp-5.0.1/ --with-mpfr=/usr/local/mpfr-2.4.2/ --with-mpc=/usr/local/mpc-1.0.1/
make
make install
# 备份原gcc
mv /usr/bin/gcc /usr/bin/gcc.backup
# 建立软连接
ln -s /usr/local/gcc-4.6.3/bin/gcc /usr/bin/gcc

cd ~
rm -rf ./cavacn-download
rm -rf ./dist
# 查看安装gcc版本
gcc --version

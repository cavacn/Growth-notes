#!/bin/sh

basedir=~
downdir=${basedir}"/cavacn-gcc-download"
distdir=${basedir}"/cavacn-gcc-dist"
gcc_version="gcc-4.6.3"
gcc_local="/usr/local/"${gcc_version}
gmp_version="gmp-5.0.1"
gmp_local="/usr/local/"${gmp_version}
mpc_version="mpc-1.0.1"
mpc_local="/usr/local/"${mpc_version}
mpfr_version="mpfr-2.4.2"
mpfr_local="/usr/local/"${mpfr_version}
downlist=(
  "http://ftp.gnu.org/gnu/gmp/"${gmp_version}".tar.gz"
  "http://ftp.gnu.org/gnu/mpfr/"${mpfr_version}".tar.gz"
  "http://ftp.gnu.org/gnu/mpc/"${mpc_version}".tar.gz"
  "http://ftp.gnu.org/gnu/gcc/"${gcc_version}"/"${gcc_version}".tar.gz"
)
if [ ! -f "$downdir" ]; then
  mkdir -p $downdir
fi
if [ ! -f "$distdir" ]; then
  mkdir -p $distdir
fi

function download(){
  filename=${1##*/}
  name=${filename%.tar*}
  method=${name%-*}
  if [ -d "/usr/local/${name}" ]; then
    echo ${name}"已经安装，跳过下载和解压"
    return 1
  fi
  tmpfile=${downdir}/${filename}
  # echo $filename"======"$tmpfile
  if [ ! -f "${tmpfile}" ];then
    # echo "begin-download==>"$1
    echo ${tmpfile}"不存在"
    echo "开始下载:"$1
    wget $1 2>wget.log
    wgetCode=$?
    if [ "$wgetCode"x != "0"x ];then
      echo "下载失败:"$1
      exit
    fi
  fi
  echo "正在解压:"${filename}
  tar -xvf ${filename} -C ${distdir} 2>tar.err 1>tar.log
  tarErr=`cat tar.err`
  if [ "$tarErr"x != ""x ];then
    echo "解压失败:"${filename}
    exit
  fi
  echo "解压成功:"${filename}
  echo "执行:"${method}
  if [ "$method"x = "gmp"x ];then
    gmp
  elif [ "$method"x = "mpc"x ];then
    mpc
  elif [ "$method"x = "mpfr"x ];then
    mpfr
  elif [ "$method"x = "gcc"x ];then
    gcc
  fi
  # echo "finish-download==>"$1
}

function gmp(){
  cd $distdir"/"${gmp_version}
  echo "正在执行(gmp)"$distdir"/"${gmp_version}
  echo "./configure"
  ./configure --prefix=${gmp_local} 1>configure.log
  echo "make"
  make 2>make.err 1>make.log
  echo "make install"
  make install 2>install.err 1>install.log
  installErr=`cat install.err`
  if [ "$installErr"x != ""x ];then
    echo "GMP安装失败:"$installErr
    exit
  fi
  echo "安装完毕:"${gmp_version}
}

function mpfr(){
  cd $distdir"/"${mpfr_version}
  echo "正在执行(mpfr)"$distdir"/"${mpfr_version}
  echo "./configure"
  ./configure --prefix=${mpfr_local} --with-gmp=${gmp_local} 1>configure.log
  echo "make"
  make 2>make.err 1>make.log
  echo "make install"
  make install 2>install.err 1>install.log
  installErr=`cat install.err`
  if [ "$installErr"x != ""x ];then
    echo "MPFR安装失败:"$installErr
    exit
  fi
  echo "安装完毕:"${mpfr_version}
}

function mpc(){
  cd $distdir"/"${mpc_version}
  echo "正在执行(mpc)"$distdir"/"${mpc_version}
  echo "./configure"
  ./configure --prefix=${mpc_local} --with-gmp=${gmp_local} --with-mpfr=${mpfr_local} 1>configure.log
  echo "make"
  make 2>make.err 1>make.log
  echo "make install"
  make install 2>install.err 1>install.log
  installErr=`cat install.err`
  if [ "$installErr"x != ""x ];then
    echo "MPC安装失败:"$installErr
    exit
  fi
  echo "安装完毕:"${mpc_local}
}



function gcc(){
  cd $distdir"/"${gcc_version}
  echo "正在执行(gcc)"$distdir"/"${gcc_version}
  echo "设置环境变量:LD_LIBRARY_PATH"
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$gmp_local/lib:$mpc_local/lib:$mpfr_local/lib
  echo "yum install glibc-devel.i686"
  yum install glibc-devel.i686 -y 2>yum.err 1>yum.log
  echo "./configure"
  ./configure --prefix=${gcc_local} --with-gmp=${gmp_local} --with-mpc=${mpc_local} --with-mpfr=${mpfr_local} 1>configure.log
  echo "make"
  make 2>make.err 1>make.log
  echo "make install"
  make install 2>install.err 1>install.log
  installErr=`cat install.err`
  if [ "$installErr"x != ""x ];then
    echo "MPFR安装失败:"$installErr
    exit
  fi
  echo "安装完毕:"${gcc_version}
}

cd $downdir
# echo $downdir
for data in ${downlist[@]}
do
  # echo ${data}
  download ${data}
done
exit

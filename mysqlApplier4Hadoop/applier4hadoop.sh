#!/bin/sh
applier_name=mysql-hadoop-applier-0.1.0
applier_version="${applier_name}-alpha"
url=http://downloads.mysql.com/snapshots/pb/hadoop-applier/${applier_version}.tar.gz
basedir=~
downdir=${basedir}"/cavacn-applier4hadoop-download"
distdir=${basedir}"/cavacn-applier4hadoop-dist"
if [ [$HADOOP_HOME]x == "[]"x ];then
  echo "请先设置HADOOP_HOME"
  exit
fi
if [ [$MYSQL_DIR]x == "[]"x ];then
  echo "请先设置MYSQL_DIR"
  exit
fi
function download(){
  filename=${1##*/}
  name=${filename%.tar*}
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
  cd ${distdir}"/"${applier_name}
  mkdir -p build
  cd build
  cmake .. -DCMAKE_MODULE_PATH:String=../MyCmake/
}
if [ ! -f "$downdir" ]; then
  mkdir -p ${downdir}
fi
if [ ! -f "$distdir" ]; then
  mkdir -p ${distdir}
fi
cd ${downdir}
download ${url}

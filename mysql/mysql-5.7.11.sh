#!/usr/bin
url=http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-5.7.11-1.el6.src.rpm
basedir=~
downdir=${basedir}"/cavacn-mysql-download"
distdir=${basedir}"/cavacn-mysql-dist"
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
  rpm -ivh mysql-community-common-5.7.11-1.el6.x86_64.rpm
  rpm -ivh mysql-community-common-5.7.11-1.el6.x86_64.rpm
}

download ${url}

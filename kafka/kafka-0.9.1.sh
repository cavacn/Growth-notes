#!/usr/bin/env bash
_basedir=~
_version="kafka_2.11-0.9.0.1"
_download="$_basedir/download"
# _url="https://github.com/alibaba/jstorm/archive/$_version.tar.gz"
# _url="http://apache.communilink.net/kafka/0.9.0.1/$_version.tgz"
_url="http://ftp.cuhk.edu.hk/pub/packages/apache.org/kafka/0.9.0.1/$_version.tgz"
# 检查文件
function _check(){
  _tmp="${_basedir}/$1"
  echo "检查:文件夹[$_tmp]"
  if [ ! -d "${_tmp}" ];then
    echo "检查:[$_tmp]:不存在"
    return 0
  fi
  echo "检查:[$_tmp]:已存在"
  return 1
}
# 下载文件
function _download(){
  _url=$1
  _filename=$_download/${_url##*/}
  if [ ! -f "${_filename}" ];then
    echo "${_filename}:不存在"
    echo "开始下载：$_url"
    wget $_url -P $_download
  else
    echo "${_filename}:已存在"
  fi
}
# 解压文件
function _tar(){
  _filename=$_download/${1##*/}
  rm -rf "$_basedir/$_version"
  echo "正在解压:$_filename -> $_basedir/$_version"
  tar -xvf $_filename -C $_basedir 1>/dev/null 2>&1
  echo "解压完成: $_basedir/$_version"
}

_check $_version
_ckNum=$?
if [ $_ckNum -eq 0 ];then
  _download $_url
  _tar $_url
fi

echo "开始部署服务器咯~~"
echo "我这里准备了一些默认的配置放在 ./config/ 文件夹下面,根据你自己的需求修改配置文件"
echo "这里有些地方需要修改的~~分发完成之后，自行修改  server.properties  broker.id=0"
cp -r ./config/ $_basedir/$_version/
echo "开始分发代码~~ =.="

while [[ true ]]; do
  #statements
  echo -n "请输入主机名:(host/n):"
  read _hostname
  if [[ "n"x == "$_hostname"x ]]; then
    #statements
    echo "结束懒人Kafka"
    break
  fi
  echo "开始分发Kafka -> $_hostname"
  scp -r $_basedir/$_version $_hostname:$_basedir/$_version 1>/dev/null 2>&1
  echo "$_hostname:分发已完成"
done

# http://download.redis.io/releases/redis-3.0.7.tar.gz
#!/usr/bin/env bash
_version="redis-3.0.7"
_basedir=~
_download="$_basedir/download/"
_url="http://download.redis.io/releases/$_version.tar.gz"
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
  _filename=$_download${_url##*/}
  if [ ! -f "${_filename}" ];then
    echo "${_filename}:不存在"
    echo "开始下载：$_url"
    wget $_url -P $_download 1>/dev/null 2>&1
  else
    echo "${_filename}:已存在"
  fi
}
# 解压文件
function _tar(){
  _filename=$_download${1##*/}
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

echo "开始分发代码~~ =.="

while [[ true ]]; do
  #statements
  echo -n "请输入主机名:(host/n):"
  read _hostname
  if [[ "n"x == "$_hostname"x ]]; then
    #statements
    echo "结束懒人Redis"
    break
  fi
  echo "开始分发Redis -> $_hostname"
  scp -r $_basedir/$_version $_hostname:$_basedir/$_version 1>/dev/null 2>&1
  echo "$_hostname:分发已完成"
done

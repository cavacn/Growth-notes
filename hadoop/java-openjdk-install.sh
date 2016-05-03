echo "懒人版安装:---->Java-OpenSDK"
echo -n "请输入需要安装的版本(全称:默认 【 java-1.7.0-openjdk-devel 】):"
read _version
echo -n "请输入JAVA_HOME路径(默认 【 /usr/lib/jvm/jre-1.7.0-openjdk.x86_64 】):"
read _java_home
if [ ""x == "$_version"x ];then
  _version="java-1.7.0-openjdk-devel"
fi
if [ ""x == "$_java_home"x ];then
  _java_home="/usr/lib/jvm/jre-1.7.0-openjdk.x86_64"
fi
echo "你需要安装的版本是：$_version"
echo "你的JAVA_HOME是：$_java_home"
while [[ true ]]; do
  #statements
  echo "请输入主机名,必须是root权限"
  echo "例如:root@hostname"
  echo -n "这是个死循环 (host/n):"
  read _hostname
  if [ "n"x == "$_hostname"x ];then
    break
  fi
  ssh $_hostname <<EOF
_java_home=$_java_home
yum install $_version -y 1>/dev/null 2>&1
echo 'export JAVA_HOME=$_java_home' >> /etc/profile
source /etc/profile
EOF
done

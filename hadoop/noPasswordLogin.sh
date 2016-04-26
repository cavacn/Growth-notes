echo "=====Hadoop免用户登录设置==================================="
# ssh-keygen -t rsa
echo -n "请输入你的组名:"
read group
useradd $group 1>/dev/null 2>&1
echo -n "请输入你的用户名:"
read name
useradd $name -g $group 1>/dev/null 2>&1
echo -n "请输入你的密码:"
read passwd
passwd $name 1>/dev/null 2>&1 <<EOF
$passwd
$passwd
EOF

echo -n "是否创建新的钥匙(y/n):"
read choose
if [[ "$choose"x == "y"x ]]; then
  rm -rf ~/.ssh/
  ssh-keygen -t rsa
  echo "公钥添加到authorized_keys"
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  echo "修正authorized_keys权限:chmod 644"
  chmod 644 ~/.ssh/authorized_keys
  echo "移除密钥:/home/$name/.ssh"
  rm -rf /home/$name/.ssh 1>/dev/null 2>&1
  mv -f ~/.ssh/ /home/$name/.ssh
  echo "修正权限:/home/$name/.ssh"
  chown -R $name:$group /home/$name/.ssh
  echo "修正权限:/home/$name/.ssh -> 700"
  chmod 700 /home/$name/.ssh
fi

function connectServer(){
  echo -n "请输入HOST:"
  read host
ssh root@$host 1>/dev/null 2>&1 <<EOF
groupadd $group 1>/dev/null 2>&1
useradd $name -g $group 1>/dev/null 2>&1
passwd $name 1>/dev/null 2>&1<<COMMENTBLOCK
$passwd
$passwd
COMMENTBLOCK
EOF
  su $name <<EOF
scp -r ~/.ssh/ $host:~/
EOF
}


while [[ true ]]; do
  #statements
  echo -n "连接新的服务器(y/n):"
  read choose
  if [[ "$choose"x == "n"x ]]; then
    #statements
    break
  fi
  connectServer $choose
done

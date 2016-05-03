a=()
echo $a
echo ${#a[@]}
while [[ true ]]; do
  #statements
  echo -n "输入一下:"
  read tmp
  a[${#a[@]}]=$tmp
  echo ${a[*]}
done

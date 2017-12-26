#!/bin/bash

# jenkins 自动化脚本。
# 使用前须在主机上安装expect和ssh， 安装命令 yum -y install expect
# 这个脚本使用前需运行 cluster.sh 脚本。具体使用请看 cluster.sh 脚本源码
# 使用需传入两个参数， sh jenkins.sh job ip 例如 sh jenkins.sh app 10.0.0.241

if [ $# != 2 ]; then
    echo "USAGE : sh jenkins.sh jobname ipaddress"
fi
scriptPrefix="/home/scripts"
filePrefix="/home/applications"

job=$1
ip=$2

# 执行关闭命令
ssh root@${ip} "/bin/bash ${scriptPrefix}/stop.sh ${job}"
# copy file
find ${job} -maxdepth 3 -type f -name '*.war' -exec scp {} root@${ip}:${filePrefix}/${job}.war \;
# 执行启动命令
ssh root@${ip} "/bin/bash ${scriptPrefix}/start.sh ${job}"

# jenkins远程脚本执行结束

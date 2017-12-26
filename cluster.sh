#!/bin/bash
# 所有主机建立集群脚本，一个公共主机，其他主机都信任它。利用公共主机搞事

#ip 列表，空格分开
ip=(10.0.0.241)
path="./.ssh/id_dsa"
# 受信任的主机ssh配置

function generator()
{
    cd ~/.ssh
    ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
    ssh-copy-id -i localhost
}
cd ~
if [ ! -f "${path}" ]; then
    echo "没有公钥文件"
    generator
fi

# 连接远程主机并将公共文件存入远程主机的 authorized_keys 文件列表
for address in ${ip[*]}
do
    echo "访问远程主机${address}"
    /usr/bin/expect /home/scpFile.expect $address
done




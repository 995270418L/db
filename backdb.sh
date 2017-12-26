#!/bin/bash
# 测试数据库定时备份脚本，每天凌晨备份 
#~ crontab -e 
# 增加一行: 0 3 * * * /path/backdb.sh   

#多个数据库名，空格隔开
database=(audit_all s_all)
#文件保存目录
savepath=/home/backup
if [ ! -d "$savepath" ];then
    mkdir -p "$savepath"
fi

for db in ${database[*]}
do
    /usr/bin/mysqldump -ushiyue -pshiyue -B $db -F -R -x --master-data=2 |gzip > $savepath/${db}_$(date +%F).sql.gz
    find $savepath -mtime +2 -name "*.sql.gz" -exec rm -rf {} \;
done


#!/bin/bash

# This script is used to backup basepointdb to Azure FTP


timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

START=$(timestamp)
echo ${START}
BACKUP=(`mysql -h localhost -u root -proot -e "BACKUP basepointdb TO 'ftp://anonymous:anonymous@100.77.16.5/mars-201611/28/basepointdb.test'" &`)
CMD=(`mysql -h localhost -u root -proot -e "select bytes / expected_bytes * 100 from system.backup_status;"`)


res_len=${#CMD[@]}
while [ $res_len -ne 0 ]
do
  echo -ne "process: ${CMD[`expr $res_len - 1`]} \r"
  sleep 5s
  CMD=(`mysql -h localhost -u root -proot -e "select bytes / expected_bytes * 100 from system.backup_status;"`)
  res_len=${#CMD[@]}
done

echo "No bakcup process"


FINISH=$(timestamp)
echo ${FINISH}





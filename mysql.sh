#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%s)
SCRIPT_NAME=$(echo $0 | cut -d "." -f)
LOGFILE=/temp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e0m"


VALILDATE(){
    if [ $1 -ne 0]
    then
         echo -e "$2....$R FAILURE $N"
         exit 1
       else 
         echo -e "$2.....$G SUCCESS $N"
      fi

}


if [ $USERID -ne 0]
then 
   echo "please run this script with root access."
   exit 1
else 
echo "you are super user."

fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enabling mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "start  mysql server"

mysql_secure_installation --set-root-pass ExVALIDATE $? "start  mysql server"
VALIDATE $? "setting up root password"

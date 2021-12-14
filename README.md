# Demo-2Tier-Arch
Demo 2-Tier Architecture

## Delete Instance Profile 
'''
aws iam delete-instance-profile --instance-profile-name fmdemo-ec2-rds-profile
'''
## Notes
 
lsb_release -a

sudo apt install mysql-client

mysql -h fmdemo-rds.c7nr1ow2djqz.us-east-1.rds.amazonaws.com -P 3306 -u fmdbuser -p <manuallyentry>

show databases;

use fmdemords

show tables;

select * from authors;

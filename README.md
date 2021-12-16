## Demo-2Tier-Arch
Demo for a Simple 2-Tier Architecture .

#### Deploy Architecture via Terraform Commands
#### Pre-requisite
Create ec2 deployment server with IAM admin-role attached\
Install aws-cli\
Install Terraform depending your OS\
https://learn.hashicorp.com/tutorials/terraform/install-cli


#### Deployment Steps
Create directory "<terraform>"\
Extract directory/files into terraform directory or\
Clone files from GitHub\
Run Terraform below commands to create Infrastructure

> terraform init\
> terraform plan\
> terraform apply -auto-approve

#### Validate docker install.
Connect via ssh to newly created ec2-docker machine\
Run commands below --
> docker --version\
> docker run hello-world

#### Validate MySql Client install and connect to DB.
Connect via ssh to newly created ec2-docker machine\
Run below commands --
> mysql -v\
> mysql -h <db-endpoint> -P 3306 -u username -p "<manuallyentry>"\
> \! clear\
> show databases;\
> use fmdemords\
> show tables;

    create table sales(
    ID INT, ProductName VARCHAR(255), CustomerName VARCHAR(255),DispatchDate date,
    DeliveryTime time, Price INT,Location VARCHAR(255));

    insert into sales (ID, ProductName, CustomerName, DispatchDate, DeliveryTime, Price, Location) values(1, 'Key-Board', 'Raz', DATE('2021-09-01'), TIME('11:00:00'), 7000, 'California');
    insert into sales values(2, 'Earphones', 'Jonathan', DATE('2021-05-01'), TIME('11:00:00'), 2000, 'Chicago');
    insert into sales values(3, 'Mouse', 'John', DATE('2021-03-01'), TIME('10:59:59'), 3000, 'Atlanta');
    insert into sales values(4, 'Mobile', 'Cyndy', DATE('2021-03-01'), TIME('10:10:52'), 9000, 'Houston');

    select * from sales;


#### Cleanup Steps
Delete RDS from AWS Console\
Delete RDS Option group from AWS Console\
Delete IAM Role from AWS Console\
Delete instance-profile from command line
> aws iam delete-instance-profile --instance-profile-name "<instance-profile-name>"

Run "terraform destroy"  command


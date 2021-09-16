#!/bin/bash

yum update -y
yum install -y aws-cli
yum install -y git
cd /home/ec2-user/
aws configure
aws s3 cp s3://aws-codedeploy-us-east-1/latest/install . --region us-east-1
chmod +x ./install
sed -i "s/sleep(.*)/sleep(10)/" install
./install auto
git clone https://github.com/mayurb99/PE-MOCK-PROJECT-GROUP_2.git
cd PE-MOCK-PROJECT-GROUP_2
pip3 install -r requirements.txt
wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
cat > env.py << ABC
import os
os.environ.setdefault("IP", "0.0.0.0")
os.environ.setdefault("PORT", "80")
os.environ.setdefault("MONGO_URI", "mongodb://group2:groupnumber2@group2-mock.cluster-csaruqlxxway.us-east-1.docdb.amazonaws.com:27017/myFirstDatabase?ssl=true&ssl_ca_certs=rds-combined-ca-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false")
os.environ.setdefault("MONGO_DBNAME", "test")
ABC
python3 app.py &

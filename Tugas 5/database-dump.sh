#!/bin/bash

RDS_HOST=database1-tugas5.czq0ucs8uuwu.ap-southeast-1.rds.amazonaws.com
RDS_PASSWORD=password123
RDS_USER=admin
RDS_DATABASE=tugas5

S3_BUCKET=tugas5-rds-backup
S3_BACKUP_FOLDER=rds_bak

timestamp=$(date '+%d%m%Y')
filename="backup_${timestamp}.sql"

mysqldump -h ${RDS_HOST} -u ${RDS_USER} -p${RDS_PASSWORD} ${RDS_DATABASE} > ${filename}

aws s3 cp ${filename} s3://${S3_BUCKET}/${S3_BACKUP_FOLDER}/ --region

aws s3api put-bucket-lifecycle --bucket ${S3_BUCKET} --lifecycle-configuration '{
    "Rules": [
        {
            "ID": "DeleteOldBackups",
            "Status": "Enabled",
            "Prefix": "${S3_PREFIX}/",
            "Expiration": {
                "Days": 7
            }
        }
    ]
}'
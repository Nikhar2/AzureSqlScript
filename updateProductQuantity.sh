source ~/.bashrc

endpoint=$(aws secretsmanager get-secret-value --secret-id=ion_rds_dev_secrets --region=us-east-1 | jq -r .SecretString | jq -r .rdsEndpoint)
user_name=$(aws secretsmanager get-secret-value --secret-id=ion_rds_dev_secrets --region=us-east-1 | jq -r .SecretString | jq -r .rdsUser)
password=$(aws secretsmanager get-secret-value --secret-id=ion_rds_dev_secrets --region=us-east-1 | jq -r .SecretString | jq -r .rdsPassword)

aws s3 cp s3://balsambrands-ion-scripts/sqlScripts-generic/updateProductQuantities.sql.tmpl .

envsubst < updateProductQuantities.sql.tmpl > ${Environment}updateProductQuantities.sql

sqlcmd -S $endpoint -U $user_name -P $password -i "${Environment}updateProductQuantities.sql"
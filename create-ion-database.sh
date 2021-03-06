#!/bin/bash
source ~/.bashrc

endpoint=nikhar.database.windows.net
user_name=nikhar
password=Cavisson@123
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -i "PurgeDB.sql"
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -Q "create database ${Environment}WarehouseManager;
        create database ${Environment}Trees;
        create database ${Environment}TreesHistory;
        create database ${Environment}International;
        create database ${Environment}InternationalHistory;
        create database ${Environment}Reporting;
        create database ${Environment}Quartz;"

#getSalesforceAccounts="aws s3 cp s3://balsambrands-ion-scripts/salesforce-brands/${Environment}salesforceAccounts.json ${Environment}salesforceAccounts.json"
#$getSalesforceAccounts

#export BalsamhillId=$(jq -r '.result.records[] | select(.Name == "Balsam Hill" ) .Id'  ${Environment}salesforceAccounts.json)
#export TreeClassicsId=$(jq -r '.result.records[] | select(.Name == "Tree Classics" ) .Id'  ${Environment}salesforceAccounts.json)
#export TreetopiaId=$(jq -r '.result.records[] | select(.Name == "Treetopia" ) .Id'  ${Environment}salesforceAccounts.json)
#export ChristmasTreeMarketId=$(jq -r '.result.records[] | select(.Name == "Christmas Tree Market" ) .Id'  ${Environment}salesforceAccounts.json)
#export GreenValleyChristmasTreesId=$(jq -r '.result.records[] | select(.Name == "Green Valley Christmas Trees" ) .Id'  ${Environment}salesforceAccounts.json)
#export BackyardOceanId=$(jq -r '.result.records[] | select(.Name == "Backyard Ocean" ) .Id'  ${Environment}salesforceAccounts.json)
#export BalsamHillUKId=$(jq -r '.result.records[] | select(.Name == "Balsam Hill UK" ) .Id'  ${Environment}salesforceAccounts.json)
#export BalsamHillFranceId=$(jq -r '.result.records[] | select(.Name == "Balsam Hill France" ) .Id'  ${Environment}salesforceAccounts.json)
#export BalsamHillGermanyId=$(jq -r '.result.records[] | select(.Name == "Balsam Hill Germany" ) .Id'  ${Environment}salesforceAccounts.json)
#export BalsamHillAustraliaId=$(jq -r '.result.records[] | select(.Name == "Balsam Hill Australia" ) .Id'  ${Environment}salesforceAccounts.json)
#export TreetopiaEuropeId=$(jq -r '.result.records[] | select(.Name == "Treetopia Europe" ) .Id'  ${Environment}salesforceAccounts.json)

$Environment = ${Environment}
echo $Environment

envsubst < Quartz.sql > QuartzSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Quartz -i "QuartzSubst.sql"
############################################################################################################################
envsubst < Reporting.sql > ReportingSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Reporting -i "ReportingSubst.sql"

envsubst < ReportingData.sql > ReportingDataSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Reporting -i "ReportingDataSubst.sql"
############################################################################################################################

envsubst < Master.sql > MasterSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}WarehouseManager -i "MasterSubst.sql"

envsubst < MasterData.sql > MasterDataSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}WarehouseManager -i "MasterDataSubst.sql"

############################################################################################################################ 

envsubst < ReconciledInventoryTrees.sql > ReconciledInventoryTreesSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d  ${Environment}Trees -i "ReconciledInventoryTreesSubst.sql"

############################################################################################################################

envsubst < ReconciledInventory.sql > ReconciledInventorySubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}International -i "ReconciledInventorySubst.sql"

###############################################################################################################################

envsubst < ReconSkusByStoreTrees.sql > ReconSkusByStoreTreesSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Trees -i "ReconSkusByStoreTreesSubst.sql"

############################################################################################################################

envsubst < ReconSkusByStore.sql > ReconSkusByStoreSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}International -i "ReconSkusByStoreSubst.sql"

############################################################################################################################

envsubst < ReconWarehouseQtyTrees.sql > ReconWarehouseQtyTreesSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Trees -i "ReconWarehouseQtyTreesSubst.sql"

############################################################################################################################

envsubst < ReconWarehouseQty.sql > ReconWarehouseQtySubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}International -i "ReconWarehouseQtySubst.sql"

############################################################################################################################
envsubst < InternationalHistory.sql > InternationalHistorySubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}InternationalHistory -i "InternationalHistorySubst.sql"

envsubst < InternationalHistoryData.sql > InternationalHistoryDataSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}InternationalHistory -i "InternationalHistoryDataSubst.sql"
############################################################################################################################
envsubst < TreesHistory.sql > TreesHistorySubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}TreesHistory -i "TreesHistorySubst.sql"

envsubst < TreesHistoryData.sql > TreesHistoryDataSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}TreesHistory -i "TreesHistoryDataSubst.sql"
############################################################################################################################

envsubst < Trees.sql > TreesSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Trees -i "TreesSubst.sql"

envsubst < TreesData.sql > TreesDataSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}Trees  -i "TreesDataSubst.sql"
############################################################################################################################
envsubst < International.sql > InternationalSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}International -i "InternationalSubst.sql"

envsubst < InternationalData.sql > InternationalDataSubst.sql
/opt/mssql-tools/bin/sqlcmd -S $endpoint -U $user_name -P $password -d ${Environment}International -i "InternationalDataSubst.sql"
############################################################################################################################

#envsubst < UpdateSalesforceJobUrl.sql > UpdateSalesforceJobUrlSubst.sql
#sqlcmd -S $endpoint -U $user_name -P $password -i "UpdateSalesforceJobUrlSubst.sql"
############################################################################################################################

#envsubst < UpdateSalesforceAccountID.sql > UpdateSalesforceAccountIDSubst.sql
#sqlcmd -S $endpoint -U $user_name -P $password -i "UpdateSalesforceAccountIDSubst.sql"

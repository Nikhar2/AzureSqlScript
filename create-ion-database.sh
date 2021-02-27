#!/bin/bash
source ~/.bashrc

endpoint=balsamsqlserver.database.windows.net
user_name=devopsadmin
password=ThisIsCode11
sqlcmd -S $endpoint -U $user_name -P $password -i "PurgeDB.sql"
sqlcmd -S $endpoint -U $user_name -P $password -Q "create database ${Environment}WarehouseManager;
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

envsubst < Master.sql > MasterSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "MasterSubst.sql"

envsubst < MasterData.sql > MasterDataSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "MasterDataSubst.sql"

############################################################################################################################ 

envsubst < ReconciledInventoryTrees.sql > ReconciledInventoryTreesSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReconciledInventoryTreesSubst.sql"

############################################################################################################################

envsubst < ReconciledInventory.sql > ReconciledInventorySubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReconciledInventorySubst.sql"

###############################################################################################################################

envsubst < ReconSkusByStoreTrees.sql > ReconSkusByStoreTreesSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReconSkusByStoreTreesSubst.sql"

############################################################################################################################

envsubst < ReconSkusByStore.sql > ReconSkusByStoreSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReconSkusByStoreSubst.sql"

############################################################################################################################

envsubst < ReconWarehouseQtyTrees.sql > ReconWarehouseQtyTreesSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReconWarehouseQtyTreesSubst.sql"

############################################################################################################################

envsubst < ReconWarehouseQty.sql > ReconWarehouseQtySubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReconWarehouseQtySubst.sql"

############################################################################################################################

envsubst < Trees.sql > TreesSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "TreesSubst.sql"

envsubst < TreesData.sql > TreesDataSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "TreesDataSubst.sql"
############################################################################################################################

envsubst < TreesHistory.sql > TreesHistorySubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "TreesHistorySubst.sql"

envsubst < TreesHistoryData.sql > TreesHistoryDataSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "TreesHistoryDataSubst.sql"
############################################################################################################################

envsubst < International.sql > InternationalSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "InternationalSubst.sql"

envsubst < InternationalData.sql > InternationalDataSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "InternationalDataSubst.sql"
############################################################################################################################

envsubst < InternationalHistory.sql > InternationalHistorySubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "InternationalHistorySubst.sql"

envsubst < InternationalHistoryData.sql > InternationalHistoryDataSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "InternationalHistoryDataSubst.sql"
############################################################################################################################

envsubst < Reporting.sql > ReportingSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReportingSubst.sql"

envsubst < ReportingData.sql > ReportingDataSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "ReportingDataSubst.sql"
############################################################################################################################

envsubst < Quartz.sql > QuartzSubst.sql
sqlcmd -S $endpoint -U $user_name -P $password -i "QuartzSubst.sql"
############################################################################################################################

#envsubst < UpdateSalesforceJobUrl.sql > UpdateSalesforceJobUrlSubst.sql
#sqlcmd -S $endpoint -U $user_name -P $password -i "UpdateSalesforceJobUrlSubst.sql"
############################################################################################################################

#envsubst < UpdateSalesforceAccountID.sql > UpdateSalesforceAccountIDSubst.sql
#sqlcmd -S $endpoint -U $user_name -P $password -i "UpdateSalesforceAccountIDSubst.sql"
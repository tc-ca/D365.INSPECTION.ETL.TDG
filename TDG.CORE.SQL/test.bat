:SETVAR DATABASENAME "adventureworks2014"
:SETVAR CONST_OVERSIGHTTYPE_GCTARGETED "72afccd3-269e-eb11-b1ac-000d3ae924d1"

sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 01_INIT_MASTER_DATA.sql -o initmasterdata.log
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 02_INIT_LEGISLATION_DATA.sql -o INIT_LEGISLATION_DATA_LOG.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 03_INIT_UNPLANNED_FORECAST_DATA.sql -o INIT_UNPLANNED_FORECAST_DATA_LOG.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 04_STAGE_ACCOUNT_DATA.sql -o STAGE_ACCOUNT_DATA_LOG.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 045_STAGE_ACCOUNT_CLASSES.sql -o STAGE_ACCOUNT_CLASSES.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 05_STAGE_CONTACT_DATA.sql -o STAGE_CONTACT_DATA_LOG.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 06_STAGE_WORKORDER_DATA.sql -o STAGE_WORKORDER_DATA_LOG.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 07_STAGE_VIOLATION_DATA.sql -o STAGE_VIOLATION_DATA_LOG.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 08_STAGE_COC_DATA.sql -o STAGE_COC_DATA.txt
sqlcmd -S tdg-data-migration-server.database.windows.net -U tdgcore -P Oversight1! -d tdg-data-migration-db -i 99_PRE_AND_POST_IMPORT_SANITY_CHECKS.sql -o PRE_AND_POST_IMPORT_SANITY_CHECKS.txt
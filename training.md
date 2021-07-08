# chaerin dev
## setup
1. set up profile
1. clone
   1. dbt-msft/jaffle-shop-mssql repo
      1. branch : ext_table_sandbox
   2. fork swanderz/dbt-external-tables
      1. use the materialzed-external-tables
      2. add anders as contrib to your branch
2. install packages (local for dbt-external-tables)
3. add a source
# dbt-external-tables
1. common/stage_external_sources
   1. loop through every source table to make a list of sources to stage:
      1. is it an external table?
         2. if select arg is provided, interpret select arg
   2. with logging, kick off `get_external_build_plan` for each table to stage
1. `sqlserver/get_external_build_plan`
   1. if:
      1. the external table already exisits, or
      2. the user has asked for a full refresh
   2. then:
      1. drop existing table
      2. `create_external_table`
   2. else:
      1. `refresh_external_table`
3. `sqlserver/create_external_table`


## new logic
if external.materialize is true
   1. create an external table newOrgHierarchy2__tmp
   2. create table newOrgHierarchy2
   3. INSERT INTO newOrgHierarchy2 SELECT * FROM newOrgHierarchy2__tmp
   4. drop external table newOrgHierarchy2__tmp
## sqlserver macros for you to look at
1. `sqlserver__create_table_as`
1. `sqlserver__insert_into_from`
## errata
1. `var('ext_full_refresh', false)` means
   get the variable `ext_full_refresh`
   if you can't find it, return the value false

   
# everyone training

## logging in
1. `az login`
2. `az account set --subscription "ff2e23ae-7d7c-4cbd-99b8-116bb94dca6e"`


## airflow-etl-mssql-tech-test
Sample tech test with Airflow with MS SQL.

## Pre-requisite: 
Please run official docker image for airflow.

## Assumptions:
1.) Transactional source data and data warehouse are hosted on the same MS SQL server database. This allowed me to use only Operator i.e. "MsSqlOperator" from Apache Ariflow. Just to avoid more complexity.
2.) DDLs to create source tables and spreadsheet to create source data are provided in repository under folder "/airflow-etl-mssql-tech-test/source/DDL" and"/airflow-etl-mssql-tech-test/source/data" respectively.

## ETL Architecture:
1.) ETL Architecture is based on Snowflake schema and screenshot is placed under location: "airflow-etl-mssql-tech-test/ETL/architecture/architecture_screenshot".

## ETL data flow:
1.) DDLs to create staging tables are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/staging/DDL"
2.) DDLs to create dimensions tables are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/dimensions/DDL"
3.) DDL to create fact table are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/fact/DDL" 
3.) DDL to create report table are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/report/DDL" 
4.) Airflow DAG file is placed under location: "/airflow-etl-mssql-tech-test/ETL/daily_load_test/dags/"
5.) Airflow DAG is used to populate data into staging, dimension, facts and report tables.
5.) Load script for loading data into above tables is placed under location: "/airflow-etl-mssql-tech-test/ETL/daily_load_test/templates"
6.) Screenshots of data into dim, fact and report tables are under location: "airflow-etl-mssql-tech-test/ETL/screenshots"
7.) Screenshot of successful dag run is also avaialble in the repo under location: "airflow-etl-mssql-tech-test/dag_successful_run".

## Airflow Connections:
* MSSQL db connection:
  * `conn_id`: "mssql_conn_id",
  * `conn_type`: "MS SQL Server",
  * `host`: "",   ## use source system login details
  * `port`: ,
  * `schema`: "",
  * `login`: "",      
  * `password`: ""

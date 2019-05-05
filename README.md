## airflow-etl-mssql-tech-test
Sample tech test with Airflow with MS SQL.

## Pre-requisite: 
Please run official docker image for airflow.

## Assumptions:
1.) Transactional source data and data warehouse are hosted on the same MS SQL server database. This allowed me to use only Operator i.e. "MsSqlOperator" from Apache Ariflow. Just to avoid more complexity. <br />
2.) DDLs to create source tables and spreadsheet to create source data are provided in repository under folder "/airflow-etl-mssql-tech-test/source/DDL" and"/airflow-etl-mssql-tech-test/source/data" respectively. <br />

## ETL Architecture:
1.) ETL Architecture is based on Snowflake schema and screenshot is placed under location: "airflow-etl-mssql-tech-test/ETL/architecture/architecture_screenshot". <br />

## ETL data flow:
1.) DDLs to create staging tables are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/staging/DDL". <br />
2.) DDLs to create dimensions tables are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/dimensions/DDL". <br />
3.) DDL to create fact table are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/fact/DDL". <br />
3.) DDL to create report table are provided in repo under location: "/airflow-etl-mssql-tech-test/ETL/report/DDL". <br />
4.) Airflow DAG file is placed under location: "/airflow-etl-mssql-tech-test/ETL/daily_load_test/dags/". <br />
5.) Airflow DAG is used to populate data into staging, dimension, facts and report tables. <br />
5.) Load script for loading data into above tables is placed under location: "/airflow-etl-mssql-tech-test/ETL/daily_load_test/templates". <br />
6.) Screenshots of data into dim, fact and report tables are under location: "airflow-etl-mssql-tech-test/ETL/screenshots". <br />
7.) Screenshot of successful dag run is also avaialble in the repo under location: "airflow-etl-mssql-tech-test/dag_successful_run". <br />

## Airflow Connections:
* MSSQL db connection:
  * `conn_id`: "mssql_conn_id",
  * `conn_type`: "MS SQL Server",
  * `host`: "",   ## use source system login details
  * `port`: ,
  * `schema`: "",
  * `login`: "",      
  * `password`: ""

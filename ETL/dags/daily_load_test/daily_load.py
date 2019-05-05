from datetime import datetime, timedelta

import airflow
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.mssql_operator import MsSqlOperator

default_args = {
    'owner': 'prabha.arya',
    'start_date': datetime(2019, 5, 5, 0, 0, 0),
    'email': 'prabhaarya@yahoo.com',
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 1
}
# ETL load dag for processing daily basis data.
dag = airflow.DAG(
    'daily_load_test',
    schedule_interval='30 8 * * *',             # runs on daily basis at 8:30 am
    dagrun_timeout=timedelta(hours=10),         # dag time out after 10hours
    default_args=default_args,
    template_searchpath='/var/lib/airflow/templates',
    catchup=False,
    max_active_runs=1)

load_start = DummyOperator(task_id='load_start', dag=dag)
finish_stg_load = DummyOperator(task_id='finish_stg_load', dag=dag)

table_dim_list = ['location', 'item']
table_fact_list = ['sales']
table_report_list = ['sales']

# loading data into staging area
for table_name in table_dim_list + table_fact_list:
    stg_task = MsSqlOperator(
        sql='daily_load_test/load_stg_{}.sql'.format(table_name),
        mssql_conn_id='test_aws',
        task_id='load_stg_{}'.format(table_name),
        dag=dag)
    load_start >> stg_task >> finish_stg_load

# loading dims into dw
finish_dim_load = DummyOperator(task_id='finish_dim_load', dag=dag)
for dim in table_dim_list:
    dim_task = MsSqlOperator(
        sql='daily_load_test/load_dim_{}.sql'.format(dim),
        mssql_conn_id='test_aws',
        task_id='load_dim_{}'.format(dim),
        dag=dag)
    finish_stg_load >> dim_task >> finish_dim_load

# loading facts into dw
finish_fact_load = DummyOperator(task_id='finish_fact_load', dag=dag)
for fact in table_fact_list:
    fact_task = MsSqlOperator(
        sql='daily_load_test/load_fact_{}.sql'.format(fact),
        mssql_conn_id='test_aws',
        task_id='load_fact_{}'.format(fact),
        dag=dag)
    finish_dim_load >> fact_task >> finish_fact_load

# generating reports
finish_load = DummyOperator(task_id='finish_load', dag=dag)
for report in table_report_list:
    generate_sales_report = MsSqlOperator(
            sql='daily_load_test/generate_{}_report.sql'.format(report),
            mssql_conn_id='test_aws',
            task_id='generate_{}_report'.format(report),
            dag=dag)
    finish_fact_load >> generate_sales_report >> finish_load

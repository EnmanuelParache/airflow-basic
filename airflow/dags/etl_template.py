"""Simple dag with task trio as template for ETL"""
import datetime

from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator

default_args = {
    'start_date': datetime.datetime(2000, 1, 1),
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=5),
}

dag = DAG(
    'etl_template',
    default_args=default_args,
    description='Simple ETL',
    schedule='*/10 * * * *',
    max_active_runs=2,
    catchup=False,
    dagrun_timeout=datetime.timedelta(minutes=10),
)

# priority_weight has type int in Airflow DB, uses the maximum.
t1 = BashOperator(
    task_id='extract',
    bash_command='echo "Extract"',
    dag=dag,
    depends_on_past=False,
    priority_weight=2**31 - 1,
    do_xcom_push=False)

t2 = BashOperator(
    task_id='transform',
    bash_command='echo "Transform"',
    dag=dag,
    depends_on_past=False,
    priority_weight=2**31 - 1,
    do_xcom_push=False)

t3 = BashOperator(
    task_id='load',
    bash_command='echo "Load"',
    dag=dag,
    depends_on_past=False,
    priority_weight=2**31 - 1,
    do_xcom_push=False)

t1 >> t2
t2 >> t3
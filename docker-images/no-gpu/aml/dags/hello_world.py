# ~/airflow/dags/HelloWorld.py

from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta


def print_hello():
    return 'Hello world!'


dag = DAG('hello_world',
          description='Simple tutorial DAG',
          start_date=datetime.now() - timedelta(days=4),
          schedule_interval='0 12 * * *'
          )

dummy_operator = DummyOperator(task_id='dummy_task', retries=3, dag=dag)

hello_operator = PythonOperator(task_id='hello_task',
                                python_callable=print_hello,
                                dag=dag)

# same as  dummy_operator.set_downstream(hello_operator)
dummy_operator >> hello_operator

from psycopg2 import sql
import psycopg2
from decouple import config

def dbconect():
    try:
        conn = psycopg2.connect(
        dbname=config('DBNAME'),
        user=config('DBUSER'),
        host=config('DBHOST'),
        password=config('DBPASSWORD'),
        port=config('DBPORT')
        )
        print('connection success')
        return conn
    except psycopg2.OperationalError as e:
        print(f"Erro to connect {e}")
        return None
dbconect()
# DBNAME=ubotdatabase
# DBUSER=gustavo
# DBHOST=localhost
# DBPASSWORD=danidani
# DBPORT=5432
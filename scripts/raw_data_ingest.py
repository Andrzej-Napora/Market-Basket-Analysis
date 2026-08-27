from pathlib import Path
import os
import psycopg2

postgres_user = os.getenv("POSTGRES_USER")
postgres_password = os.getenv("POSTGRES_PASSWORD")
postgres_db = os.getenv("POSTGRES_DB")

sql_path = Path("/sql/raw_ingestion.sql")
query_string = sql_path.read_text(encoding="utf-8")

with psycopg2.connect(database = postgres_db, 
                        user = postgres_user, 
                        host= 'postgres',
                        password = postgres_password,
                        port = 5432) as connection:
    with connection.cursor() as cursor:
        cursor.execute(query_string)



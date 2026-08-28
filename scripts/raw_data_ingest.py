from pathlib import Path
import os
import psycopg2

postgres_user = os.getenv("POSTGRES_USER")
postgres_password = os.getenv("POSTGRES_PASSWORD")
postgres_db = os.getenv("POSTGRES_DB")

required_tables = {
    "aisles",
    "departments",
    "orders",
    "products",
    "order_products__prior",
    "order_products__train",
}

with psycopg2.connect(
    dbname=postgres_db,
    user=postgres_user,
    password=postgres_password,
    host="postgres",
    port=5432,
) as connection:
    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = 'raw'
            """
        )

        existing_tables = {
            row[0]
            for row in cursor.fetchall()
        }

        if required_tables.issubset(existing_tables):
            print("Raw tables already exist. Ingestion skipped.")
        else:
            sql_query = Path(
                "/sql/raw_ingestion.sql"
            ).read_text(encoding="utf-8")

            cursor.execute(sql_query)

            print("Raw ingestion completed.")



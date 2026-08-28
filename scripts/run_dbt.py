import os
import subprocess

import psycopg2


postgres_user = os.getenv("POSTGRES_USER")
postgres_password = os.getenv("POSTGRES_PASSWORD")
postgres_db = os.getenv("POSTGRES_DB")


def final_model_exists():
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
                SELECT to_regclass('dbt_dev.reorder_features')
                """
            )

            result = cursor.fetchone()[0]

    return result is not None


if final_model_exists():
    print(
        "The final dbt model already exists. "
        "Skipping dbt build."
    )
else:
    print(
        "The final dbt model does not exist. "
        "Starting dbt build."
    )

    subprocess.run(
        [
            "dbt",
            "build",
            "--project-dir",
            "/app/dbt/instacart",
            "--target",
            "dev",
        ],
        check=True,
    )

    print("dbt build completed successfully.")
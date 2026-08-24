# Instacart Market Basket Analysis

A work-in-progress data engineering project with an applied machine learning component.

The goal is to build a reproducible pipeline that prepares Instacart transaction data and predicts whether a user will reorder a previously purchased product.

# Pipeline

CSV files
→ PostgreSQL raw tables
→ dbt staging models
→ dbt intermediate models
→ dbt_dev.reorder_features
→ JupyterLab
→ machine learning ensemble

The dbt project contains data quality tests and feature models.

# Technology stack:

PostgreSQL and SQL
dbt Core
Docker Compose
Python and JupyterLab
Pandas and SQLAlchemy
scikit-learn, XGBoost and LightGBM
Optuna and SQLite


# Dataset

The project uses the Instacart Market Basket Analysis dataset.

The CSV files are not included in the repository because of their size. You can download it at: 
    https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis

After download place CSV files into ./data/ directory.

# Running the project

Create a .env file based on .env.example, then start the environment:
    docker compose up

Copy the CSV files into the PostgreSQL container:
    docker compose cp "./data/." postgres:/tmp/

Run the ./sql/raw_ingestion.sql script, then build the dbt project:
    docker compose run --rm dbt dbt build --project-dir "/app/dbt/instacart" --target dev

# Connecting to PostgreSQL

After starting the environment, create a PostgreSQL connection in VS Code, DBeaver, pgAdmin, or another database client.

Use the following settings:

Host: localhost
Port: 5432
Database: value of POSTGRES_DB from .env
Username: value of POSTGRES_USER from .env
Password: value of POSTGRES_PASSWORD from .env


# Accessing JupyterLab

JupyterLab is available at: http://localhost:8888

After 'docker compose up' search terminal for lines similiar to:
http://localhost:8888/lab?token=ba6a115624519cd432ef3f3b345bf3172f05100ebe27485c     
http://127.0.0.1:8888/lab?token=ba6a115624519cd432ef3f3b345bf3172f05100ebe27485c
or search these line in: 
    docker compose logs jupyter

you can either copy token from lines above into http://localhost:8888, or copy one of these URLs into your browser.


# Machine learning

The current notebook uses a sample of one million user-product observations.

Users are separated between training, validation, and test sets to prevent the same user from appearing in multiple splits. The final prediction combines:

Random Forest
XGBoost
LightGBM

Optuna stores completed experiments in SQLite, while trained models and ensemble settings are saved with Joblib.

Current ensemble validation results:
    ROC-AUC:            0.8547
    Average Precision:  0.4554
    F1-score:           0.4632

These results are still work in progress.

# Current status

Completed:

Docker Compose development environment
layered dbt architecture
data quality tests
SQL feature engineering on multi-million-row tables
model tuning and weighted ensemble

# Still in progress:

automated raw-data ingestion
notebook cleanup and ML improvements
final test-set evaluation
Power BI dashboard
pipeline orchestration
Apache Airflow implementation for further workflow automation

This project is mainly focused on learning practical data engineering through PostgreSQL, dbt, Docker, data quality testing, and large-scale SQL transformations.
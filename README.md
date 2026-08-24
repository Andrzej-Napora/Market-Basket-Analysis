# Instacart Market Basket Analysis

A work-in-progress data engineering project with an applied machine learning component.

The goal is to build a reproducible pipeline that prepares Instacart transaction data and predicts whether a user will reorder a previously purchased product.

# Pipeline

CSV files<br>
→ PostgreSQL raw tables<br>
→ dbt staging models<br>
→ dbt intermediate models<br>
→ dbt_dev.reorder_features<br>
→ JupyterLab<br>
→ machine learning ensemble<br>

The dbt project contains data quality tests and feature models.

# Technology stack:

PostgreSQL and SQL<br>
dbt Core<br>
Docker Compose<br>
Python and JupyterLab<br>
Pandas and SQLAlchemy<br>
scikit-learn, XGBoost and LightGBM<br>
Optuna and SQLite<br>


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

Host: localhost<br>
Port: 5432<br>
Database: value of POSTGRES_DB from .env<br>
Username: value of POSTGRES_USER from .env<br>
Password: value of POSTGRES_PASSWORD from .env<br>


# Accessing JupyterLab

JupyterLab is available at: http://localhost:8888

After 'docker compose up' search terminal for lines similiar to:<br>
http://localhost:8888/lab?token=ba6a115624519cd432ef3f3b345bf3172f05100ebe27485c<br>   
http://127.0.0.1:8888/lab?token=ba6a115624519cd432ef3f3b345bf3172f05100ebe27485c<br>
or search these line in: 
    docker compose logs jupyter

you can either copy token from lines above into http://localhost:8888, or copy one of these URLs into your browser.


# Machine learning

The current notebook uses a sample of one million user-product observations.

Users are separated between training, validation, and test sets to prevent the same user from appearing in multiple splits. The final prediction combines:

Random Forest<br>
XGBoost<br>
LightGBM<br>

Optuna stores completed experiments in SQLite, while trained models and ensemble settings are saved with Joblib.

Current ensemble validation results:<br>
    ROC-AUC:            0.8547<br>
    Average Precision:  0.4554<br>
    F1-score:           0.4632<br>

These results are still work in progress.

# Current status

Completed:

Docker Compose development environment<br>
layered dbt architecture<br>
data quality tests<br>
SQL feature engineering on multi-million-row tables<br>
model tuning and weighted ensemble<br>

# Still in progress:

automated raw-data ingestion<br>
notebook cleanup and ML improvements<br>
final test-set evaluation<br>
Power BI dashboard<br>
pipeline orchestration<br>
Apache Airflow implementation for further workflow automation<br>

This project is mainly focused on learning practical data engineering through PostgreSQL, dbt, Docker, data quality testing, and large-scale SQL transformations.
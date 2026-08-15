import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv("data/raw/order_products__prior.csv")

engine = create_engine(
    "postgresql+psycopg://postgres@localhost:5432/instacart"
)

df.to_sql(
    "order_products_prior",
    engine,if_exists="append",
    index=False
)


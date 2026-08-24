create database instacart
select current_database(), current_user;

create schema raw

CREATE TABLE raw.departments (
    department_id integer primary key,
    department varchar(100)
);

Copy raw.departments
from '/tmp/departments.csv'
with(
    format csv,
    header true
)

select * from raw.departments limit 10


CREATE TABLE raw.order_products__prior (
    order_id integer,
    product_id integer,
    add_to_cart_order integer,
    reordered integer
);


copy raw.order_products__prior
from '/tmp/order_products__prior.csv'
with(
    format csv,
    header true
)

select * from raw.order_products__prior limit 10


select count(*) from raw.order_products__prior limit 10


create table raw.aisles(
    aisle_id integer,
    aisle varchar(100)
)

copy raw.aisles
from '/tmp/aisles.csv'
with(
    format csv,
    header true
)

select count(*) from raw.aisles limit 10

create table raw.order_products__train
(
    order_id integer,
    product_id integer,
    add_to_cart_order integer,
    reordered integer
)

copy raw.order_products__train
from '/tmp/order_products__train.csv'
with(
    format csv,
    header true
)

select count(*) from raw.order_products__train limit 10

create table raw.orders(
    order_id integer,
    user_id integer,
    eval_set varchar(10),
    order_number integer,
    order_dow integer,
    order_hour_of_day integer,
    days_since_prior_order float
)

copy raw.orders
from '/tmp/orders.csv'
with(
    format csv,
    header true
)

select count(*) from raw.orders limit 10

create table raw.products(
    product_id integer,
    product_name varchar(300),
    aisle_id integer,
    department_id integer
)

select tablename from pg_tables where schemaname='raw'

copy raw.products
from '/tmp/products.csv'
with(
    format csv,
    header true
)

select tablename from pg_tables where schemaname = 'raw'


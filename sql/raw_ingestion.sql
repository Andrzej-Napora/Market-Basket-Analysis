create schema raw;

drop table if exists raw.departments;
CREATE TABLE raw.departments (
    department_id integer primary key,
    department varchar(100)
);

Copy raw.departments
from '/data/departments.csv'
with(
    format csv,
    header true
);

drop table if exists raw.order_products__prior;
CREATE TABLE raw.order_products__prior (
    order_id integer,
    product_id integer,
    add_to_cart_order integer,
    reordered integer
);


copy raw.order_products__prior
from '/data/order_products__prior.csv'
with(
    format csv,
    header true
);

drop table if exists raw.aisles;
create table raw.aisles(
    aisle_id integer,
    aisle varchar(100)
);

copy raw.aisles
from '/data/aisles.csv'
with(
    format csv,
    header true
);

drop table if exists raw.order_products__train;
create table raw.order_products__train
(
    order_id integer,
    product_id integer,
    add_to_cart_order integer,
    reordered integer
);

copy raw.order_products__train
from '/data/order_products__train.csv'
with(
    format csv,
    header true
);

drop table if exists raw.orders;
create table raw.orders(
    order_id integer,
    user_id integer,
    eval_set varchar(10),
    order_number integer,
    order_dow integer,
    order_hour_of_day integer,
    days_since_prior_order float
);

copy raw.orders
from '/data/orders.csv'
with(
    format csv,
    header true
);

drop table if exists raw.products;
create table raw.products(
    product_id integer,
    product_name varchar(300),
    aisle_id integer,
    department_id integer
);

copy raw.products
from '/data/products.csv'
with(
    format csv,
    header true
);
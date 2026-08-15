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


CREATE TABLE raw.order_products_prior (
    order_id integer,
    product_id integer,
    add_to_cart_order integer,
    reordered integer
);

copy raw.order_products_prior
from '/tmp/order_products__prior.csv'
with(
    format csv,
    header true
)

select * from raw.order_products_prior limit 10


select count(*) from raw.order_products_prior limit 10


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

create table raw.order_products_train
(
    order_id integer,
    product_id integer,
    add_to_cart_order integer,
    reordered integer
)

copy raw.order_products_train
from '/tmp/order_products__train.csv'
with(
    format csv,
    header true
)

select count(*) from raw.order_products_train limit 10

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

select count(*) from raw.products limi 10

select tablename from pg_tables where schemaname = 'raw'

select
    count(*) filter (where order_id is null) as missing_order_id,
    count(*) filter (where product_id is null) as missing_product_id,
    count(*) filter (where add_to_cart_order is null) as missing_cart_order,
    count(*) filter (where reordered is null) as reordered
from raw.order_products_prior
limit 100

select 
    count(*) filter (where aisle_id is null) as missing_id,
    count(*) filter (where aisle is null) as missing_aisel
from raw.aisles
limit 100

select
    count(*) filter (where order_id is null) as missing_order_id,
    count(*) filter (where product_id is null)as missing_product_id,
    count(*) filter (where add_to_cart_order is null)as missing_add_to_cart_order,
    count(*) filter (where reordered is null)as missing_reordered
from raw.order_products_train
limit 100

select
    count(*) filter (where order_id is null) as missin_order_id ,
    count(*) filter (where user_id is null) as missin_user_id ,
    count(*) filter (where eval_set is null) as missin_eval_set ,
    count(*) filter (where order_number is null) as missin_order_number ,
    count(*) filter (where order_dow is null) as missin_order_dow ,
    count(*) filter (where order_hour_of_day is null)  as missin_order_hour_of_day ,
    count(*) filter (where days_since_prior_order is null) as missin_days_since_prior_order 
from raw.orders
limit 100

select
    count(*) filter (where product_id is null) as missin_product_id ,
    count(*) filter (where product_name is null) as missin_product_name,
    count(*) filter (where aisle_id is null) as missin_aisle_id ,
    count(*) filter (where department_id is null) as missin_department_id 
from raw.products
limit 100













create table analytics.user_product_reordered as
SELECT
        o.user_id,
        opp.product_id,
        COUNT(opp.reordered) AS reorder_count

    FROM raw.orders AS o

    JOIN raw.order_products_prior AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'
      AND opp.reordered = 1

    GROUP BY
        o.user_id,
        opp.product_id;

create unique index idx_user_product_reordered
on analytics.user_product_reordered(
user_id,
product_id
);

analyze analytics.user_product_reordered;


create table analytics.user_product_summary as
    SELECT
        o.user_id,
        opp.product_id,

        COUNT(opp.product_id) AS user_product_purchase_count,

        MAX(o.order_number) AS last_product_order_number,

        AVG(opp.add_to_cart_order)
            AS avg_product_cart_position

    FROM raw.orders AS o

    JOIN raw.order_products_prior AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'

    GROUP BY
        o.user_id,
        opp.product_id;

create unique index idx_user_product_summary
on analytics.user_product_summary(
user_id,
product_id
);

analyze analytics.user_product_summary;

create table analytics.user_order_summary AS
    SELECT
        user_id,

        COUNT(order_id) AS total_prior_orders,

        MAX(order_number) AS last_prior_order_number

    FROM raw.orders

    WHERE eval_set = 'prior'

    GROUP BY
        user_id;

create unique index idx_user_order_summary
on analytics.user_order_summary(
user_id
);

analyze analytics.user_order_summary;


create table analytics.user_product_recency AS 
    SELECT
        uos.user_id,
        ups.product_id,

        uos.last_prior_order_number
            - ups.last_product_order_number
            AS orders_since_last_purchase

    FROM analytics.user_order_summary AS uos

    JOIN analytics.user_product_summary AS ups
        ON uos.user_id = ups.user_id;

create unique index idx_user_product_recency
on analytics.user_product_recency(
user_id,
product_id
);

analyze analytics.user_product_recency;


create table analytics.products_per_order AS 
    SELECT
        o.user_id,
        o.order_id,
        o.order_number,

        COUNT(opp.product_id) AS basket_size

    FROM raw.orders AS o

    JOIN raw.order_products_prior AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'

    GROUP BY
        o.user_id,
        o.order_id,
        o.order_number;

create unique index idx_products_per_order
on analytics.products_per_order(
user_id,
order_id
);

analyze analytics.products_per_order;


create table analytics.products_purchased_since_last_purchase AS
    SELECT
        ups.user_id,
        ups.product_id,

        COALESCE(
            SUM(ppo.basket_size),
            0
        ) AS products_since_last_purchase

    FROM analytics.user_product_summary AS ups

    LEFT JOIN analytics.products_per_order AS ppo
        ON ups.user_id = ppo.user_id
        AND ppo.order_number
            > ups.last_product_order_number

    GROUP BY
        ups.user_id,
        ups.product_id;

create unique index idx_products_purchased_since_last_purchase
on analytics.products_purchased_since_last_purchase(
user_id,
product_id
);

analyze analytics.products_purchased_since_last_purchase;

create table analytics.user_product_day_counts AS
    SELECT
        o.user_id,
        opp.product_id,
        o.order_dow,

        COUNT(opp.product_id) AS purchases_on_day

    FROM raw.orders AS o

    JOIN raw.order_products_prior AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'

    GROUP BY
        o.user_id,
        opp.product_id,
        o.order_dow;

create index idx_user_product_day_counts
on analytics.user_product_day_counts(
user_id,
product_id
);

analyze analytics.user_product_day_counts;


create table analytics.ranked_user_product_days AS 
    SELECT
        user_id,
        product_id,
        order_dow,
        purchases_on_day,

        ROW_NUMBER() OVER (
            PARTITION BY
                user_id,
                product_id
            ORDER BY
                purchases_on_day DESC,
                order_dow ASC
        ) AS day_rank

    FROM analytics.user_product_day_counts;

create index idx_ranked_user_product_days
on analytics.ranked_user_product_days(
user_id,
product_id
);

analyze analytics.ranked_user_product_days;


create table analytics.user_product_hour_counts AS
    SELECT
        o.user_id,
        opp.product_id,
        o.order_hour_of_day,

        COUNT(opp.product_id) AS purchases_at_hour

    FROM raw.orders AS o

    JOIN raw.order_products_prior AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'

    GROUP BY
        o.user_id,
        opp.product_id,
        o.order_hour_of_day;

create index idx_user_product_hour_counts
on analytics.user_product_hour_counts(
user_id,
product_id
);

analyze analytics.user_product_hour_counts;


create table analytics.ranked_user_product_hours AS
    SELECT
        user_id,
        product_id,
        order_hour_of_day,
        purchases_at_hour,

        ROW_NUMBER() OVER (
            PARTITION BY
                user_id,
                product_id
            ORDER BY
                purchases_at_hour DESC,
                order_hour_of_day ASC
        ) AS hour_rank

    FROM analytics.user_product_hour_counts;

create index idx_ranked_user_product_hours
on analytics.ranked_user_product_hours(
user_id,
product_id
);

analyze analytics.ranked_user_product_hours;



create table analytics.favorite_user_product_hour AS
    SELECT
        user_id,
        product_id,

        order_hour_of_day
            AS most_frequent_purchase_hour,

        purchases_at_hour
            AS purchases_in_favorite_hour

    FROM analytics.ranked_user_product_hours

    WHERE hour_rank = 1;

create unique index idx_favorite_user_product_hour
on analytics.favorite_user_product_hour(
user_id,
product_id
);

analyze analytics.favorite_user_product_hour;


CREATE TABLE analytics.reorder_targets AS
SELECT
    ups.user_id,
    ups.product_id,

    CASE
        WHEN opt.product_id IS NOT NULL THEN 1
        ELSE 0
    END AS target

FROM analytics.user_product_summary AS ups

JOIN raw.orders AS train_order
    ON ups.user_id = train_order.user_id
    AND train_order.eval_set = 'train'

LEFT JOIN raw.order_products_train AS opt
    ON train_order.order_id = opt.order_id
    AND ups.product_id = opt.product_id;

create unique index idx_reorder_targets
on analytics.reorder_targets(
    user_id,
    product_id
)

analyze analytics.reorder_targets;





DROP TABLE IF EXISTS analytics.user_purchase_summary;

CREATE TABLE analytics.user_purchase_summary AS
SELECT
    o.user_id,

    COUNT(opp.product_id) AS total_product_purchases,

    COUNT(opp.product_id) FILTER (
        WHERE opp.reordered = 1
    ) AS total_reordered_purchases,

    COUNT(opp.product_id) FILTER (
        WHERE opp.reordered = 1
    ) * 100.0
        / NULLIF(COUNT(opp.product_id), 0)
        AS user_reorder_rate_percent

FROM raw.orders AS o

JOIN raw.order_products_prior AS opp
    ON o.order_id = opp.order_id

WHERE o.eval_set = 'prior'

GROUP BY
    o.user_id;

CREATE UNIQUE INDEX idx_user_purchase_summary
ON analytics.user_purchase_summary (user_id);

ANALYZE analytics.user_purchase_summary;





DROP TABLE IF EXISTS analytics.user_product_count_summary;

CREATE TABLE analytics.user_product_count_summary AS
SELECT
    ups.user_id,

    COUNT(ups.product_id) AS unique_products_purchased,

    COUNT(upr.product_id) AS unique_reordered_products,

    COUNT(upr.product_id) * 100.0
        / NULLIF(COUNT(ups.product_id), 0)
        AS unique_product_reorder_rate_percent

FROM analytics.user_product_summary AS ups

LEFT JOIN analytics.user_product_reordered AS upr
    ON ups.user_id = upr.user_id
    AND ups.product_id = upr.product_id

GROUP BY
    ups.user_id;


CREATE UNIQUE INDEX idx_user_product_count_summary
ON analytics.user_product_count_summary (user_id);

ANALYZE analytics.user_product_count_summary;




DROP TABLE IF EXISTS analytics.user_model_features;

CREATE TABLE analytics.user_model_features AS
SELECT
    uos.user_id,

    uos.total_prior_orders,

    ups.total_product_purchases,

    ups.total_reordered_purchases,

    ups.total_product_purchases * 1.0
        / NULLIF(uos.total_prior_orders, 0)
        AS avg_basket_size,

    ups.user_reorder_rate_percent,

    upcs.unique_products_purchased,

    upcs.unique_reordered_products,

    upcs.unique_product_reorder_rate_percent

FROM analytics.user_order_summary AS uos

JOIN analytics.user_purchase_summary AS ups
    ON uos.user_id = ups.user_id

JOIN analytics.user_product_count_summary AS upcs
    ON uos.user_id = upcs.user_id;


CREATE UNIQUE INDEX idx_user_model_features
ON analytics.user_model_features (user_id);

ANALYZE analytics.user_model_features;





DROP TABLE IF EXISTS analytics.favorite_user_product_day;

CREATE TABLE analytics.favorite_user_product_day AS
SELECT
    user_id,
    product_id,

    order_dow AS most_frequent_purchase_day,

    purchases_on_day AS purchases_on_favorite_day

FROM analytics.ranked_user_product_days

WHERE day_rank = 1;


CREATE UNIQUE INDEX idx_favorite_user_product_day
ON analytics.favorite_user_product_day (
    user_id,
    product_id
);

ANALYZE analytics.favorite_user_product_day;







DROP TABLE IF EXISTS analytics.user_product_model_features;

CREATE TABLE analytics.user_product_model_features AS
SELECT
    ups.user_id,
    ups.product_id,

    ups.user_product_purchase_count,

    ups.last_product_order_number,

    upr.orders_since_last_purchase,

    ppslp.products_since_last_purchase,

    ups.avg_product_cart_position,

    fupd.most_frequent_purchase_day,

    fupd.purchases_on_favorite_day,

    fuph.most_frequent_purchase_hour,

    fuph.purchases_in_favorite_hour

FROM analytics.user_product_summary AS ups

JOIN analytics.user_product_recency AS upr
    ON ups.user_id = upr.user_id
    AND ups.product_id = upr.product_id

JOIN analytics.products_purchased_since_last_purchase AS ppslp
    ON ups.user_id = ppslp.user_id
    AND ups.product_id = ppslp.product_id

JOIN analytics.favorite_user_product_day AS fupd
    ON ups.user_id = fupd.user_id
    AND ups.product_id = fupd.product_id

JOIN analytics.favorite_user_product_hour AS fuph
    ON ups.user_id = fuph.user_id
    AND ups.product_id = fuph.product_id;


CREATE UNIQUE INDEX idx_user_product_model_features
ON analytics.user_product_model_features (
    user_id,
    product_id
);

ANALYZE analytics.user_product_model_features;






DROP TABLE IF EXISTS analytics.reorder_features;

CREATE TABLE analytics.reorder_features AS
SELECT
    upmf.user_id,
    upmf.product_id,

    p.product_name,

    d.department_id,
    d.department,

    rt.target,

    upmf.user_product_purchase_count,

    ROUND(
        (
            upmf.user_product_purchase_count * 1.0
            / NULLIF(umf.total_prior_orders, 0)
        )::NUMERIC,
        2
    ) AS product_purchases_per_order,

    umf.total_prior_orders,

    umf.total_product_purchases,

    ROUND(
        umf.avg_basket_size::NUMERIC,
        2
    ) AS avg_basket_size,

    ROUND(
        umf.user_reorder_rate_percent::NUMERIC,
        2
    ) AS user_reorder_rate_percent,

    umf.unique_products_purchased,

    umf.unique_reordered_products,

    ROUND(
        umf.unique_product_reorder_rate_percent::NUMERIC,
        2
    ) AS unique_product_reorder_rate_percent,

    upmf.last_product_order_number,

    upmf.orders_since_last_purchase,

    upmf.products_since_last_purchase,

    ROUND(
        upmf.avg_product_cart_position::NUMERIC,
        2
    ) AS avg_product_cart_position,

    upmf.most_frequent_purchase_day,

    upmf.purchases_on_favorite_day,

    ROUND(
        (
            upmf.purchases_on_favorite_day * 100.0
            / NULLIF(upmf.user_product_purchase_count, 0)
        )::NUMERIC,
        2
    ) AS purchase_share_on_favorite_day_percent,

    upmf.most_frequent_purchase_hour,

    upmf.purchases_in_favorite_hour,

    ROUND(
        (
            upmf.purchases_in_favorite_hour * 100.0
            / NULLIF(upmf.user_product_purchase_count, 0)
        )::NUMERIC,
        2
    ) AS purchase_share_in_favorite_hour_percent

FROM analytics.user_product_model_features AS upmf

JOIN analytics.reorder_targets AS rt
    ON upmf.user_id = rt.user_id
    AND upmf.product_id = rt.product_id

JOIN analytics.user_model_features AS umf
    ON upmf.user_id = umf.user_id

JOIN raw.products AS p
    ON upmf.product_id = p.product_id

JOIN raw.departments AS d
    ON p.department_id = d.department_id;


CREATE UNIQUE INDEX idx_reorder_features
ON analytics.reorder_features (
    user_id,
    product_id
);

ANALYZE analytics.reorder_features;
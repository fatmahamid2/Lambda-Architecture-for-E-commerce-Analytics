CREATE TABLE IF NOT EXISTS seller_dim (
    seller_sk SERIAL PRIMARY KEY,
    seller_id TEXT,
    seller_name TEXT,
    seller_zip_code_prefix VARCHAR(50),
    seller_city TEXT,
    seller_state TEXT,
    seller_state_full TEXT,
    geolocation_lat DOUBLE PRECISION,
    geolocation_lng DOUBLE PRECISION,
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN
);

CREATE TABLE IF NOT EXISTS customer_dim (
    customer_sk SERIAL PRIMARY KEY,
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix varchar(50),
    customer_city TEXT,
    customer_state TEXT,
    gender TEXT,
    age INTEGER,
    marital_status TEXT,
    customer_state_full TEXT,
    geolocation_lat DOUBLE PRECISION,
    geolocation_lng DOUBLE PRECISION,
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN
);

CREATE TABLE IF NOT EXISTS product_dim (
    product_sk SERIAL PRIMARY KEY,
    product_id TEXT,
    product_name TEXT,
    product_category_name_english TEXT,
    product_category_name TEXT,
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER,
    product_weight_g INTEGER,
    product_volume_cm3 INTEGER
);

CREATE TABLE IF NOT EXISTS payment_dim (
    order_payment_sk SERIAL PRIMARY KEY,
    order_id TEXT,
    payment_sequential INTEGER,
    payment_type TEXT,
    payment_installments INTEGER,
    payment_value DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS reviews_dim (
    review_sk SERIAL PRIMARY KEY,
    review_id TEXT,
    review_score INTEGER,
    review_title TEXT,
    review_message TEXT,
    review_creation_date DATE,
    review_answer_timestamp TIMESTAMP,
    review_title_en TEXT,
    review_message_en TEXT
);

CREATE TABLE date_dim (
    SK_Date INTEGER PRIMARY KEY,     -- e.g., 20160101
    Date DATE,              -- actual date, e.g., '2016-01-01'
    Day INTEGER,            -- day of the month, e.g., 1
    DayName TEXT,           -- name of the day, e.g., 'Friday'
    DayOfWeek INTEGER,      -- 1 = Sunday, 2 = Monday, ..., 7 = Saturday (or adjust to your logic)
    Month INTEGER,          -- numeric month, e.g., 1
    MonthName TEXT,         -- full month name, e.g., 'January'
    Year INTEGER,           -- e.g., 2016
    IsWeekend BOOLEAN       -- TRUE if weekend, FALSE otherwise
);

CREATE TABLE IF NOT EXISTS reviews_dim (
    review_sk serial PRIMARY KEY,                  -- long is equivalent to BIGINT
    review_id TEXT,                                -- string can be mapped to TEXT
	order_id TEXT,
    review_title TEXT,
    review_title_en TEXT,
    review_message TEXT,
    review_message_en TEXT,
    review_score INTEGER,
    review_status TEXT,                   -- Added review_status column
    review_creation_date TIMESTAMP,                -- Adjusted to TIMESTAMP
    review_answer_timestamp TIMESTAMP,
    SSC INTEGER                          -- Added SSC column
);

CREATE TABLE fact_orders (
    order_sk BIGSERIAL PRIMARY KEY,
    
    customer_sk INTEGER,
    product_sk INTEGER,
    seller_sk INTEGER,
    review_sk INTEGER,
    order_payment_sk INTEGER,
    
    order_id VARCHAR,
    order_item_id INTEGER,
    
    purchase_date_key INTEGER,
    order_approval_date_key INTEGER,
    delivery_to_carrier_date_key INTEGER,
    delivery_to_customer_date_key INTEGER,
    estimated_delivery_date_key INTEGER,
    shipping_limit_date_key INTEGER,
    
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    shipping_limit_date TIMESTAMP,
    
    price DOUBLE PRECISION,
    freight_value DOUBLE PRECISION,
    total_products_value DOUBLE PRECISION,
    total_freight_value DOUBLE PRECISION,
    total_order_price DOUBLE PRECISION,

    -- Foreign Key Constraints
    FOREIGN KEY (customer_sk) REFERENCES customer_dim(customer_sk),
    FOREIGN KEY (product_sk) REFERENCES product_dim(product_sk),
    FOREIGN KEY (seller_sk) REFERENCES seller_dim(seller_sk),
    FOREIGN KEY (review_sk) REFERENCES reviews_dim(review_sk),
    FOREIGN KEY (order_payment_sk) REFERENCES payment_dim(order_payment_sk),

    FOREIGN KEY (purchase_date_key) REFERENCES date_dim(sk_date),
    FOREIGN KEY (order_approval_date_key) REFERENCES date_dim(sk_date),
    FOREIGN KEY (delivery_to_carrier_date_key) REFERENCES date_dim(sk_date),
    FOREIGN KEY (delivery_to_customer_date_key) REFERENCES date_dim(sk_date),
    FOREIGN KEY (estimated_delivery_date_key) REFERENCES date_dim(sk_date),
    FOREIGN KEY (shipping_limit_date_key) REFERENCES date_dim(sk_date)
);


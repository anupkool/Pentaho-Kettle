/* source_db */
DROP TABLE IF EXISTS source_db.product_raw;
CREATE TABLE source_db.product_raw (
  product_id int(11) NOT NULL DEFAULT '0' COMMENT 'Primary key for Product records.',
  product_name varchar(100) NOT NULL DEFAULT '-' COMMENT 'Name of the product.',
  make_flag tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 = Product is purchased, 1 = Product is manufactured in-house.',
  finished_goods_flag tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 = Product is not a salable item. 1 = Product is salable.',
  color varchar(15) DEFAULT NULL COMMENT 'Product color.',
  product_subcategory varchar(100) COMMENT 'Subcategory description.',
  product_category varchar(100) COMMENT 'Category description.',
  model_name varchar(100) COMMENT 'Product model description.',
  size_unit_measure varchar(100) COMMENT 'Unit of measure description.',
  weight_unit_measure varchar(100) COMMENT 'Unit of measure description.',
  list_price decimal(19,4) COMMENT 'Product list price.',
  modified_date datetime NOT NULL DEFAULT '1900-01-01 00:00:00' COMMENT 'List price start date.',
  PRIMARY KEY (product_id,modified_date)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS source_db.customer_raw;
CREATE TABLE source_db.customer_raw (
  customer_id int(11) NOT NULL COMMENT 'Primary key for Person records.',
  title varchar(8) DEFAULT NULL COMMENT 'A courtesy title. For example, Mr. or Ms.',
  first_name varchar(100) NOT NULL COMMENT 'First name of the person.',
  middle_name varchar(100) DEFAULT NULL COMMENT 'Middle name or middle initial of the person.',
  last_name varchar(100) NOT NULL COMMENT 'Last name of the person.',
  email_address varchar(50) DEFAULT NULL,
  address_line1 varchar(120) DEFAULT NULL,
  address_line2 varchar(120) DEFAULT NULL,
  home_address_city varchar(30) NOT NULL COMMENT 'Name of the city.',
  home_address_state varchar(100) NOT NULL COMMENT 'State or province description.',
  home_address_country varchar(100) NOT NULL COMMENT 'Country or region name.',
  regional_group varchar(50) NOT NULL COMMENT 'Geographic area to which the sales territory belong.',
  cell_phone_number varchar(50) COMMENT 'Telephone number identification number.',
  contact_phone_number varchar(20) DEFAULT NULL,
  marital_status char(1) DEFAULT NULL,
  suffix varchar(10) DEFAULT NULL,
  gender varchar(1) DEFAULT NULL,
  yearly_income decimal(19,4) DEFAULT NULL,
  total_children tinyint(3) unsigned DEFAULT NULL,
  number_children_athome tinyint(3) unsigned DEFAULT NULL,
  houseowner_flag char(1) DEFAULT NULL,
  number_cars_owned tinyint(3) unsigned DEFAULT NULL,
  commute_distance varchar(15) DEFAULT NULL,
  modified_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (customer_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS source_db.sales_raw;
CREATE TABLE source_db.sales_raw (
  customer_id int(11) NOT NULL COMMENT 'Primary key for Person records.',
  product_id int(11) NOT NULL COMMENT 'Product sold to customer. Foreign key to Product.ProductID.',
  order_qty smallint(6) NOT NULL COMMENT 'Quantity ordered per product.',
  unit_price decimal(19,4) NOT NULL COMMENT 'Selling price of a single product.',
  unit_price_discount decimal(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount amount.',
  order_date date NOT NULL COMMENT 'Dates the sales order was created.',
  sales_order_number varchar(50) DEFAULT NULL COMMENT 'Customer sales order number reference. '
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/* datamart_db */
DROP TABLE IF EXISTS datamart_db.dim_product;
CREATE TABLE datamart_db.dim_product (
  product_skey int(20) NOT NULL DEFAULT '0' COMMENT 'Surrogate Key',
  product_id int(11) NOT NULL DEFAULT '0' COMMENT 'Primary key for Product records.',
  product_name varchar(100) NOT NULL DEFAULT '-' COMMENT 'Name of the product.',
  make_flag tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 = Product is purchased, 1 = Product is manufactured in-house.',
  finished_goods_flag tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 = Product is not a salable item. 1 = Product is salable.',
  color varchar(15) DEFAULT '-' COMMENT 'Product color.',
  product_subcategory varchar(100) DEFAULT '-' COMMENT 'Subcategory description.',
  product_category varchar(100) DEFAULT '-' COMMENT 'Category description.',
  model_name varchar(100) DEFAULT '-' COMMENT 'Product model description.',
  size_unit_measure varchar(100) DEFAULT '-' COMMENT 'Unit of measure description.',
  weight_unit_measure varchar(100) DEFAULT '-' COMMENT 'Unit of measure description.',
  list_price decimal(19,4) DEFAULT '0.0000' COMMENT 'Product list price.',
  version bigint(20) DEFAULT NULL,
  date_from datetime DEFAULT NULL,
  date_to datetime DEFAULT NULL,
  PRIMARY KEY (product_skey),
  UNIQUE KEY product_id (product_id,date_from)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS datamart_db.dim_customer;
CREATE TABLE datamart_db.dim_customer (
  customer_skey int(20) NOT NULL DEFAULT '0' COMMENT 'Surrogate Key',
  customer_id int(11) NOT NULL DEFAULT '0' COMMENT 'Primary key for Person records.',
  title varchar(8) DEFAULT NULL DEFAULT '-' COMMENT 'A courtesy title. For example, Mr. or Ms.',
  first_name varchar(100) NOT NULL DEFAULT '-' COMMENT 'First name of the person.',
  middle_name varchar(100) DEFAULT '-' COMMENT 'Middle name or middle initial of the person.',
  last_name varchar(100) NOT NULL DEFAULT '-' COMMENT 'Last name of the person.',
  email_address varchar(50) DEFAULT '-',
  address_line1 varchar(120) DEFAULT '-',
  address_line2 varchar(120) DEFAULT '-',
  home_address_city varchar(30) NOT NULL DEFAULT '-' COMMENT 'Name of the city.',
  home_address_state varchar(100) NOT NULL DEFAULT '-' COMMENT 'State or province description.',
  home_address_country varchar(100) NOT NULL DEFAULT '-' COMMENT 'Country or region name.',
  regional_group varchar(50) NOT NULL DEFAULT '-' COMMENT 'Geographic area to which the sales territory belong.',
  cell_phone_number varchar(50) DEFAULT '-' COMMENT 'Telephone number identification number.',
  contact_phone_number varchar(20) DEFAULT '-',
  marital_status char(1) DEFAULT '-',
  suffix varchar(10) DEFAULT '-',
  gender varchar(1) DEFAULT '-',
  yearly_income decimal(19,4) DEFAULT -1,
  total_children int(3) DEFAULT -1,
  number_children_athome int(3) DEFAULT -1,
  houseowner_flag char(1) DEFAULT '-',
  number_cars_owned tinyint(3) DEFAULT -1,
  commute_distance varchar(15) DEFAULT '-',
  modified_date datetime DEFAULT NULL COMMENT 'Date and time the record was last updated.',
  version bigint(20) DEFAULT NULL,
  date_from datetime DEFAULT NULL,
  date_to datetime DEFAULT NULL,
  PRIMARY KEY (customer_skey),
  UNIQUE KEY product_id (customer_id,date_from)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS datamart_db.dim_date;
CREATE TABLE datamart_db.dim_date (
  date_skey int(11) NOT NULL DEFAULT '0',
  the_date date DEFAULT NULL,
  the_year smallint(6) DEFAULT NULL,
  the_quarter tinyint(4) DEFAULT NULL,
  the_month tinyint(4) DEFAULT NULL,
  the_week tinyint(4) DEFAULT NULL,
  day_of_year smallint(6) DEFAULT NULL,
  day_of_month tinyint(4) DEFAULT NULL,
  day_of_week tinyint(4) DEFAULT NULL,
  PRIMARY KEY (date_skey)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS datamart_db.fact_sales;
CREATE TABLE datamart_db.fact_sales (
  date_skey int(11) NOT NULL DEFAULT '0',
  product_skey int(11) NOT NULL,
  customer_skey int(11) NOT NULL,
  order_qty smallint(6) NOT NULL COMMENT 'Quantity ordered per product.',
  unit_price decimal(19,4) NOT NULL COMMENT 'Selling price of a single product.',
  unit_price_discount decimal(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount amount.',
  extended_amount decimal(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Extended amount.',
  sales_order_number varchar(25) NOT NULL COMMENT 'Unique sales order identification number.'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

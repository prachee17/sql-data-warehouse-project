/*
DDL Script: Create Bronze Layer

Ther script creates tables in the bronze schema, dropping tables 
if they already exists.
Run the script to re-define the DDL structure of bronze Tables.
*/

IF OBJECT_ID ('bronze.crm_cust_info', 'U') is not null
	drop table bronze.crm_cust_info;
create table bronze.crm_cust_info(
	cst_id int,
	cust_key nvarchar(50),
	cust_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cat_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info', 'U') is not null
	drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
	prd_id int,
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt date,
	prd_end_dt DATE
);

IF OBJECT_ID ('bronze.crm_sales_details', 'U') is not null
	drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt nvarchar(50),
	sls_ship_dt nvarchar(50),
	sls_due_dt nvarchar(50),
	sls_sales int,
	sls_quantity int,
	sls_price int
);

DROP TABLE IF EXISTS bronze.crm_sales_details_stg;

CREATE TABLE bronze.crm_sales_details_stg (
    sls_ord_num     VARCHAR(50),
    sls_prd_key     VARCHAR(50),
    sls_cust_id     VARCHAR(50),
    sls_order_dt    VARCHAR(50),
    sls_ship_dt     VARCHAR(50),
    sls_due_dt      VARCHAR(50),
    sls_sales       VARCHAR(50),
    sls_quantity    VARCHAR(50),
    sls_price       VARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_cust_az12', 'U') is not null
	drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12(
	cid nvarchar(50),
	bdate date,
	gen nvarchar(50)
);

IF OBJECT_ID ('bronze.erp_loc_a101', 'U') is not null
	drop table bronze.erp_loc_a101;
create table bronze.erp_loc_a101(
	cid nvarchar(50),
	cntry nvarchar(50)
);

IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') is not null
	drop table bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2(
	id nvarchar(50),
	cat nvarchar(50),
	subcat nvarchar(50),
	maintenance nvarchar(50)
);

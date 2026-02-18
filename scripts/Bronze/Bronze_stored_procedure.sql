/*
Stored Procedure: Load Bronze Layer 
-------------------------------------------------------------------------------
Script Purpose: 
	This stored procedure loads data into the bronze schema from external CSV files.
	It performs the following actions:
	- Truncate the table before loading the data.
	- Use the bulk insert command to load daya from CSV file.

This stored procedure does not accept any parameters or return any values.

Usage Example:
	exec bronze.load_bronze
-------------------------------------------------------------------------------
*/
create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	begin try
		set @batch_start_time = GETDATE();
		print '================================================================';
		print 'Loading Bronze Layer';
		print '================================================================';

		print '----------------------------------------------------------------';
		print 'Loading CRM tables';
		print '----------------------------------------------------------------';

		set @start_time = GETDATE();
		print 'truncating then inserting: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		bulk insert bronze.crm_cust_info
		from 'C:\Users\EXPERT\Downloads\dwh_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			FIRSTROW = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + ' seconds'; 

		set @start_time = GETDATE();
		print 'truncating then inserting: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		bulk insert bronze.crm_prd_info
		from 'C:\Users\EXPERT\Downloads\dwh_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			FIRSTROW = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + ' seconds'; 

		set @start_time = GETDATE();
		print 'truncating then inserting: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		bulk insert bronze.crm_sales_details
		from 'C:\Users\EXPERT\Downloads\sales_details_dates_fixed_no_new_cols.csv'
		with (
			FIRSTROW = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + ' seconds'; 

		print '----------------------------------------------------------------';
		print 'Loading ERP tables';
		print '----------------------------------------------------------------';

		set @start_time = GETDATE();
		print 'truncating then inserting: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\EXPERT\Downloads\dwh_project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			FIRSTROW = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + ' seconds'; 

		set @start_time = GETDATE();
		print 'truncating then inserting: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\EXPERT\Downloads\dwh_project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			FIRSTROW = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + ' seconds'; 

		set @start_time = GETDATE();
		print 'truncating then inserting: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\EXPERT\Downloads\dwh_project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			FIRSTROW = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + ' seconds';
		set @batch_end_time = GETDATE();
		print '======================================='
		print 'Loading Bronze layer is completed.';
		print '  - Total Load Duration: ' +cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		print '======================================='
	end try
	begin catch
		print 'Error occured during bronze layer'
		print 'Error Message' + error_message();
		print 'Error Number' + cast(error_number() as nvarchar);
		print 'Error State' +cast(Error_state() as nvarchar);
	end catch
end
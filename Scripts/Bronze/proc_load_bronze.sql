/* ==============================================
Strored Procedure : Load bronze layer (Source -> bronze
=================================================
Purpose : 
  created a stored procedure for bulk insertion of the data from CSV to tables 
  It Truncates the tables if data is already present there and insert again.
  Execute the procedure to reuse the DDL commands and data insertion 
*/


CREATE OR ALTER PROCEDURE  bronze.load_bronze AS
BEGIN
		DECLARE @starttime DATETIME , @endtime DATETIME
		DECLARE @batchstart DATETIME , @batchend DATETIME

	BEGIN TRY

		SET @batchstart = GETDATE();
		PRINT '======================================';
		PRINT 'Loading Bronze layer';
		PRINT '======================================';

		PRINT '--------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------';

		PRINT '>> Truncating Table: bronze.crm_cust_info';

		SET @starttime = GETDATE();
	

		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Data Warehouse project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT '>>Loading Duration: '+ cast(DATEDIFF(second ,  @starttime , @endtime) AS NVARCHAR)+'seconds';
		PRINT' ---------------------------------------------';


		PRINT '>> Truncating Table: bronze.crm_prd_info';
		SET @starttime = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>>Inserting Data Into : bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Data Warehouse project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @endtime = GETDATE();
		PRINT '>>Loading Duration: '+ cast(DATEDIFF(second ,  @starttime , @endtime) AS NVARCHAR)+'seconds';
		PRINT' ---------------------------------------------';

		SET @starttime = GETDATE();
		PRINT '>>truncating Table : bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>>Inserting Data Into : bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Data Warehouse project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @endtime = GETDATE();
		PRINT '>>Loading Duration: '+ cast(DATEDIFF(second ,  @starttime , @endtime) AS NVARCHAR)+'seconds';
		PRINT' ---------------------------------------------';


	
		PRINT '--------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------';

		PRINT '>>Truncating Table : bronze.erp_cust_az12'


		SET @starttime = GETDATE();
		TRUNCATE  TABLE bronze.erp_cust_az12

		PRINT '>>Inserting data into : bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Data Warehouse project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT '>>Loading Duration: '+ cast(DATEDIFF(second ,  @starttime , @endtime) AS NVARCHAR)+'seconds';
		PRINT' ---------------------------------------------';


		PRINT '>>Truncating table : bronze.erp_loc_a101'
		set @starttime = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>>Loading data into  : bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Data Warehouse project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endtime = GETDATE();
		PRINT '>>Loading Duration: '+ cast(DATEDIFF(second ,  @starttime , @endtime) AS NVARCHAR)+'seconds';
		PRINT' ---------------------------------------------';


		PRINT '>>truncating table  : bronze.erp_px_cat_g1v2'

		set @starttime = GETDATE();
		TRUNCATE TABLE  bronze.erp_px_cat_g1v2

		PRINT '>>Inserting data into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Data Warehouse project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @endtime = GETDATE();
		PRINT '>>Loading Duration: '+ cast(DATEDIFF(second ,  @starttime , @endtime) AS NVARCHAR)+'seconds';
		PRINT' ---------------------------------------------';

		SET @batchend = GETDATE();

		PRINT '=======================================================';
		PRINT '>>BATCH LOAD TIME: '+ cast(DATEDIFF(second , @batchstart , @batchend) AS NVARCHAR)+'seconds';
		PRINT '=======================================================';

	END TRY
	BEGIN CATCH
	PRINT '==========================================';
	PRINT 'ERROR OCCURED DURING LOADING';
	PRINT 'ERROR MESSAGE '+ CAST(ERROR_MESSAGE() AS NVARCHAR);
	PRINT '==========================================';
	END CATCH
END

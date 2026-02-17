/*

Create DataBase and Schemas

Script Prpose:
	This script is creating a database named as "DataWarehouse" after checking the existance of the database,
	if exists it will drop the existing one and create a new database. Additionally, this script will create 
	three schemas within the databse: bronze, silver and gold.

*/

use master;
GO

if exists (select 1 from sys.databases where name = 'DataWarehouse')
Begin 
	alter database DataWarehouse set single_user with rollback immediate;
	drop database DataWarehouse;
end;
GO

create database DataWarehouse;
GO

use DataWarehouse;
GO

create schema bronze;
go
create schema silver;
go
create schema gold;
go

/*

=========================================
create Databases and Schemas 
=========================================
Script Purposes:
	This Script create a new database named 'DATAWAREHOUSE' .
	Additionally , the scripts sets up three schemas within the database : 'silver','bronze' and 'gold'.

*/

-- creating  the database 'DATAWAREHOUSE'
CREATE DATABASE DATAWAREHOUSE
GO


USE DATAWAREHOUSE;

-- creating the schema for the three layers i.e. bronze , silver , gold

create schema bronze;

go
create schema silver;

go

create schema gold;

go


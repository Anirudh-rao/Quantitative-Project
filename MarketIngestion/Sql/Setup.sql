-- Switch to a high-level role like SYSADMIN
USE ROLE SYSADMIN;

-- Create a dedicated financial warehouse
CREATE WAREHOUSE IF NOT EXISTS finance_wh
  WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 300            -- Suspends after 5 minutes of inactivity
  AUTO_RESUME = TRUE            -- Resumes automatically when a query is run
  INITIALLY_SUSPENDED = TRUE    -- Starts in a suspended state
  COMMENT = 'Warehouse for financial reporting and analysis';

-- Switch to SECURITYADMIN or USERADMIN to create roles and grant privileges
USE ROLE SECURITYADMIN;

-- Create the custom role
CREATE ROLE IF NOT EXISTS finance_analyst_role 
  COMMENT = 'Custom role for finance department users';

-- Grant warehouse usage to the custom role
GRANT USAGE ON WAREHOUSE finance_wh TO ROLE finance_analyst_role;


SELECT CURRENT_USER;
-- Optional: Grant the custom role to a specific user (replace 'YOUR_USERNAME')
GRANT ROLE finance_analyst_role TO USER ROOKR13;


-- Create Database
USE ROLE SYSADMIN;

-- Create Database
CREATE OR REPLACE DATABASE finance_db;
USE DATABASE finance_db;

-- Create Schema for each index.
CREATE OR REPLACE SCHEMA BANK_NIFTY;
USE  SCHEMA BANK_NIFTY;

-- Switch to SYSADMIN or an owner role
USE ROLE SYSADMIN;

-- Example: Grant usage on a database named FINANCE_DB
GRANT USAGE ON DATABASE finance_db TO ROLE finance_analyst_role;
GRANT USAGE ON SCHEMA finance_db.public TO ROLE finance_analyst_role;

-- Grant select permission on existing tables in that schema
GRANT SELECT ON ALL TABLES IN SCHEMA finance_db.public TO ROLE finance_analyst_role;

USE ROLE SECURITYADMIN;

-- Grant usage on the database
GRANT USAGE ON DATABASE finance_db TO ROLE finance_analyst_role;

-- Grant usage on the schema
GRANT USAGE ON SCHEMA finance_db.BANK_NIFTY TO ROLE finance_analyst_role;

-- Grant data manipulation privileges on existing tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA finance_db.BANK_NIFTY TO ROLE finance_analyst_role;

-- Future-proof: Automatically grant privileges on any tables created in the future
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA finance_db.BANK_NIFTY TO ROLE finance_analyst_role;

-- Granting Create table from this role
Use Role Sysadmin;

GRANT CREATE TABLE ON SCHEMA FINANCE_DB.BANK_NIFTY TO ROLE finance_analyst_role;
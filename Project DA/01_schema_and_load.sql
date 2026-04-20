-- ============================================================
-- RETAIL SALES ANALYSIS PROJECT
-- Script 1: Schema Creation & Data Loading
-- Database: SQLite / MySQL / PostgreSQL compatible
-- ============================================================

-- ── DIMENSION: Products ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS products (
    ProductID   VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category    VARCHAR(50)  NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL,
    UnitCost    DECIMAL(10,2) NOT NULL
);

-- ── DIMENSION: Customers ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS customers (
    CustomerID   VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerType VARCHAR(20),   -- Regular, Premium, VIP
    Region       VARCHAR(30),
    City         VARCHAR(50)
);

-- ── FACT: Orders ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS orders (
    OrderID     VARCHAR(15) PRIMARY KEY,
    OrderDate   DATE        NOT NULL,
    Year        INT,
    Month       INT,
    Quarter     VARCHAR(5),
    CustomerID  VARCHAR(10) REFERENCES customers(CustomerID),
    Region      VARCHAR(30),
    City        VARCHAR(50),
    Channel     VARCHAR(30),   -- Online, Retail Store, Wholesale, Direct Sales
    ProductID   VARCHAR(10) REFERENCES products(ProductID),
    ProductName VARCHAR(100),
    Category    VARCHAR(50),
    Quantity    INT,
    UnitPrice   DECIMAL(10,2),
    Discount    DECIMAL(5,2),
    Revenue     DECIMAL(12,2),
    Cost        DECIMAL(12,2),
    Profit      DECIMAL(12,2),
    Status      VARCHAR(20)    -- Delivered, Returned, Pending
);

-- ── NOTE: Load CSVs using your DB tool ───────────────────────
-- SQLite example:
--   .import --csv --skip 1 data/products.csv products
--   .import --csv --skip 1 data/customers.csv customers
--   .import --csv --skip 1 data/orders.csv orders

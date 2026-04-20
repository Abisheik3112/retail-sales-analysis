-- ============================================================
-- RETAIL SALES ANALYSIS PROJECT
-- Script 2: Core Analytics Queries
-- ============================================================

-- ── Q1: Overall KPI Summary ──────────────────────────────────
SELECT
    COUNT(DISTINCT OrderID)                                 AS Total_Orders,
    SUM(Quantity)                                           AS Units_Sold,
    ROUND(SUM(Revenue), 2)                                  AS Total_Revenue,
    ROUND(SUM(Profit), 2)                                   AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS Profit_Margin_Pct,
    ROUND(AVG(Revenue), 2)                                  AS Avg_Order_Value,
    COUNT(DISTINCT CustomerID)                              AS Active_Customers
FROM orders
WHERE Status = 'Delivered';

-- ── Q2: Revenue & Profit by Year and Quarter ─────────────────
SELECT
    Year,
    Quarter,
    COUNT(DISTINCT OrderID)         AS Orders,
    ROUND(SUM(Revenue), 2)          AS Revenue,
    ROUND(SUM(Profit), 2)           AS Profit,
    ROUND(SUM(Profit) * 100.0 /
          NULLIF(SUM(Revenue),0), 2) AS Margin_Pct
FROM orders
WHERE Status = 'Delivered'
GROUP BY Year, Quarter
ORDER BY Year, Quarter;

-- ── Q3: Revenue by Category ──────────────────────────────────
SELECT
    Category,
    COUNT(DISTINCT OrderID)                                  AS Orders,
    SUM(Quantity)                                            AS Units_Sold,
    ROUND(SUM(Revenue), 2)                                   AS Revenue,
    ROUND(SUM(Profit), 2)                                    AS Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS Margin_Pct,
    ROUND(SUM(Revenue) * 100.0 /
          (SELECT SUM(Revenue) FROM orders WHERE Status='Delivered'), 2) AS Revenue_Share_Pct
FROM orders
WHERE Status = 'Delivered'
GROUP BY Category
ORDER BY Revenue DESC;

-- ── Q4: Top 10 Products by Revenue ──────────────────────────
SELECT
    ProductID,
    ProductName,
    Category,
    SUM(Quantity)                                            AS Units_Sold,
    ROUND(SUM(Revenue), 2)                                   AS Revenue,
    ROUND(SUM(Profit), 2)                                    AS Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS Margin_Pct
FROM orders
WHERE Status = 'Delivered'
GROUP BY ProductID, ProductName, Category
ORDER BY Revenue DESC
LIMIT 10;

-- ── Q5: Regional Performance ─────────────────────────────────
SELECT
    Region,
    COUNT(DISTINCT CustomerID)   AS Customers,
    COUNT(DISTINCT OrderID)      AS Orders,
    ROUND(SUM(Revenue), 2)       AS Revenue,
    ROUND(SUM(Profit), 2)        AS Profit,
    ROUND(AVG(Revenue), 2)       AS Avg_Order_Value
FROM orders
WHERE Status = 'Delivered'
GROUP BY Region
ORDER BY Revenue DESC;

-- ── Q6: Sales Channel Analysis ───────────────────────────────
SELECT
    Channel,
    COUNT(DISTINCT OrderID)                                  AS Orders,
    ROUND(SUM(Revenue), 2)                                   AS Revenue,
    ROUND(SUM(Profit), 2)                                    AS Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS Margin_Pct,
    ROUND(SUM(Revenue) * 100.0 /
          (SELECT SUM(Revenue) FROM orders WHERE Status='Delivered'), 2) AS Revenue_Share_Pct
FROM orders
WHERE Status = 'Delivered'
GROUP BY Channel
ORDER BY Revenue DESC;

-- ── Q7: Customer Segment Revenue ─────────────────────────────
SELECT
    c.CustomerType,
    COUNT(DISTINCT o.CustomerID)                             AS Customers,
    COUNT(DISTINCT o.OrderID)                                AS Orders,
    ROUND(SUM(o.Revenue), 2)                                 AS Revenue,
    ROUND(AVG(o.Revenue), 2)                                 AS Avg_Order_Value
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
WHERE o.Status = 'Delivered'
GROUP BY c.CustomerType
ORDER BY Revenue DESC;

-- ── Q8: Monthly Revenue Trend ────────────────────────────────
SELECT
    Year,
    Month,
    COUNT(DISTINCT OrderID)   AS Orders,
    ROUND(SUM(Revenue), 2)    AS Revenue,
    ROUND(SUM(Profit), 2)     AS Profit
FROM orders
WHERE Status = 'Delivered'
GROUP BY Year, Month
ORDER BY Year, Month;

-- ── Q9: Order Status Breakdown ───────────────────────────────
SELECT
    Status,
    COUNT(*)                   AS Orders,
    ROUND(SUM(Revenue), 2)     AS Revenue,
    ROUND(COUNT(*)*100.0 /
          (SELECT COUNT(*) FROM orders), 2) AS Pct_of_Orders
FROM orders
GROUP BY Status
ORDER BY Orders DESC;

-- ── Q10: Top 10 Cities by Revenue ────────────────────────────
SELECT
    Region,
    City,
    COUNT(DISTINCT OrderID)   AS Orders,
    ROUND(SUM(Revenue), 2)    AS Revenue,
    ROUND(SUM(Profit), 2)     AS Profit
FROM orders
WHERE Status = 'Delivered'
GROUP BY Region, City
ORDER BY Revenue DESC
LIMIT 10;

-- ── Q11: Discount Impact Analysis ────────────────────────────
SELECT
    CASE
        WHEN Discount = 0    THEN 'No Discount'
        WHEN Discount <= 0.05 THEN '1-5%'
        WHEN Discount <= 0.10 THEN '6-10%'
        WHEN Discount <= 0.15 THEN '11-15%'
        ELSE '16-20%'
    END                                                      AS Discount_Band,
    COUNT(DISTINCT OrderID)                                  AS Orders,
    ROUND(SUM(Revenue), 2)                                   AS Revenue,
    ROUND(SUM(Profit), 2)                                    AS Profit,
    ROUND(SUM(Profit)*100.0 / NULLIF(SUM(Revenue),0), 2)    AS Margin_Pct
FROM orders
WHERE Status = 'Delivered'
GROUP BY Discount_Band
ORDER BY Discount ASC;

-- ── Q12: YoY Revenue Growth ──────────────────────────────────
WITH yearly AS (
    SELECT Year, ROUND(SUM(Revenue),2) AS Revenue
    FROM orders WHERE Status = 'Delivered'
    GROUP BY Year
)
SELECT
    curr.Year,
    curr.Revenue,
    prev.Revenue                                             AS Prev_Year_Revenue,
    ROUND((curr.Revenue - prev.Revenue)*100.0 /
          NULLIF(prev.Revenue, 0), 2)                        AS YoY_Growth_Pct
FROM yearly curr
LEFT JOIN yearly prev ON curr.Year = prev.Year + 1
ORDER BY curr.Year;

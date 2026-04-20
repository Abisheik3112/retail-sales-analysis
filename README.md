## 🗂️ Project Structure

```
retail_analysis/
├── data/
│   ├── orders.csv          ← 2,000 order transactions (2023–2024)
│   ├── products.csv        ← 20 products across 5 categories
│   └── customers.csv       ← 200 customers across 5 regions
│
├── sql/
│   ├── 01_schema_and_load.sql   ← DDL: create tables + import instructions
│   └── 02_analytics_queries.sql ← 12 ready-to-run analytics queries
│
├── excel/
│   └── Retail_Sales_Analysis.xlsx
│       ├── Raw Data            ← Full dataset with filters
│       ├── KPI Dashboard       ← Executive summary + KPI cards
│       ├── Pivot Analysis      ← Monthly trend + Channel × Category pivot
│       ├── Charts              ← Bar, Line, Pie charts
│       └── Top Products        ← Product ranking with conditional formatting
│
└── powerbi/
    └── Retail_PowerBI_Dashboard.html  ← Interactive Power BI-style dashboard
```

---

## 🚀 Quick Start

### Step 1 — Excel Analysis
Open `excel/Retail_Sales_Analysis.xlsx` in Microsoft Excel.
- Use **Raw Data** sheet: filter by year, region, channel, status
- View **KPI Dashboard** for at-a-glance metrics
- Explore **Pivot Analysis** for monthly trends
- Review **Charts** for visual summaries
- Check **Top Products** for product rankings

### Step 2 — SQL Analysis
Load data into any SQL database (SQLite, MySQL, PostgreSQL):

**SQLite (easiest):**
```bash
sqlite3 retail.db
.read sql/01_schema_and_load.sql
.import --csv --skip 1 data/products.csv products
.import --csv --skip 1 data/customers.csv customers
.import --csv --skip 1 data/orders.csv orders
.read sql/02_analytics_queries.sql
```

**MySQL:**
```sql
LOAD DATA INFILE 'data/orders.csv' INTO TABLE orders
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  IGNORE 1 ROWS;
```

### Step 3 — Power BI Dashboard
Open `powerbi/Retail_PowerBI_Dashboard.html` in any browser.
- Use **filter dropdowns** (Year / Region / Channel) to slice data
- All 6 charts update dynamically
- Product ranking table with progress bars

---

## 📈 Key Business Metrics

| Metric | Value |
|--------|-------|
| Total Revenue | ₹13.14 Crore |
| Total Profit | ₹3.83 Crore |
| Profit Margin | 29.2% |
| Total Orders | 1,687 |
| Active Customers | 200 |
| Avg Order Value | ₹77,895 |

---

## 🔍 SQL Queries Included (12 total)

| # | Query | Insight |
|---|-------|---------|
| Q1 | Overall KPI Summary | Single-row executive summary |
| Q2 | Revenue by Year & Quarter | Quarterly trend analysis |
| Q3 | Revenue by Category | Category contribution + margin |
| Q4 | Top 10 Products | Best performers by revenue |
| Q5 | Regional Performance | Geography-based analysis |
| Q6 | Sales Channel Analysis | Online vs Store vs Wholesale |
| Q7 | Customer Segment Revenue | Regular vs Premium vs VIP |
| Q8 | Monthly Revenue Trend | Time series for forecasting |
| Q9 | Order Status Breakdown | Return rate analysis |
| Q10| Top 10 Cities | City-level revenue ranking |
| Q11| Discount Impact | Margin erosion from discounts |
| Q12| YoY Revenue Growth | Year-over-year comparison |

---

## 📊 Dashboard Features

### Excel Workbook
- ✅ 5 worksheets (Raw Data, KPI, Pivot, Charts, Products)
- ✅ Auto-filter on Raw Data sheet
- ✅ Conditional color-scale formatting on product revenue
- ✅ Bar, Line, and Pie charts
- ✅ Color-coded KPI cards
- ✅ Professional formatting (Arial, borders, alternating rows)

### Power BI HTML Dashboard
- ✅ 7 interactive KPI cards
- ✅ Line chart: Monthly Revenue & Profit
- ✅ Bar chart: Category comparison
- ✅ Horizontal bar: Regional performance
- ✅ Pie chart: Channel revenue share
- ✅ Donut chart: Customer segment mix
- ✅ Product ranking table with progress bars
- ✅ Year / Region / Channel filters

---

## 🗃️ Data Schema

### orders (fact table — 2,000 rows)
`OrderID, OrderDate, Year, Month, Quarter, CustomerID, Region, City, Channel, ProductID, ProductName, Category, Quantity, UnitPrice, Discount, Revenue, Cost, Profit, Status`

### products (dimension — 20 rows)
`ProductID, ProductName, Category, UnitPrice, UnitCost`

### customers (dimension — 200 rows)
`CustomerID, CustomerName, CustomerType, Region, City`

# Global Superstore Sales Insights

Interactive Tableau dashboard analyzing Global Superstore order data from 2017 to 2020. This project explores sales trends, order growth, customer segments, regional performance, and geographic sales concentration.

## Live Dashboard
[View on Tableau Public](https://public.tableau.com/app/profile/shivachethan.reddy.peri/viz/global-superstore-sales-insights/Dashboard?publish=yes)

## Dashboard Preview
![Dashboard Preview](images/dashboard.jpg)

## Business Problem
A global retail business needs to understand how sales are distributed across time, regions, customer segments, and shipping behavior in order to identify growth patterns and high-performing markets.

## Data Source
- Dataset: Global Superstore Orders 2021
- Records: 51,290
- Columns: 24
- Date Range: 2017-01-01 to 2020-12-31
- Distinct Orders: 25,728
- Countries: 165
- Markets: 5
- Regions: 23
- States: 1,102
- Total Sales: $12,642,507.25
- Total Profit: $1,467,456.67

## Tools Used
- Tableau Desktop / Tableau Public
- CSV data source
- Visual analytics using histogram, line chart, bar chart, map, and treemap

## Dashboard Components

### 1. Sales Histogram
![Sales Histogram](images/histogram.jpg)

Shows that most sales transactions are low-value, with a long right tail of larger transactions.

### 2. Sales Versus Order Date
![Line Chart](images/line-chart.jpg)

Tracks quarterly sales across Consumer, Corporate, and Home Office segments. Consumer leads throughout the period and all segments trend upward overall.

### 3. Orders per Year
![Bar Chart](images/bar-chart.jpg)

Displays year-over-year growth in distinct orders from 2017 to 2020, with Standard Class dominating shipping volume.

### 4. Sales Map
![Map](images/map.jpg)

Highlights geographic concentration of sales, with top-performing states standing out visually.

### 5. Regional Treemap
![Treemap](images/treemap.jpg)

Compares regional sales contribution and shows Western Europe as the largest contributor.

## Key Insights
- Most sales are concentrated in smaller transaction ranges.
- Consumer is the strongest-performing segment over time.
- Distinct orders increased from 4,515 in 2017 to 8,857 in 2020.
- Standard Class is the most frequently used shipping mode.
- Western Europe generated the highest regional sales.
- California and New York are among the strongest sales locations.

## Preattentive Attributes Used
- Length in the histogram and bar chart
- Color hue in the line chart and bar chart
- Color intensity in the map
- Area in the treemap

These choices improve readability by making trends, outliers, and category differences easier to spot quickly.

## Files Included
- Tableau dashboard screenshot
- Individual worksheet screenshots
- Tableau packaged workbook (.twbx)
- Source dataset (.csv)

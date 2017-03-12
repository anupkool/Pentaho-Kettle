/* 
   Query 1
   Analysis: Top 5 states for order quantity between 2007 and 2008 for the product, 800 (Road-550-W Yellow, 44), together with a gain/loss percentage of 2008 when compared to 2007 
   Findings & Business Decisions: The biggest drop happened in England. Needs stronger marketing. 
 */
SELECT b.*
  FROM (
        SELECT a.product_name, a.state, a.country
               , SUM(IF(a.the_year=2007, a.order_qty, NULL)) AS order_qty_2007
               , SUM(IF(a.the_year=2008, a.order_qty, NULL)) AS order_qty_2008
               , SUM(a.order_qty) AS order_qty_total
               , IFNULL(SUM(IF(a.the_year=2008, a.order_qty, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.order_qty, NULL)),0) AS order_qty_diff_cnt
               , ROUND(CASE WHEN SUM(IF(a.the_year=2007, a.order_qty, NULL)) > 0
                      THEN (IFNULL(SUM(IF(a.the_year=2008, a.order_qty, NULL)), 0) - IFNULL(SUM(IF(a.the_year=2007, a.order_qty, NULL)),0)) / SUM(IF(a.the_year=2007, a.order_qty, NULL))
                 END*100) AS order_qty_diff_perc     
          FROM (
                SELECT p.product_name, c.home_address_state AS state, c.home_address_country AS country, d.the_year, SUM(f.order_qty) AS order_qty
                  FROM fact_sales f, dim_product p, dim_customer c, dim_date d
                 WHERE f.product_skey = p.product_skey
                   AND f.customer_skey = c.customer_skey
                   AND f.date_skey = d.date_skey
                   AND p.product_id = 800
                   AND d.the_year IN (2007, 2008)
                 GROUP BY p.product_name, c.home_address_state, d.the_year
               ) a
         GROUP BY a.product_name, a.state, a.country
         ORDER BY SUM(a.order_qty) DESC
         LIMIT 5
       ) b
 ORDER BY b.order_qty_diff_perc
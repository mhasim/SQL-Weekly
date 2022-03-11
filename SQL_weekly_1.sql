---- C-10 WEEKLY AGENDA-8 RD&SQL STUDENT

---- 1. List all the cities in the Texas and the numbers of customers in each city.----
SELECT *
FROM sale.customer

SELECT city, COUNT(customer_id)
FROM sale.customer
WHERE [state] = 'TX'
GROUP BY city


---- 2. List all the cities in the California which has more than 5 customer, by showing the cities which have more customers first.---
SELECT city
FROM sale.customer
WHERE [state] = 'CA'
GROUP BY city
HAVING COUNT(customer_id) > 5
ORDER BY COUNT(customer_id) DESC

---- 3. List the top 10 most expensive products----
SELECT TOP 10 product_name
FROM product.product
ORDER BY list_price DESC

---- 4. List store_id, product name and list price and the quantity of the products which are located in the store id 2 and the quantity is greater than 25----
SELECT A.store_id, B.product_name, B.list_price, A.quantity
FROM product.stock A
JOIN product.product B ON A.product_id = B.product_id
WHERE store_id = 2 AND quantity > 25

---- 5. Find the sales order of the customers who lives in Boulder order by order date----
SELECT B.customer_id, B.first_name, B.last_name
FROM sale.orders A
JOIN sale.customer B ON A.customer_id = B.customer_id
WHERE B.city = 'Boulder'
ORDER BY A.order_date

---- 6. Get the sales by staffs and years using the AVG() aggregate function.
SELECT A.staff_id, B.first_name, B.last_name, YEAR(A.order_date), COUNT(A.order_id)
FROM sale.orders A
JOIN sale.staff B ON A.staff_id = B.staff_id
GROUP BY A.staff_id, B.first_name, B.last_name, YEAR(A.order_date)

---- 7. What is the sales quantity of product according to the brands and sort them highest-lowest----
SELECT C.brand_name, SUM(B.order_id)
FROM product.product A
JOIN sale.order_item B ON A.product_id = B.product_id
JOIN product.brand C ON A.brand_id = C.brand_id
GROUP BY C.brand_name
ORDER BY SUM(B.order_id) DESC

---- 8. What are the categories that each brand has?----
SELECT DISTINCT A.brand_name, C.category_name
FROM product.brand A
JOIN product.product B ON A.brand_id = B.brand_id
JOIN product.category C ON B.category_id = C.category_id


---- 9. Select the avg prices according to brands and categories----
SELECT DISTINCT A.brand_name, C.category_name, AVG(B.list_price) as avg_price
FROM product.brand A
JOIN product.product B ON A.brand_id = B.brand_id
JOIN product.category C ON B.category_id = C.category_id
GROUP BY A.brand_name, C.category_name

---- 10. Select the annual amount of product produced according to brands----
SELECT A.brand_id, B.brand_name, A.model_year, COUNT(product_id)
FROM product.product A
JOIN product.brand B ON A.brand_id = B.brand_id
GROUP BY A.brand_id, B.brand_name, A.model_year

---- 11. Select the store which has the most sales quantity in 2016.----
SELECT order_id, YEAR(order_date)
FROM sale.orders
WHERE YEAR(order_date) = 2018

SELECT TOP 1 B.store_name, COUNT(A.order_id)
FROM sale.orders A
JOIN sale.store B ON A.store_id = B.store_id
WHERE YEAR(A.order_date) = 2016
GROUP BY B.store_name
ORDER BY COUNT(A.order_id) DESC

SELECT YEAR('2017/08/25')
---- 12 Select the store which has the most sales amount in 2018.----
SELECT TOP 1 B.store_name, COUNT(A.order_id)
FROM sale.orders A
JOIN sale.store B ON A.store_id = B.store_id
WHERE YEAR(A.order_date) = 2018
GROUP BY B.store_name
ORDER BY COUNT(A.order_id) DESC

---- 13. Select the personnel which has the most sales amount in 2019.----
SELECT TOP 1 A.staff_id, B.first_name, B.last_name, COUNT(A.order_id) as sales
FROM sale.orders A
JOIN sale.staff B ON A.staff_id = B.staff_id
WHERE YEAR(A.order_date) = 2019
GROUP BY A.staff_id, B.first_name, B.last_name
ORDER BY COUNT(A.order_id) DESC

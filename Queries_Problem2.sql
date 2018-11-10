USE csci3901;

/*
Problem-2, Query-1
Which customers are in a different city than their sales representatives?
*/
SELECT C.customerNumber AS CustomerNumber, C.customerName AS CustomerName
FROM customers AS C, offices as O, employees as E
WHERE C.salesRepEmployeeNumber = E.employeeNumber AND O.officeCode = E.officeCode AND O.city <> C.city
ORDER BY CustomerNumber ASC;

/*
Problem-2 Query-2
Which orders included sales that are below the MSRP?
*/
SELECT DISTINCT od.orderNumber 
FROM orderdetails od, products p
WHERE p.productCode = od.productCode AND od.priceEach < p.MSRP
ORDER BY od.orderNumber;

/*
Problem-2 Query-3
List the top 5 products for 2004 with the highest avg mark-up percentage per order
*/

SELECT od.productCode,p.productName, AVG((((od.priceEach - p.buyPrice)/p.buyPrice))*100) AS MarkUpPercentage
FROM orderdetails od, products p, orders o
WHERE p.productCode = od.productCode AND od.orderNumber = o.ordernumber AND YEAR(o.orderDate) = 2004
GROUP BY p.productCode
ORDER BY MarkUpPercentage DESC
LIMIT 5;

/*
Problem-2 Query-4
List the top 3 employees with the greatest average diversity of products in their orders
*/
SELECT AVG(NoOfProducts) AS AvgDiversity, Employee
FROM
  (SELECT  COUNT( DISTINCT od.productCode) AS NoOfProducts , od.orderNumber, c.salesRepEmployeeNumber AS Employee
   FROM orders o, orderdetails od, customers c, products p
   WHERE o.orderNumber = od.orderNumber 
   AND o.customerNumber = c.customerNumber
   AND p.productCode = od.productCode
   GROUP BY c.salesRepEmployeeNumber, od.orderNumber) UniqueNoOfProductsSoldByEmployee
GROUP BY Employee
ORDER BY AVG(NoOfProducts) DESC
LIMIT 3;

/*
Problem-2: Query-5
What is the average time needed to ship orders from each office in 2005 relative to the order date?
*/

SELECT AVG(datediff(O.shippedDate, O.orderDate)) AS AvgTimeToShipOrders, E.officeCode
FROM customers AS C, orders as O, employees as E
WHERE C.salesRepEmployeeNumber = E.employeeNumber AND O.customerNumber = C.customerNumber AND YEAR(O.shippedDate) = 2005 AND YEAR(O.orderDate) = 2005
GROUP BY E.officeCode;


USE HSD;
/***** Retrieving data *****/


--List all columns of every table.
SELECT * FROM CUSTOMER;
SELECT * FROM SEMINAR;
SELECT * FROM SEMINAR_CUSTOMER;
SELECT * FROM CONTACT;
SELECT * FROM [PRODUCT];
SELECT * FROM INVOICE;
SELECT * FROM LINE_ITEM;

--List the LastName, FirstName and Phone of all customers who live in Dallas.
SELECT 
	LastName,
	FirstName,
	Phone
FROM CUSTOMER
WHERE City = 'Dallas';

/*List the LastName, FirstName and Phone of all customers who live in Dallas
and whose last name begins with the letter T.*/
SELECT 
	LastName,
	FirstName,
	Phone
FROM CUSTOMER
WHERE City = 'Dallas' AND LastName LIKE 'T%';

/*List the InvoiceNumber of every sale that includes the video "Heather Sweeney Seminar Live in 
Dallas on 25-OCT-16".*/
SELECT InvoiceNumber
FROM INVOICE 
WHERE InvoiceNumber IN(
	SELECT InvoiceNumber
	FROM LINE_ITEM
	WHERE ProductNumber IN(
		SELECT ProductNumber
		FROM [PRODUCT]
		WHERE ProductDescription = 'Heather Sweeney Seminar Live in Dallas on 25-OCT-16'))
ORDER BY InvoiceNumber;

/*Answer last question again, this time using JOIN ... ON syntax.*/
SELECT I.InvoiceNumber
FROM INVOICE I
JOIN LINE_ITEM L 
	ON I.InvoiceNumber = L.InvoiceNumber
JOIN [PRODUCT] P 
	ON L.ProductNumber = P.ProductNumber
WHERE ProductDescription =
	'Heather Sweeney Seminar Live in Dallas on 25-OCT-16'
ORDER BY I.InvoiceNumber;

/*List the FirstName, LastName and Phone of customers who attended the "Kitchen on a Big D 
Budget" seminar. List each person once. Sort by LastName descending, then FirstName 
descending.*/
SELECT DISTINCT
	FirstName,
	LastName,
	Phone
FROM CUSTOMER C
JOIN SEMINAR_CUSTOMER SC
	ON C.CustomerID = SC.CustomerID
JOIN SEMINAR S
	ON SC.SeminarID = S.SeminarID
WHERE SeminarTitle = 'Kitchen on a Big D Budget'
ORDER BY LastName DESC, FirstName DESC;

/*List the FirstName, LastName, Phone, ProductNumber and ProductDescription of customers 
who have purchased a video. List each name and video combination once. Sort by LastName 
descending, then FirstName descending, then ProductNumber descending. (Hint: video 
product numbers start with VK.)*/
SELECT DISTINCT
	FirstName,
	LastName,
	Phone,
	P.ProductNumber,
	ProductDescription
FROM CUSTOMER C
JOIN INVOICE I
	ON C.CustomerID = I.CustomerID
JOIN LINE_ITEM L 
	ON I.InvoiceNumber = L.InvoiceNumber
JOIN [PRODUCT] P 
	ON L.ProductNumber = P.ProductNumber
WHERE P.ProductNumber LIKE 'VK%'
ORDER BY LastName DESC, FirstName DESC, P.ProductNumber DESC;



/*-------------------------------------*/

/***** Aggregates *****/


/*Show the sum of SubTotal for INVOICE (the money earned on products,
excluding shipping and tax) as SumOfSubTotal.*/
SELECT
	SUM(SubTotal) AS SumOfSubTotal
FROM INVOICE;

/*Show the average of SubTotal for INVOICE as AverageOfSubTotal.*/
SELECT
	AVG(SubTotal) AS AverageOfSubTotal
FROM INVOICE;

/*Show both the sum and the average of SubTotal in one statement,
named SumOfSubTotal and AverageOfSubTotal.*/
SELECT
	SUM(SubTotal) AS SumOfSubTotal,
	AVG(SubTotal) AS AverageOfSubTotal
FROM INVOICE;



/*-------------------------------------*/

/***** Aggregates *****/


--Change the UnitPrice of product VK004 to 34.95 instead of the current 24.95.
UPDATE [PRODUCT]
SET UnitPrice = 34.95
WHERE ProductNumber = 'VK004';

SELECT * FROM [PRODUCT];

--Undo the price change from brevious question.
UPDATE [PRODUCT]
SET UnitPrice = 24.95
WHERE ProductNumber = 'VK004';

SELECT * FROM [PRODUCT];

/*Do not run your answer on your real database.Write the fewest possible
DELETE statements that remove all the data but leave the table structures intact.*/

	/*
	DELETE FROM SEMINAR_CUSTOMER; -- No Cascades from SEMINAR or CUSTOMER, so clear it first
	DELETE FROM INVOICE; -- Cascades to LINE_ITEM
	DELETE FROM CUSTOMER; -- Cascades to CONTACT
	DELETE FROM SEMINAR; -- Allowed now that CONTACT and SEMINAR_CUSTOMER are empty
	DELETE FROM [PRODUCT]; -- Allowed now that LINE_ITEM is empty
	*/
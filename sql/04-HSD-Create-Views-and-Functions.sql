USE HSD;
/***** Views and functions *****/


/*Create a view named InvoiceSummaryView containing INVOICE.InvoiceNumber, 
INVOICE.InvoiceDate, LINE_ITEM.LineNumber, LINE_ITEM.ProductNumber, 
PRODUCT.ProductDescription and LINE_ITEM.UnitPrice. Run it, then test it with a SELECT.*/
GO
CREATE VIEW InvoiceSummaryView AS
	SELECT
		I.InvoiceNumber,
		I.InvoiceDate,
		L.LineNumber,
		L.ProductNumber,
		P.ProductDescription,
		L.UnitPrice
	FROM INVOICE I
	JOIN LINE_ITEM L ON I.InvoiceNumber = L.InvoiceNumber
	JOIN [PRODUCT] P ON L.ProductNumber = P.ProductNumber;
GO

SELECT *
FROM InvoiceSummaryView
ORDER BY InvoiceNumber, LineNumber;

/*Create and test a user-defined function named FirstNameFirst that takes FirstName and 
LastName and returns one value, FullName: the first name, a space, then the last name. For 
example, Steve and Smith become Steve Smith.*/
GO
CREATE FUNCTION FirstNameFirst (@FirstName CHAR(25), @LastName CHAR(25))
RETURNS VARCHAR(60)
AS
BEGIN
    RETURN RTRIM(@FirstName) + ' ' + RTRIM(@LastName);
END;
GO

SELECT
	CustomerID,
	dbo.FirstNameFirst(FirstName, LastName) AS FullName
FROM CUSTOMER;

/*Create a view named CustomerInvoiceSummaryView containing INVOICE.InvoiceNumber, 
INVOICE.InvoiceDate, the customer's full name built with FirstNameFirst, 
CUSTOMER.EmailAddress and INVOICE.Total. Run it, then test it with a SELECT.*/
GO
CREATE VIEW CustomerInvoiceSummaryView AS
	SELECT
		I.InvoiceNumber,
		I.InvoiceDate,
		dbo.FirstNameFirst(FirstName, LastName) AS FullName,
		C.EmailAddress,
		I.Total
	FROM INVOICE I
	JOIN CUSTOMER C ON I.CustomerID = C.CustomerID;
GO

SELECT *
FROM CustomerInvoiceSummaryView
ORDER BY InvoiceNumber;
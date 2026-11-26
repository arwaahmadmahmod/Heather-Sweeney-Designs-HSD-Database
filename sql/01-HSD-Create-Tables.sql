CREATE DATABASE HSD;
USE HSD;


-- Create customer table
CREATE TABLE CUSTOMER (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	LastName CHAR(25) NOT NULL,
	FirstName CHAR(25) NOT NULL,
	EmailAddress VARCHAR(100) UNIQUE NOT NULL,  -- Alternate key (unique)
	EncryptedPassword VARCHAR(50),
	Phone CHAR(12) NOT NULL,
	StreetAddress CHAR(35),
	City CHAR(35) DEFAULT 'Dallas',
	[State] CHAR(2) DEFAULT 'TX',
	ZIP CHAR(10) DEFAULT '75201',

	-- Email format checks
	CONSTRAINT ck_customer_email CHECK (
		EmailAddress LIKE '_%@_%._%'
        AND EmailAddress NOT LIKE '%[^A-Za-z0-9@._%+-]%'
        AND EmailAddress NOT LIKE '%@%@%'
        AND EmailAddress NOT LIKE '%..%'
        AND EmailAddress NOT LIKE '.%'
        AND EmailAddress NOT LIKE '%.'
        AND EmailAddress NOT LIKE '%@.%'
	),

	-- Phone format
	CONSTRAINT ck_customer_phone
		CHECK (Phone LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),

	-- State format
	CONSTRAINT ck_customer_state
		CHECK ([State] LIKE '[A-Z][A-Z]'),

	-- ZIP format 
	CONSTRAINT ck_customer_zip
		CHECK (ZIP LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);

DBCC CHECKIDENT ('CUSTOMER', RESEED, 0);   -- the first customer will get id 1

-- Stored procedure for password encryption
GO
CREATE PROCEDURE sp_register_customer
    @LastName      CHAR(25),
    @FirstName     CHAR(25),
    @EmailAddress  VARCHAR(100),
    @Password      NVARCHAR(100),
    @Phone         CHAR(12),
    @StreetAddress CHAR(35),
    @City          CHAR(35),
    @State         CHAR(2),
    @ZIP           CHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- salt (4 bytes) + SHA2-256 hash (32 bytes) = 36 bytes
    DECLARE @salt VARBINARY(4)  = CRYPT_GEN_RANDOM(4);
    DECLARE @bin  VARBINARY(36) = @salt + HASHBYTES('SHA2_256', @salt + CAST(@Password AS VARBINARY(MAX)));

    -- base64 of 36 bytes = 48 characters, fits VARCHAR(50)
    DECLARE @b64 VARCHAR(50) =
        CAST('' AS XML).value('xs:base64Binary(sql:variable("@bin"))', 'VARCHAR(50)');

    INSERT INTO CUSTOMER
        (LastName, FirstName, EmailAddress, EncryptedPassword, Phone,
         StreetAddress, City, [State], ZIP)
    VALUES
        (@LastName, @FirstName, @EmailAddress, @b64, @Phone,
         @StreetAddress,
         ISNULL(@City,  'Dallas'),
         ISNULL(@State, 'TX'),
         ISNULL(@ZIP,   '75201'));

    SELECT SCOPE_IDENTITY() AS NewCustomerID;
END;
GO


-- Create Seminar table
CREATE TABLE SEMINAR (
	SeminarID INT PRIMARY KEY IDENTITY(1,1),
	SeminarDate DATE NOT NULL,
	SeminarTime TIME NOT NULL,
	[Location] VARCHAR(100) NOT NULL,
	SeminarTitle VARCHAR(100) NOT NULL,

    CONSTRAINT ck_seminar_date CHECK (SeminarDate >= '2000-01-01'),
	
    CONSTRAINT ck_seminar_time CHECK (SeminarTime BETWEEN '00:00:00' AND '23:59:59')
);

DBCC CHECKIDENT ('SEMINAR',  RESEED, 0);   -- the first seminar will get id 1

-- Create Seminar_Customer Junction table
CREATE TABLE SEMINAR_CUSTOMER (
	SeminarID INT NOT NULL,
	CustomerID INT NOT NULL,

	CONSTRAINT pk_seminar_customer PRIMARY KEY (SeminarID, CustomerID),
	
	CONSTRAINT fk1_seminar_customer 
		FOREIGN KEY (SeminarID) REFERENCES SEMINAR(SeminarID)
		ON UPDATE NO ACTION         -- changing the parent key updates the child rows too
		ON DELETE NO ACTION,        -- blocks deleting
	
	CONSTRAINT fk2_seminar_customer
		FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);


-- Create contact table
CREATE TABLE CONTACT(
	CustomerID INT NOT NULL,
	ContactNumber INT NOT NULL,
	ContactDate DATE NOT NULL,
	ContactType VARCHAR(30) NOT NULL,
	SeminarID INT,

	CONSTRAINT pk_contact PRIMARY KEY (CustomerID, ContactNumber),

	CONSTRAINT fk1_contact_seminar 
		FOREIGN KEY (SeminarID) REFERENCES SEMINAR(SeminarID)
		ON UPDATE NO ACTION         
		ON DELETE NO ACTION,

	CONSTRAINT fk2_contact_customer
		FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
		ON UPDATE NO ACTION
		ON DELETE CASCADE,

    CONSTRAINT ck_contact_date CHECK (ContactDate >= '2000-01-01'),

	CONSTRAINT ck_contact_contactType
		CHECK (ContactType IN ('Seminar', 'FormLetterSeminar',
			'WebAccountCreation', 'WebPurchase', 'EmailAccountMessage', 'EmailSeminarMessage',
            'EmailPurchaseMessage', 'EmailExchangeMessage', 'PhoneConversation'))

);


-- Craete invoice table
CREATE TABLE INVOICE (
	InvoiceNumber INT PRIMARY KEY IDENTITY(35000,1),
	InvoiceDate DATE NOT NULL,
	CustomerID INT NOT NULL,
	PaymentType CHAR(25) NOT NULL DEFAULT 'Cash',
	SubTotal NUMERIC(9,2),
	Shipping NUMERIC(9,2),
	Tax NUMERIC(9,2),
	Total NUMERIC(9,2),

    CONSTRAINT ck_invoice_date CHECK (InvoiceDate >= '2000-01-01'),

	CONSTRAINT fk_invoice_customer 
		FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,

	CONSTRAINT ck_invoice_paymentType
		CHECK (PaymentType IN ('VISA', 'MasterCard', 'American Express',
			'PayPal', 'Check', 'Cash'))
);
DBCC CHECKIDENT ('INVOICE',  RESEED, 34999);   -- the first seminar will get id 1


-- Create product table
CREATE TABLE [PRODUCT] (
	ProductNumber CHAR(35) PRIMARY KEY,
	ProductType CHAR(24) NOT NULL,
	ProductDescription VARCHAR(100) NOT NULL,
	UnitPrice NUMERIC(9,2) NOT NULL,
	QuantityOnHand INT NOT NULL,

	CONSTRAINT ck_product_productType 
		CHECK (ProductType IN ('Video', 'Video Companion', 'Book'))
);


-- Create line_item table
CREATE TABLE LINE_ITEM (
	InvoiceNumber INT NOT NULL,
	LineNumber INT NOT NULL,
	ProductNumber CHAR(35) NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice NUMERIC(9,2),
	Total NUMERIC(9,2),

	CONSTRAINT pk_lineItem PRIMARY KEY (InvoiceNumber, LineNumber),

	CONSTRAINT fk_lineItem_invoice FOREIGN KEY (InvoiceNumber)
		REFERENCES INVOICE(InvoiceNumber)
		ON UPDATE NO ACTION
		ON DELETE CASCADE,

	CONSTRAINT fk_lineItem_product FOREIGN KEY (ProductNumber)
		REFERENCES [PRODUCT](ProductNumber)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
);
USE HSD;
/***** CUSTOMER DATA *****/

EXEC sp_register_customer
    @LastName      = 'Jacobs',
    @FirstName     = 'Nancy',
    @EmailAddress  = 'Nancy.Jacobs@somewhere.com',
    @Password      = N'nf46tG9E',
    @Phone         = '817-871-8123',
    @StreetAddress = '1440 West Palm Drive',
    @City          = 'Fort Worth',
    @State         = 'TX',
    @ZIP           = '76110-2563';
EXEC sp_register_customer 'Jacobs', 'Chantel', 'Chantel.Jacobs@somewhere.com', N'b65TG03f',
 '817-871-8234', '1550 East Palm Drive', 'Fort Worth', 'TX', '76112-6452';
EXEC sp_register_customer 'Able', 'Ralph', 'Ralph.Able@somewhere.com', N'm56fGH08',
 '210-281-7987', '123 Elm Street', 'San Antonio', 'TX', '78214-6379';
EXEC sp_register_customer 'Baker', 'Susan', 'Susan.Baker@elsewhere.com', N'PC93fEk9',
 '210-281-7876', '456 Oak Street', 'San Antonio', 'TX', '78216-1573';
EXEC sp_register_customer 'Eagleton', 'Sam', 'Sam.Eagleton@elsewhere.com', N'bnvR44W8',
 '210-281-7765', '789 Pine Street', 'San Antonio', 'TX', '78218-1873';
EXEC sp_register_customer 'Foxtrot', 'Kathy', 'Kathy.Foxtrot@somewhere.com', N'aa8tY4GL',
 '972-233-6234', '11023 Elm Street', 'Dallas', 'TX', '75220-1749';
EXEC sp_register_customer 'George', 'Sally', 'Sally.George@somewhere.com', N'LK8G2tyF',
 '972-233-6345', '12034 San Jacinto', 'Dallas', 'TX', '75223-6472';
EXEC sp_register_customer 'Hullett', 'Shawn', 'Shawn.Hullett@elsewhere.com', N'bu78WW3t',
 '972-233-6456', '13045 Flora', 'Dallas', 'TX', '75224-3169';
EXEC sp_register_customer 'Pearson', 'Bobbi', 'Bobbi.Pearson@elsewhere.com', N'kq6N2O0p',
 '512-974-3344', '43 West 23rd Street', 'Austin', 'TX', '78710-7362';
EXEC sp_register_customer'Ranger', 'Terry', 'Terry.Ranger@somewhere.com', N'bv3F9Qc4',
 '512-974-4455', '56 East 18th Street', 'Austin', 'TX', '78712-9796';
EXEC sp_register_customer'Tyler', 'Jenny', 'Jenny.Tyler@somewhere.com', N'Yu4be77Z',
 '972-233-6567', '14056 South Ervay Street', 'Dallas', 'TX', '75225-3463';
EXEC sp_register_customer'Wayne', 'Joan', 'Joan.Wayne@elsewhere.com', N'JW4TX6g',
 '817-871-8245', '1660 South Aspen Drive', 'Fort Worth', 'TX', '76115-1724';


 /***** SEMINAR DATA *****/
INSERT INTO SEMINAR (SeminarDate, SeminarTime, Location, SeminarTitle) VALUES
('2017-10-12', '11:00:00', 'San Antonio Convention Center', 'Kitchen on a Budget'),
('2017-10-26', '16:00:00', 'Dallas Convention Center',      'Kitchen on a Big D Budget'),
('2017-11-02', '08:30:00', 'Austin Convention Center',      'Kitchen on a Budget'),
('2018-03-22', '11:00:00', 'Dallas Convention Center',      'Kitchen on a Big D Budget'),
('2018-03-23', '11:00:00', 'Dallas Convention Center',      'Kitchen on a Big D Budget'),
('2018-04-05', '08:30:00', 'Austin Convention Center',      'Kitchen on a Budget');
 

/***** SEMINAR_CUSTOMER DATA *****/
INSERT INTO SEMINAR_CUSTOMER (SeminarID, CustomerID) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 6), (2, 7), (2, 8),
(3, 9), (3, 10),
(4, 6), (4, 7), (4, 11), (4, 12);


/***** CONTACT DATA *****/
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType, SeminarID) VALUES-- Seminar 1 attendees (Jacobs N., Jacobs C., Able, Baker, Eagleton)
(1, 1, '2017-10-12', 'Seminar', 1),
(2, 1, '2017-10-12', 'Seminar', 1),
(3, 1, '2017-10-12', 'Seminar', 1),
(4, 1, '2017-10-12', 'Seminar', 1),
(5, 1, '2017-10-12', 'Seminar', 1);
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType) VALUES
(1, 2, '2017-10-15', 'EmailSeminarMessage'),
(2, 2, '2017-10-15', 'EmailSeminarMessage'),
(3, 2, '2017-10-15', 'EmailSeminarMessage'),
(4, 2, '2017-10-15', 'EmailSeminarMessage'),
(5, 2, '2017-10-15', 'EmailSeminarMessage'),
(1, 3, '2017-10-15', 'FormLetterSeminar'),
(2, 3, '2017-10-15', 'FormLetterSeminar'),
(3, 3, '2017-10-15', 'FormLetterSeminar'),
(4, 3, '2017-10-15', 'FormLetterSeminar'),
(5, 3, '2017-10-15', 'FormLetterSeminar'); -- Seminar 2 attendees (Foxtrot, George, Hullett)
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType, SeminarID) VALUES
(6, 1, '2017-10-26', 'Seminar', 2),
(7, 1, '2017-10-26', 'Seminar', 2),
(8, 1, '2017-10-26', 'Seminar', 2);
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType) VALUES
(6, 2, '2017-10-30', 'EmailSeminarMessage'),
(7, 2, '2017-10-30', 'EmailSeminarMessage'),
(8, 2, '2017-10-30', 'EmailSeminarMessage'),
(6, 3, '2017-10-30', 'FormLetterSeminar'),
(7, 3, '2017-10-30', 'FormLetterSeminar'),
(8, 3, '2017-10-30', 'FormLetterSeminar');-- Seminar 3 attendees (Pearson, Ranger)
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType, SeminarID) VALUES
(9,  1, '2017-11-02', 'Seminar', 3),
(10, 1, '2017-11-02', 'Seminar', 3);
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType) VALUES
(9,  2, '2017-11-06', 'EmailSeminarMessage'),
(10, 2, '2017-11-06', 'EmailSeminarMessage'),
(9,  3, '2017-11-06', 'FormLetterSeminar'),
(10, 3, '2017-11-06', 'FormLetterSeminar'),-- Web account creation and follow-up messages
(3, 4, '2018-02-20', 'WebAccountCreation'),
(3, 5, '2018-02-20', 'EmailAccountMessage'),
(6, 4, '2018-02-22', 'WebAccountCreation'),
(6, 5, '2018-02-22', 'EmailAccountMessage'),
(7, 4, '2018-02-25', 'WebAccountCreation'),
(7, 5, '2018-02-25', 'EmailAccountMessage'),
(8, 4, '2018-03-07', 'WebAccountCreation'),
(8, 5, '2018-03-07', 'EmailAccountMessage');-- Seminar 4 attendees (Foxtrot, George, Tyler, Wayne)
INSERT INTO CONTACT (CustomerID, ContactNumber, ContactDate, ContactType, SeminarID) VALUES
(6,  6, '2018-03-22', 'Seminar', 4),
(7,  6, '2018-03-22', 'Seminar', 4),
(11, 1, '2018-03-22', 'Seminar', 4),
(12, 1, '2018-03-22', 'Seminar', 4);


/***** PRODUCT DATA *****/
INSERT INTO [PRODUCT] (ProductNumber, ProductType, ProductDescription,
                     UnitPrice, QuantityOnHand) VALUES
('VK001', 'Video', 'Kitchen Remodeling Basics', 14.95, 50),
('VK002', 'Video', 'Advanced Kitchen Remodeling', 14.95, 35),
('VK003', 'Video', 'Kitchen Remodeling Dallas Style', 19.95, 25),
('VK004', 'Video', 'Heather Sweeney Seminar Live in Dallas on 25-OCT-16', 24.95, 20),
('VB001', 'Video Companion', 'Kitchen Remodeling Basics', 7.99, 50),
('VB002', 'Video Companion', 'Advanced Kitchen Remodeling I', 7.99, 35),
('VB003', 'Video Companion', 'Kitchen Remodeling Dallas Style', 9.99, 25),
('BK001', 'Book', 'Kitchen Remodeling Basics For Everyone', 24.95, 75),
('BK002', 'Book', 'Advanced Kitchen Remodeling For Everyone', 24.95, 75),
('BK003', 'Book', 'Kitchen Remodeling Dallas Style For Everyone', 24.95, 75);
 

/***** INVOICE DATA (InvoiceNumber starts at 35000 and increments by 1) *****/
INSERT INTO INVOICE (InvoiceDate, CustomerID,
                     PaymentType, SubTotal, Shipping, Tax, Total) VALUES
('2017-10-15',  3, 'VISA',       22.94, 5.95, 1.31,  30.20),  -- 35000
('2017-10-25',  4, 'MasterCard', 47.89, 5.95, 2.73,  56.57),  -- 35001
('2017-12-20',  7, 'VISA',       24.95, 5.95, 1.42,  32.32),  -- 35002
('2018-03-25',  4, 'MasterCard', 64.85, 5.95, 3.70,  74.50),  -- 35003
('2018-03-27',  6, 'MasterCard', 94.79, 5.95, 5.40, 106.14),  -- 35004
('2018-03-27',  7, 'MasterCard', 94.80, 5.95, 5.40, 106.15),  -- 35005
('2018-03-31',  9, 'VISA',       47.89, 5.95, 2.73,  56.57),  -- 35006
('2018-04-03', 11, 'MasterCard',109.78, 5.95, 6.26, 121.99),  -- 35007
('2018-04-08',  5, 'MasterCard', 47.89, 5.95, 2.73,  56.57),  -- 35008
('2018-04-08',  1, 'VISA',       47.89, 5.95, 2.73,  56.57),  -- 35009
('2018-04-23',  3, 'VISA',       24.95, 5.95, 1.42,  32.32),  -- 35010
('2018-05-07',  9, 'VISA',       22.94, 5.95, 1.31,  30.20),  -- 35011
('2018-05-21',  8, 'MasterCard', 54.89, 5.95, 3.13,  63.97),  -- 35012
('2018-06-05',  3, 'VISA',       47.89, 5.95, 2.73,  56.57),  -- 35013
('2018-06-05', 11, 'MasterCard', 45.88, 5.95, 2.62,  54.45),  -- 35014
('2018-06-05', 12, 'MasterCard', 94.79, 5.95, 5.40, 106.14),  -- 35015
('2018-06-05',  3, 'VISA',       45.88, 5.95, 2.62,  54.45);  -- 35016


/***** LINE_ITEM DATA *****/
INSERT INTO LINE_ITEM (InvoiceNumber, LineNumber,
                       ProductNumber, Quantity, UnitPrice, Total) VALUES
(35000, 1, 'VK001', 1, 14.95, 14.95),
(35000, 2, 'VB001', 1,  7.99,  7.99),
(35001, 1, 'VK001', 1, 14.95, 14.95),
(35001, 2, 'VB001', 1,  7.99,  7.99),
(35001, 3, 'BK001', 1, 24.95, 24.95),
(35002, 1, 'VK004', 1, 24.95, 24.95),
(35003, 1, 'VK002', 1, 14.95, 14.95),
(35003, 2, 'BK002', 1, 24.95, 24.95),
(35003, 3, 'VK004', 1, 24.95, 24.95),
(35004, 1, 'VK002', 1, 14.95, 14.95),
(35004, 2, 'BK002', 1, 24.95, 24.95),
(35004, 3, 'VK003', 1, 19.95, 19.95),
(35004, 4, 'VB003', 1,  9.99,  9.99),
(35004, 5, 'VK004', 1, 24.95, 24.95),
(35005, 1, 'VK002', 1, 14.95, 14.95),
(35005, 2, 'BK002', 1, 24.95, 24.95),
(35005, 3, 'VK003', 1, 19.95, 19.95),
(35005, 4, 'VK004', 1, 24.95, 24.95),
(35006, 1, 'BK001', 1, 24.95, 24.95),
(35006, 2, 'VK001', 1, 14.95, 14.95),
(35006, 3, 'VB001', 1,  7.99,  7.99),
(35007, 1, 'VK003', 2, 19.95, 39.90),
(35007, 2, 'VB003', 2,  9.99, 19.98),
(35007, 3, 'VK004', 2, 24.95, 49.90),
(35008, 1, 'BK001', 1, 24.95, 24.95),
(35008, 2, 'VK001', 1, 14.95, 14.95),
(35008, 3, 'VB001', 1,  7.99,  7.99),
(35009, 1, 'BK001', 1, 24.95, 24.95),
(35009, 2, 'VK001', 1, 14.95, 14.95),
(35009, 3, 'VB001', 1,  7.99,  7.99),
(35010, 1, 'BK001', 1, 24.95, 24.95),
(35011, 1, 'VK002', 1, 14.95, 14.95),
(35011, 2, 'VB002', 1,  7.99,  7.99),
(35012, 1, 'VK003', 1, 19.95, 19.95),
(35012, 2, 'VB003', 1,  9.99,  9.99),
(35012, 3, 'VK004', 1, 24.95, 24.95),
(35013, 1, 'VK002', 1, 14.95, 14.95),
(35013, 2, 'VB002', 1,  7.99,  7.99),
(35013, 3, 'BK002', 1, 24.95, 24.95),
(35014, 1, 'VK002', 2, 14.95, 29.90),
(35014, 2, 'VB002', 2,  7.99, 15.98),
(35015, 1, 'VK002', 1, 14.95, 14.95),
(35015, 2, 'BK002', 1, 24.95, 24.95),
(35015, 3, 'VK003', 1, 19.95, 19.95),
(35015, 4, 'VB003', 1,  9.99,  9.99),
(35015, 5, 'VK004', 1, 24.95, 24.95),
(35016, 1, 'VK001', 1, 14.95, 14.95),
(35016, 2, 'VB001', 1,  7.99,  7.99),
(35016, 3, 'VK002', 1, 14.95, 14.95),
(35016, 4, 'VB002', 1,  7.99,  7.99);
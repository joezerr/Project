CREATE DATABASE ENTVStore
GO 
USE ENTVStore

CREATE TABLE [Staff](
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(255) NOT NULL,
	StaffEmail VARCHAR(255) NOT NULL,
	StaffGender VARCHAR(6) CHECK (StaffGender IN ('Male', 'Female')) NOT NULL,
	StaffPhoneNo VARCHAR(15) CHECK (StaffPhoneNo LIKE '+62%') NOT NULL,
	StaffAddress VARCHAR(255) NOT NULL,
	StaffSalary NUMERIC(15,3) NOT NULL,
	StaffDOB DATE CHECK(StaffDOB >= '2000-01-01') NOT NULL
);

CREATE TABLE [Customer](
	CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(255) NOT NULL,
	CustomerEmail VARCHAR(255) CHECK (CustomerEmail LIKE ('%@gmail.com') OR (CustomerEmail LIKE '%@yahoo.com')) NOT NULL,
	CustomerGender VARCHAR(255) CHECK (CustomerGender LIKE ('Male') OR CustomerGender LIKE ('Female')) NOT NULL,
	CustomerPhoneNo VARCHAR(15) CHECK (CustomerPhoneNo LIKE '+62%') NOT NULL,
	CustomerAddress VARCHAR(255) NOT NULL,
	CustomerDOB DATE NOT NULL
);

CREATE TABLE [TelevisionBrand](
	BrandID CHAR(5) PRIMARY KEY CHECK (BrandID LIKE 'TB[0-9][0-9][0-9]'),
	BrandName VARCHAR(255) NOT NULL,
);

CREATE TABLE [Television](
	TelevisionID CHAR(5) PRIMARY KEY CHECK (TelevisionID LIKE 'TE[0-9][0-9][0-9]'),
	BrandID CHAR(5) FOREIGN KEY REFERENCES TelevisionBrand(BrandID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TelevisionName VARCHAR(255) NOT NULL,
	TelevisionQty INTEGER NOT NULL,
	TelevisionPrice NUMERIC(15,3) CHECK(TelevisionPrice >= 1000000 AND TelevisionPrice <= 20000000) NOT NULL
);

CREATE TABLE [Vendor](
	VendorID CHAR(5) PRIMARY KEY CHECK (VendorID LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(255) CHECK(LEN(VendorName) > 3) NOT NULL, 
	VendorEmail VARCHAR(255) NOT NULL,
	VendorPhoneNo VARCHAR(15) NOT NULL,
	VendorAddress VARCHAR(255) NOT NULL
);

CREATE TABLE [SalesTransaction](
	SalesTransactionID CHAR(5) PRIMARY KEY CHECK (SalesTransactionID LIKE 'SA[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID CHAR(5) FOREIGN KEY REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	SalesTransactionDate DATE NOT NULL
);

CREATE TABLE [PurchaseTransaction](
	PurchaseTransactionID CHAR(5) PRIMARY KEY CHECK (PurchaseTransactionID	LIKE 'PE[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	VendorID CHAR(5) FOREIGN KEY REFERENCES Vendor(VendorID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PurchaseTransactionDate DATE NOT NULL,
);

CREATE TABLE [DetailPurchaseTransaction](
	PurchaseTransactionID CHAR(5) FOREIGN KEY REFERENCES PurchaseTransaction(PurchaseTransactionID) CHECK (PurchaseTransactionID LIKE 'PE[0-9][0-9][0-9]'),
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES Television(TelevisionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PurchaseQuantity INTEGER NOT NULL,
	PRIMARY KEY (PurchaseTransactionID,TelevisionID)
);

CREATE TABLE[DetailSalesTransaction](
	SalesTransactionID CHAR(5) FOREIGN KEY REFERENCES SalesTransaction(SalesTransactionID) CHECK(SalesTransactionID LIKE 'SA[0-9][0-9][0-9]'),
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES Television(TelevisionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	SalesQuantity INTEGER NOT NULL,
	PRIMARY KEY (SalesTransactionID,TelevisionID)
);
/*
Team 1: Nic Chin, Ken Huang, Ty Okazaki, Tyler Ramos
Zillow Database
*/

CREATE DATABASE team1_project
GO

USE team1_project
GO

-- CREATE TABLES
CREATE TABLE tblCUSTOMER_TYPE (
	CustTypeID INT IDENTITY(1,1) PRIMARY KEY,
  	CustTypeName VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblCUSTOMER (
	CustID INT IDENTITY(1,1) PRIMARY KEY,
  	CustTypeID INT FOREIGN KEY (CustTypeID) REFERENCES tblCUSTOMER_TYPE(CustTypeID) NOT NULL,
  	CustFirstName VARCHAR(255) NOT NULL,
  	CustLastName VARCHAR(255) NOT NULL,
  	CustDOB DATE NOT NULL,
  	CustEmail VARCHAR(255) NOT NULL,
  	CustCity VARCHAR(255) NOT NULL,
 	CustState VARCHAR(255) NOT NULL,
  	CustZip VARCHAR(5) NOT NULL,
)
GO

CREATE TABLE tblPROPERTY_TYPE (
	PropertyTypeID INT IDENTITY(1,1) PRIMARY KEY,
	PropertyTypeName VARCHAR(255) NOT NULL,
  	PropertyTypeDescr VARCHAR(255) NOT NULL,
)
GO

CREATE TABLE tblPROPERTY (
	PropertyID INT IDENTITY(1,1) PRIMARY KEY,
	PropertyTypeID INT FOREIGN KEY (PropertyTypeID) REFERENCES tblPROPERTY_TYPE(PropertyTypeID) NOT NULL,
  	PropertyAddress VARCHAR(255) NOT NULL,
	PropertyDescr VARCHAR(255) NOT NULL,
	PropertyCity VARCHAR(255) NOT NULL,
  	PropertyState VARCHAR(255) NOT NULL,
  	PropertyZip VARCHAR(5) NOT NULL
)
GO

CREATE TABLE tblDETAIL_TYPE (
	DetailTypeID INT IDENTITY(1,1) PRIMARY KEY,
  	DetailTypeName VARCHAR(255) NOT NULL,
  	DetailTypeDescr VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblDETAIL (
	DetailID INT IDENTITY(1,1) PRIMARY KEY,
  	DetailTypeID INT FOREIGN KEY (DetailTypeID) REFERENCES tblDETAIL_TYPE(DetailTypeID) NOT NULL,
  	DetailName VARCHAR(255) NOT NULL,
  	DetailDescr VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblPROPERTY_DETAIL (
	PropertyDetailID INT IDENTITY(1,1) PRIMARY KEY,
  	DetailID INT FOREIGN KEY (DetailID) REFERENCES tblDETAIL(DetailID) NOT NULL,
  	PropertyID INT FOREIGN KEY (PropertyID) REFERENCES tblPROPERTY(PropertyID) NOT NULL,
  	Quantity INT NOT NULL
)
GO

CREATE TABLE tblAGENCY (
	AgencyID INT IDENTITY(1,1) PRIMARY KEY,
  	AgencyName VARCHAR(255) NOT NULL,
  	AgencyEmail VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblAGENT (
  	AgentID INT IDENTITY(1,1) PRIMARY KEY,
  	AgencyID INT FOREIGN KEY (AgencyID) REFERENCES tblAGENCY(AgencyID) NOT NULL,
  	AgentFirstName VARCHAR(255) NOT NULL,
  	AgentLastName VARCHAR(255) NOT NULL,
  	AgentDOB Date NOT NULL,
	AgentEmail VARCHAR(255) NOT NULL,
  	AgentState VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblLISTING_TYPE (
	ListingTypeID INT IDENTITY(1,1) PRIMARY KEY,
  	ListingTypeName VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblLISTING (
	ListingID INT IDENTITY(1,1) PRIMARY KEY,
	PropertyID INT FOREIGN KEY (PropertyID) REFERENCES tblPROPERTY(PropertyID) NOT NULL,
  	ListingTypeID INT FOREIGN KEY (ListingTypeID) REFERENCES tblLISTING_TYPE(ListingTypeID) NOT NULL,
  	AgentID INT FOREIGN KEY (AgentID) REFERENCES tblAGENT(AgentID) NOT NULL,
  	ListingPrice NUMERIC(9,2) NOT NULL,
  	ListingDate DATE NOT NULL
)
GO

CREATE TABLE tblVISIT (
	VisitID INT IDENTITY(1,1) PRIMARY KEY,
  	ListingID INT FOREIGN KEY (ListingID) REFERENCES tblLISTING(ListingID) NOT NULL,
	CustID INT FOREIGN KEY (CustID) REFERENCES tblCUSTOMER(CustID) NOT NULL,
  	VisitDate DATE NOT NULL
)
GO

CREATE TABLE tblRATING (
	RatingID INT IDENTITY(1,1) PRIMARY KEY,
	RatingNumber NUMERIC(2,1) NOT NULL,
  	RatingName VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblREVIEW (
	ReviewID INT IDENTITY(1,1) PRIMARY KEY,
  	RatingID INT FOREIGN KEY (RatingID) REFERENCES tblRATING(RatingID) NOT NULL,
  	VisitID INT FOREIGN KEY (VisitID) REFERENCES tblVISIT(VisitID) NOT NULL,
  	ReviewBody VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblFORM_TYPE (
	FormTypeID INT IDENTITY(1,1) PRIMARY KEY,
  	FormTypeName VARCHAR(255) NOT NULL,
  	FormTypeDescr VARCHAR(255) NOT NULL,
)
GO

CREATE TABLE tblFORM (
	FormID INT IDENTITY(1,1) PRIMARY KEY,
  	FormTypeID INT FOREIGN KEY (FormTypeID) REFERENCES tblFORM_TYPE(FormTypeID) NOT NULL,
  	VisitID INT FOREIGN KEY (VisitID) REFERENCES tblVISIT(VisitID) NOT NULL,
  	FormName VARCHAR(255) NOT NULL,
  	FormDate DATE NOT NULL
)
GO

CREATE TABLE tblSTATUS (
  	StatusID INT IDENTITY(1,1) PRIMARY KEY,
  	StatusName VARCHAR(255) NOT NULL,
  	StatusDescr VARCHAR(255) NOT NULL
)
GO

CREATE TABLE tblAPP_STATUS (
	AppStatusID INT IDENTITY(1,1) PRIMARY KEY,
  	StatusID INT FOREIGN KEY (StatusID) REFERENCES tblSTATUS(StatusID) NOT NULL,
  	FormID INT FOREIGN KEY (FormID) REFERENCES tblFORM(FormID) NOT NULL,
  	AppStatusDate DATE NOT NULL
)
GO

-- INSERT TYPE DATA INTO TABLES
INSERT INTO tblCUSTOMER_TYPE (CustTypeName)
VALUES 
  ('Buyer'),
  ('Seller'),
  ('Renter'),
  ('Homeowner'),
  ('Landlord'),
  ('Property Manager'),
  ('Developer'),
  ('Appraiser'),
  ('Home Inspector'),
  ('Contractor')
GO

INSERT INTO tblLISTING_TYPE (ListingTypeName)
VALUES 
  ('For Sale'),
  ('For Rent'),
  ('Open House'),
  ('Auction'),
  ('Foreclosure'),
  ('Short Sale'),
  ('New Construction'),
  ('Commercial Lease'),
  ('Vacation Rental'),
  ('Resale'),
  ('Exchange')
GO

INSERT INTO tblFORM_TYPE (FormTypeName, FormTypeDescr)
VALUES 
  ('Purchase Agreement', 'Property sale terms'),
  ('Lease Agreement', 'Rental contract terms'),
  ('Listing Agreement', 'Property sale listing terms'),
  ('Property Disclosure Statement', 'Property condition disclosure'),
  ('Homeowners Association (HOA) Agreement', 'HOA rules and duties'),
  ('Purchase Application', 'Property buying application'),
  ('Mortgage Application', 'Loan application'),
  ('Rental Application', 'Tenant rental request'),
  ('Property Inspection Request', 'Property inspection request'),
  ('Property Repair Request', 'Property maintenance request'),
  ('Property Appraisal Request', 'Property value assessment request')
GO

INSERT INTO tblPROPERTY_TYPE (PropertyTypeName, PropertyTypeDescr)
VALUES
  ('House', 'Detached residential dwelling'),
  ('Condo', 'Individual unit in a building'),
  ('Apartment', 'Rental unit in a complex'),
  ('Townhouse', 'Attached residential unit in a row'),
  ('Multi-Family Home', 'Property with multiple units'),
  ('Vacant Land', 'Undeveloped land for sale'),
  ('Commercial Property', 'Business-use property'),
  ('Industrial Property', 'Manufacturing or warehousing space'),
  ('Farm', 'Agricultural land for farming'),
  ('Mobile/Manufactured Home', 'Factory-built housing'),
  ('Co-op', 'Housing cooperative unit'),
  ('Duplex', 'Property with two units'),
  ('Triplex', 'Property with three units'),
  ('Fourplex', 'Property with four units'),
  ('Penthouse', 'Top-floor luxury apartment'),
  ('Luxury Home', 'High-end residential property'),
  ('Foreclosure', 'Repossessed property for sale'),
  ('Short Sale', 'Property sold below mortgage balance'),
  ('New Construction', 'Recently built property'),
  ('Waterfront Property', 'Property along a water body')
GO

INSERT INTO tblDETAIL_TYPE (DetailTypeName, DetailTypeDescr)
VALUES 
  ('Property', 'Details related to the property itself'),
  ('Location', 'Details related to the property location'),
  ('Interior', 'Details related to the property interior'),
  ('Exterior', 'Details related to the property exterior')
GO

INSERT INTO tblSTATUS (StatusName, StatusDescr)
VALUES 
  ('Submitted', 'Received and pending review'),
  ('Under Review', 'Currently being evaluated'),
  ('Approved', 'Accepted for further processing'),
  ('Rejected', 'Not meeting requirements'),
  ('Pending Documents', 'Missing required info/documents'),
  ('On Hold', 'Temporarily paused for a reason'),
  ('Interview Scheduled', 'Scheduled for evaluation'),
  ('Offer Extended', 'Job offer extended'),
  ('Accepted Offer', 'Offer accepted by applicant'),
  ('Withdrawn', 'Applicant voluntarily withdrew'),
  ('Closed', 'Application process completed'),
  ('Pending Payment', 'Requires payment to proceed')
GO

INSERT INTO tblRATING (RatingNumber, RatingName)
VALUES 
  (0, 'Terrible'),
  (1, 'Bad'),
  (2, 'Unpleasant'),
  (3, 'Average'),
  (4, 'Good'),
  (5, 'Excellent')
GO

INSERT INTO tblDETAIL (DetailTypeID, DetailName, DetailDescr)
VALUES
  (3, 'Bedrooms', 'Number of bedrooms'),
  (3, 'Bathrooms', 'Number of bathrooms'),
  (1, 'Square Feet', 'Total living space'),
  (4, 'Lot Size', 'Size of property lot'),
  (1,'Year Built', 'Year property was constructed'),
  (3, 'Heating Type', 'HVAC system'),
  (3, 'Cooling Type', 'Air conditioning system'),
  (4, 'Parking', 'Parking availability')
  GO


-- ID STORED PROCEDURES
-- i. uspGetPropertyID
CREATE OR ALTER PROCEDURE uspGetPropertyID
	@PropertyAddress2 VARCHAR(255),
    @PropertyCity2 VARCHAR(255),
    @PropertyState2 VARCHAR(255),
    @PropertyZip2 VARCHAR(255),
    @PropertyID2 INT OUTPUT
AS
SET @PropertyID2 = (SELECT PropertyID FROM tblPROPERTY WHERE PropertyAddress = @PropertyAddress2 AND PropertyCity = @PropertyCity2 AND PropertyState = @PropertyState2 AND PropertyZip = @PropertyZip2)
GO

-- ii. uspGetCustomerID
CREATE OR ALTER PROCEDURE uspGetCustomerID
	@CustFirstName2 VARCHAR(255),
    @CustLastName2 VARCHAR(255),
    @CustDOB2 DATE,
    @CustID2 INT OUTPUT
AS
SET @CustID2 = (SELECT CustID FROM tblCUSTOMER WHERE CustFirstName = @CustFirstName2 AND CustLastName = @CustLastName2 AND CustDOB = @CustDOB2)
GO

-- iii. uspGetPropertyTypeID
CREATE OR ALTER PROCEDURE uspGetPropertyTypeID
	@PropertyTypeName2 VARCHAR(255),
	@PropertyTypeID2 INT OUTPUT
AS
SET @PropertyTypeID2 = (SELECT PropertyTypeID FROM tblPROPERTY_TYPE WHERE PropertyTypeName = @PropertyTypeName2)
GO

-- iv. uspGetAgentID
CREATE OR ALTER PROCEDURE uspGetAgentID
	@AgentFirstName2 VARCHAR(255),
    @AgentLastName2 VARCHAR(255),
    @AgentDOB2 DATE,
    @AgentID2 INT OUTPUT
AS
SET @AgentID2 = (SELECT AgentID FROM tblAGENT WHERE AgentFirstName = @AgentFirstName2 AND AgentLastName = @AgentLastName2 AND AgentDOB = @AgentDOB2)
GO

-- v. uspGetCustomerTypeID
CREATE OR ALTER PROCEDURE uspGetCustomerTypeID
	@CustTypeName2 VARCHAR(255),
	@CustTypeID2 INT OUTPUT
AS
SET @CustTypeID2 = (SELECT CustTypeID FROM tblCUSTOMER_TYPE WHERE CustTypeName = @CustTypeName2)
GO

-- vi. uspGetAgencyID
CREATE OR ALTER PROCEDURE uspGetAgencyID
	@AgencyName2 VARCHAR(255),
	@AgencyID2 INT OUTPUT
AS
SET @AgencyID2 = (SELECT AgencyID FROM tblAGENCY WHERE AgencyName = @AgencyName2)
GO

-- vii uspGetDetailTypeID
CREATE OR ALTER PROCEDURE uspGetDetailTypeID
	@DetailTypeName2 VARCHAR(255),
    @DetailTypeID2 INT OUTPUT
AS
SET @DetailTypeID2 = (SELECT DetailTypeID FROM tblDETAIL_TYPE WHERE DetailTypeName = @DetailTypeName2)
GO

-- viii uspGetDetailID
CREATE OR ALTER PROCEDURE uspGetDetailID
	@DetailName2 VARCHAR(255),
    @DetailID2 INT OUTPUT
AS
SET @DetailID2 = (SELECT DetailID FROM tblDETAIL WHERE DetailName = @DetailName2)
GO

-- ix uspGetStatusID
CREATE OR ALTER PROCEDURE uspGetStatusID
	@StatusName2 VARCHAR(255),
    @StatusID2 INT OUTPUT
AS
SET @StatusID2 = (SELECT StatusID FROM tblSTATUS WHERE StatusName = @StatusName2)
GO

-- x uspGetFormID
CREATE OR ALTER PROCEDURE uspGetFormID
	@FormName2 VARCHAR(255),
    @FormDate2 DATE,
    @FormID2 INT OUTPUT
AS
SET @FormID2 = (SELECT FormID FROM tblFORM WHERE FormName = @FormName2 AND FormDate = @FormDate2)
GO

-- xi uspGetRatingID
CREATE OR ALTER PROCEDURE uspGetRatingID
	@RatingName2 VARCHAR(255),
    @RatingID2 INT OUTPUT
AS
SET @RatingID2 = (SELECT RatingID FROM tblRating WHERE RatingName = @RatingName2)
GO

-- xii uspGetFormTypeID
CREATE OR ALTER PROCEDURE uspGetFormTypeID
	@FormTypeName2 VARCHAR(255),
    @FormTypeID2 INT OUTPUT
AS
SET @FormTypeID2 = (SELECT FormTypeID FROM tblFORM_TYPE WHERE FormTypeName = @FormTypeName2)
GO

-- xii. uspGetListingTypeID
CREATE OR ALTER PROCEDURE uspGetListingTypeID
	@ListingTypeName2 VARCHAR(255),
    @ListingTypeID2 INT OUTPUT
AS
SET @ListingTypeID2 = (SELECT ListingTypeID FROM tblLISTING_TYPE WHERE ListingTypeName = @ListingTypeName2)
GO
    
-- STORED PROCEDURES
-- i uspINSERT_PROPERTY_DETAIL
CREATE PROCEDURE uspINSERT_PROPERTY_DETAIL
@DName VARCHAR(255),
@PAddress VARCHAR(255),
@PCity VARCHAR(255),
@PState VARCHAR(255),
@PZip VARCHAR(255),
@Quantity INT
AS
DECLARE @DID INT, @PID INT

EXEC uspGetDetailID
@DetailName2 = @DName,
@DetailID2 = @DID OUTPUT

IF @DID IS NULL
	BEGIN
		PRINT '@DID is empty, check spelling';
		THROW 54321, '@DID cannot be NULLL; process is terminating', 1;
	END

EXEC uspGetPropertyID
@PropertyAddress2 = @PAddress,
@PropertyCity2 = @PCity,
@PropertyState2 = @PState,
@PropertyZip2 = @PZip,
@PropertyID2 = @PID OUTPUT

IF @PID IS NULL
	BEGIN
		PRINT '@PID is empty, check spelling';
		THROW 54321, '@PID cannot be NULLL; process is terminating', 1;
	END

BEGIN TRANSACTION G1
INSERT INTO tblPROPERTY_DETAIL(DetailID, PropertyID, Quantity)
VALUES (@DID, @PID, @Quantity)

IF @@ERROR <> 0
	BEGIN
		PRINT 'Something broke during commit, rollback transaction';
		ROLLBACK TRANSACTION G1
	END
ELSE
    COMMIT TRANSACTION G1
GO	

-- ii wrapper_uspINSERT_PROPERTY_DETAIL (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_PROPERTY_DETAIL
@Run INT
AS
DECLARE @DName2 VARCHAR(255), @PAddress2 VARCHAR(255), @PCity2 VARCHAR(255), @PState2 VARCHAR(255),
    @PZip2 VARCHAR(255), @Quantity2 INT
DECLARE @Detail_PK INT, @Property_PK INT
DECLARE @Detail_Count INT = (SELECT COUNT(*) FROM tblDETAIL)
DECLARE @Property_Count INT = (SELECT COUNT(*) FROM tblPROPERTY)

WHILE @Run > 0
BEGIN
SET @Detail_PK = (SELECT RAND() * @Detail_Count + 1)
SET @Property_PK = (SELECT RAND() * @Property_Count + 1)

SET @DName2 = (SELECT DetailName FROM tblDETAIL WHERE DetailID = @Detail_PK)
SET @PAddress2 = (SELECT PropertyAddress FROM tblPROPERTY WHERE PropertyID = @Property_PK)
SET @PCity2 = (SELECT PropertyCity FROM tblPROPERTY WHERE PropertyID = @Property_PK)
SET @PState2 = (SELECT PropertyState FROM tblPROPERTY WHERE PropertyID = @Property_PK)
SET @PZip2 = (SELECT PropertyZip FROM tblPROPERTY WHERE PropertyID = @Property_PK)
SET @Quantity2 = (SELECT RAND() * 10)

EXEC uspINSERT_PROPERTY_DETAIL
@DName = @DName2,
@PAddress = @PAddress2,
@PCity = @PCity2,
@PState = @PState2,
@PZip = @PZip2,
@Quantity = @Quantity2

SET @Run = @Run - 1
END
GO

-- iii uspINSERT_APP_STATUS
CREATE PROCEDURE uspINSERT_APP_STATUS
@SName VARCHAR(255),
@FName VARCHAR(255),
@FDate DATE,
@ASDate DATE
AS
DECLARE @SID INT, @FID INT

EXEC uspGetStatusID
@StatusName2 = @SName,
@StatusID2 = @SID OUTPUT

IF @SID IS NULL
	BEGIN
		PRINT '@SID is empty, check spelling';
		THROW 54321, '@SID cannot be NULLL; process is terminating', 1;
	END

EXEC uspGetFormID
@FormName2 = @FName,
@FormDate2 = @FDate,
@FormID2 = @FID OUTPUT

IF @FID IS NULL
	BEGIN
		PRINT '@FID is empty, check spelling';
		THROW 54321, '@FID cannot be NULLL; process is terminating', 1;
	END

BEGIN TRANSACTION G1
INSERT INTO tblAPP_STATUS(StatusID, FormID, AppStatusDate)
VALUES (@SID, @FID, @ASDate)

IF @@ERROR <> 0
	BEGIN
		PRINT 'Something broke during commit, rollback transaction';
		ROLLBACK TRANSACTION G1
	END
ELSE
    COMMIT TRANSACTION G1
GO

-- iv wrapper_uspINSERT_APP_STATUS (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_APP_STATUS
@Run INT
AS
DECLARE @SName2 VARCHAR(255), @FName2 VARCHAR(255), @FDate2 DATE, @ASDate2 DATE
DECLARE @Status_PK INT, @Form_PK INT
DECLARE @Status_Count INT = (SELECT COUNT(*) FROM tblSTATUS)
DECLARE @Form_Count INT = (SELECT COUNT(*) FROM tblFORM)

WHILE @Run > 0
BEGIN
SET @Status_PK = (SELECT RAND() * @Status_Count + 1)
SET @Form_PK = (SELECT RAND() * @Form_Count + 1)

SET @SName2 = (SELECT StatusName FROM tblSTATUS WHERE StatusID = @Status_PK)
SET @FName2 = (SELECT FormName FROM tblFORM WHERE FormID = @Form_PK)
SET @FDate2 = (SELECT FormDate FROM tblFORM WHERE FormID = @Form_PK)
SET @ASDate2 = (SELECT DATEADD(DAY, -(SELECT RAND() * 10000), GETDATE()))

EXEC uspINSERT_APP_STATUS
@SName = @SName2,
@FName = @FName2,
@FDate = @FDate2,
@ASDate = @ASDate2

SET @Run = @Run - 1
END
GO

-- v uspINSERT_tblCUSTOMER
CREATE OR ALTER PROCEDURE uspINSERT_tblCUSTOMER
	@CustTypeName VARCHAR(255),
	@CustFname VARCHAR(255),
	@CustLname VARCHAR(255),
	@CustDOB DATE,
	@CustEmail VARCHAR(255),
	@CustCity VARCHAR(255),
	@CustState VARCHAR(255),
	@CustZip VARCHAR(255)
AS
DECLARE @CustTypeID INT

EXEC uspGetCustomerTypeID
	@CustTypeName2 = @CustTypeName,
	@CustTypeID2 = @CustTypeID OUTPUT

IF @CustTypeID IS NULL
	BEGIN
		PRINT '@CustTypeID is empty...check spelling';
		THROW 54321, '@CustTypeID cannot be NULL; process is terminating', 1;
	END

BEGIN TRANSACTION G1
INSERT INTO tblCUSTOMER(CustTypeID, CustFirstName, CustLastName, CustDOB, CustEmail, CustCity, CustState, CustZip)
VALUES (@CustTypeID, @CustFname, @CustLname, @CustDOB, @CustEmail, @CustCity, @CustState, @CustZip)
IF @@ERROR <> 0
	BEGIN
		PRINT 'Something broke during commit...rollback transaction';
		ROLLBACK TRANSACTION G1
	END
ELSE
    COMMIT TRANSACTION G1
GO

-- vi wrapper_uspINSERT_tblCUSTOMER (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE OR ALTER PROCEDURE wrapper_uspINSERT_tblCUSTOMER
@Run INT
AS
DECLARE @CustTypeNamey VARCHAR(255), 
        @CustFnamey VARCHAR(255), 
        @CustLnamey VARCHAR(255), 
        @CustDOBy DATE, 
        @CustEmaily VARCHAR(255), 
        @CustCityy VARCHAR(255), 
        @CustStatey VARCHAR(255), 
        @CustZipy VARCHAR(255)
DECLARE @CustTypeID_PK INT, @CustID_PK INT
DECLARE @CustTypeID_Count INT = (SELECT COUNT(*) FROM tblCUSTOMER_TYPE)
DECLARE @CustID_Count INT = (SELECT COUNT(*) FROM tblCUSTOMER)

WHILE @Run > 0
BEGIN
SET @CustTypeID_PK = (SELECT RAND() * @CustTypeID_Count + 1)
SET @CustID_PK = (SELECT RAND() * @CustID_Count + 1) 

SET @CustTypeNamey = (SELECT CustTypeName FROM tblCUSTOMER_TYPE WHERE CustTypeID = @CustTypeID_PK )
SET @CustFnamey = (SELECT CustFirstName FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustLnamey = (SELECT CustLastName FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustDOBy = (SELECT CustDOB FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustEmaily = (SELECT CustEmail FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustCityy = (SELECT CustCity FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustStatey = (SELECT CustState FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustZipy = (SELECT CustZip FROM tblCUSTOMER WHERE CustID = @CustID_PK)

EXEC uspINSERT_tblCUSTOMER
@CustTypeName = @CustTypeNamey,
@CustFname = @CustFnamey,
@CustLname = @CustLnamey,
@CustDOB = @CustDOBy,
@CustEmail = @CustEmaily,
@CustCity = @CustCityy,
@CustState = @CustStatey,
@CustZip = @CustZipy

SET @Run = @Run - 1
END
GO

-- vii uspINSERT_tblVISIT
CREATE PROCEDURE uspINSERT_tblVISIT
@CustFirstName VARCHAR(255),
@CustLastName VARCHAR(255),
@CustDOB DATE,
@PropertyAddress VARCHAR(255),
@PropertyCity VARCHAR(255),
@PropertyState VARCHAR(255),
@PropertyZip VARCHAR(5),
@VisitDate DATE
AS 
DECLARE @ListingID INT, @CustID INT

SET @ListingID = (SELECT L.ListingID
            FROM tblLISTING L
                JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID
            WHERE P.PropertyAddress = @PropertyAddress
                AND P.PropertyCity = @PropertyCity
                AND P.PropertyState = @PropertyState
                AND P.PropertyZip = @PropertyZip)

IF @ListingID IS NULL
    BEGIN
        PRINT '@ListingID is empty, check spelling';
        THROW 54321, '@ListingID cannot be null', 1;
    END

EXEC uspGetCustomerID
	@CustFirstName2 = @CustFirstName,
    @CustLastName2 = @CustLastName,
    @CustDOB2 = @CustDOB,
	@CustID2 = @CustID OUTPUT

IF @CustID IS NULL
    BEGIN
        PRINT '@CustID is empty, check spelling';
        THROW 54321, '@CustID cannot be null', 1;
    END

BEGIN TRANSACTION G1
INSERT INTO tblVISIT (ListingID, CustID, VisitDate)
VALUES (@ListingID, @CustID, @VisitDate)
IF @@ERROR <> 0
    BEGIN
    	PRINT 'TRX failed';
        ROLLBACK TRANSACTION G1
    END
ELSE
    COMMIT TRANSACTION G1
GO

-- viii wrapper_uspINSERT_tblVISIT (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_tblVISIT
@Run INT
AS
DECLARE @CustFirstNamey VARCHAR(255),
        @CustLastNamey VARCHAR(255),
        @CustDOBy date,
        @PropertyAddressy VARCHAR(255),
        @PropertyCityy VARCHAR(255),
        @PropertyStatey VARCHAR(255),
        @PropertyZipy VARCHAR(5),
        @VisitDatey date
DECLARE @ListingID_PK INT, @CustID_PK INT
DECLARE @Listing_Count INT = (SELECT COUNT(*) FROM tblLISTING)
DECLARE @Cust_Count INT = (SELECT COUNT(*) FROM tblCUSTOMER)

WHILE @Run > 0
BEGIN
SET @ListingID_PK = (SELECT RAND() * @Listing_Count + 1)
SET @CustID_PK = (SELECT RAND() * @Cust_Count + 1)

SET @CustFirstNamey = (SELECT CustFirstName FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustLastNamey = (SELECT CustLastName FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @CustDOBy = (SELECT CustDOB FROM tblCUSTOMER WHERE CustID = @CustID_PK)
SET @PropertyAddressy = (SELECT PropertyAddress FROM tblLISTING L JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE ListingID = @ListingID_PK)
SET @PropertyCityy = (SELECT PropertyCity FROM tblLISTING L JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE ListingID = @ListingID_PK)
SET @PropertyStatey = (SELECT PropertyState FROM tblLISTING L JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE ListingID = @ListingID_PK)
SET @PropertyZipy = (SELECT PropertyZip FROM tblLISTING L JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE ListingID = @ListingID_PK)
SET @VisitDatey = (SELECT DATEADD(DAY, -(SELECT RAND() * 10000), GETDATE()))

EXEC uspINSERT_tblVISIT
@CustFirstName = @CustFirstNamey,
@CustLastName = @CustLastNamey,
@CustDOB = @CustDOBy, 
@PropertyAddress = @PropertyAddressy,
@PropertyCity = @PropertyCityy,
@PropertyState = @PropertyStatey,
@PropertyZip = @PropertyZipy,
@VisitDate = @VisitDatey

SET @Run = @Run - 1
END
GO


-- ix uspINSERT_tblREVIEW
CREATE PROCEDURE uspINSERT_tblREVIEW
@RatingName VARCHAR(255),
@CustFirstName VARCHAR(255),
@CustLastName VARCHAR(255),
@CustDOB date,
@PropertyAddress VARCHAR(255),
@PropertyCity VARCHAR(255),
@PropertyState VARCHAR(255),
@PropertyZip VARCHAR(5),
@ReviewBody VARCHAR(255)
AS 
DECLARE @RatingID INT, @VisitID INT

EXEC uspGetRatingID
	@RatingName2 = @RatingName,
	@RatingID2 = @RatingID OUTPUT

IF @RatingID IS NULL
    BEGIN
        PRINT '@RatingID is empty, check spelling';
        THROW 54321, '@RatingID cannot be null', 1;
    END

SET @VisitID = (SELECT VisitID 
        FROM tblVisit V
            JOIN tblLISTING L ON L.ListingID = V.ListingID
			JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID
            JOIN tblCUSTOMER C ON C.CustID = V.CustID
          WHERE P.PropertyAddress = @PropertyAddress
              AND P.PropertyCity = @PropertyCity
              AND P.PropertyState = @PropertyState
              AND P.PropertyZip = @PropertyZip
              AND C.CustFirstName = @CustFirstName
              AND C.CustLastName = @CustLastName
              AND C.CustDOB = @CustDOB)

IF @VisitID IS NULL
    BEGIN
        PRINT '@VisitID is empty, check spelling';
        THROW 54321, '@VisitID cannot be null', 1;
    END

BEGIN TRANSACTION G1
INSERT INTO tblREVIEW (RatingID, VisitID, ReviewBody)
VALUES (@RatingID, @VisitID, @ReviewBody)
IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION G1
    END
ELSE
    COMMIT TRANSACTION G1
GO

-- x wrapper_uspINSERT_tblREVIEW (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_tblREVIEW
@Run INT
AS
DECLARE @RatingNamey VARCHAR(255),
		@CustFirstNamey VARCHAR(255),
        @CustLastNamey VARCHAR(255),
        @CustDOBy date,
        @PropertyAddressy VARCHAR(255),
        @PropertyCityy VARCHAR(255),
        @PropertyStatey VARCHAR(255),
        @PropertyZipy VARCHAR(5),
        @ReviewBodyy VARCHAR(255)
        
DECLARE @RatingID_PK INT, @VisitID_PK INT
DECLARE @Rating_Count INT = (SELECT COUNT(*) FROM tblRATING)
DECLARE @Visit_Count INT = (SELECT COUNT(*) FROM tblVISIT)

WHILE @Run > 0
BEGIN
SET @RatingID_PK = (SELECT RAND() * @Rating_Count + 1)
SET @VisitID_PK = (SELECT RAND() * @Visit_Count + 1)

SET @RatingNamey = (SELECT RatingName FROM tblRATING WHERE RatingID = @RatingID_PK)
SET @CustFirstNamey = (SELECT CustFirstName FROM tblVISIT V JOIN tblCUSTOMER C ON C.CustID = V.CustID WHERE VisitID = @VisitID_PK)
SET @CustLastNamey = (SELECT CustLastName FROM tblVISIT V JOIN tblCUSTOMER C ON C.CustID = V.CustID WHERE VisitID = @VisitID_PK)
SET @CustDOBy = (SELECT CustDOB FROM tblVISIT V JOIN tblCUSTOMER C ON C.CustID = V.CustID WHERE VisitID = @VisitID_PK)
SET @PropertyAddressy = (SELECT PropertyAddress FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @PropertyCityy = (SELECT PropertyCity FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @PropertyStatey = (SELECT PropertyState FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @PropertyZipy = (SELECT PropertyZip FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @ReviewBodyy = (SELECT CONVERT(varchar(255), NEWID())) --RANDOM VARCHAR

EXEC uspINSERT_tblREVIEW
@RatingName = @RatingNamey,
@CustFirstName = @CustFirstNamey,
@CustLastName = @CustLastNamey,
@CustDOB = @CustDOBy, 
@PropertyAddress = @PropertyAddressy,
@PropertyCity = @PropertyCityy,
@PropertyState = @PropertyStatey,
@PropertyZip = @PropertyZipy,
@ReviewBody = @ReviewBodyy

SET @Run = @Run - 1
END
GO


-- xi uspINSERT_tblFORM
CREATE PROCEDURE uspINSERT_tblFORM
@FormTypeName VARCHAR(255),
@CustFirstName VARCHAR(255),
@CustLastName VARCHAR(255),
@CustDOB DATE,
@PropertyAddress VARCHAR(255),
@PropertyCity VARCHAR(255),
@PropertyState VARCHAR(255),
@PropertyZip VARCHAR(5),
@FormName VARCHAR(255),
@FormDate DATE
AS 
DECLARE @FormTypeID INT, @VisitID INT

EXEC uspGetFormTypeID
	@FormTypeName2 = @FormTypeName,
	@FormTypeID2 = @FormTypeID OUTPUT

IF @FormTypeID IS NULL
    BEGIN
        PRINT '@FormTypeID is empty, check spelling';
        THROW 54321, '@FormTypeID cannot be null', 1;
    END

SET @VisitID = (SELECT VisitID 
        FROM tblVisit V
            JOIN tblLISTING L ON L.ListingID = V.ListingID
			JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID
            JOIN tblCUSTOMER C ON C.CustID = V.CustID
          WHERE P.PropertyAddress = @PropertyAddress
              AND P.PropertyCity = @PropertyCity
              AND P.PropertyState = @PropertyState
              AND P.PropertyZip = @PropertyZip
              AND C.CustFirstName = @CustFirstName
              AND C.CustLastName = @CustLastName
              AND C.CustDOB = @CustDOB)

IF @VisitID IS NULL
    BEGIN
        PRINT '@VisitID is empty, check spelling';
        THROW 54321, '@VisitID cannot be null', 1;
    END

BEGIN TRANSACTION G1
INSERT INTO tblFORM (FormTypeID, VisitID, FormName, FormDate)
VALUES (@FormTypeID, @VisitID, @FormName, @FormDate)
IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION G1
    END
ELSE
    COMMIT TRANSACTION G1
GO

-- xii wrapper_uspINSERT_tblFORM (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_tblFORM
@Run INT
AS
DECLARE @FormTypeNamey VARCHAR(255),
		@CustFirstNamey VARCHAR(255),
        @CustLastNamey VARCHAR(255),
        @CustDOBy date,
        @PropertyAddressy VARCHAR(255),
        @PropertyCityy VARCHAR(255),
        @PropertyStatey VARCHAR(255),
        @PropertyZipy VARCHAR(5),
        @FormNamey VARCHAR(255),
        @FormDatey DATE
        
DECLARE @FormTypeID_PK INT, @VisitID_PK INT
DECLARE @FormType_Count INT = (SELECT COUNT(*) FROM tblFORM_TYPE)
DECLARE @Visit_Count INT = (SELECT COUNT(*) FROM tblVISIT)

WHILE @Run > 0
BEGIN
SET @FormTypeID_PK = (SELECT RAND() * @FormType_Count + 1)
SET @VisitID_PK = (SELECT RAND() * @Visit_Count + 1)

SET @FormTypeNamey = (SELECT FormTypeName FROM tblFORM_TYPE FT WHERE FormTypeID = @FormTypeID_PK)
SET @CustFirstNamey = (SELECT CustFirstName FROM tblVISIT V JOIN tblCUSTOMER C ON C.CustID = V.CustID WHERE VisitID = @VisitID_PK)
SET @CustLastNamey = (SELECT CustLastName FROM tblVISIT V JOIN tblCUSTOMER C ON C.CustID = V.CustID WHERE VisitID = @VisitID_PK)
SET @CustDOBy = (SELECT CustDOB FROM tblVISIT V JOIN tblCUSTOMER C ON C.CustID = V.CustID WHERE VisitID = @VisitID_PK)
SET @PropertyAddressy = (SELECT PropertyAddress FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @PropertyCityy = (SELECT PropertyCity FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @PropertyStatey = (SELECT PropertyState FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @PropertyZipy = (SELECT PropertyZip FROM tblVISIT V JOIN tblLISTING L ON L.ListingID = V.ListingID JOIN tblPROPERTY P ON P.PropertyID = L.PropertyID WHERE VisitID = @VisitID_PK)
SET @FormNamey = (SELECT CONVERT(varchar(255), NEWID())) --RANDOM VARCHAR
SET @FormDatey = (SELECT DATEADD(DAY, -(SELECT RAND() * 10000), GETDATE()))

EXEC uspINSERT_tblFORM
@FormTypeName = @FormTypeNamey,
@CustFirstName = @CustFirstNamey,
@CustLastName = @CustLastNamey,
@CustDOB = @CustDOBy, 
@PropertyAddress = @PropertyAddressy,
@PropertyCity = @PropertyCityy,
@PropertyState = @PropertyStatey,
@PropertyZip = @PropertyZipy,
@FormName = @FormNamey,
@FormDate = @FormDatey

SET @Run = @Run - 1
END
GO

-- xiii. uspINSERT_tblAGENT
CREATE OR ALTER PROCEDURE uspINSERT_tblAGENT
	@AgencyName VARCHAR(255),
	@AgentFname VARCHAR(255),
	@AgentLname VARCHAR(255),
    @AgentDOB DATE,
	@AgentEmail VARCHAR(255),
    @AgentState VARCHAR(255)
AS
DECLARE @AgencyID INT, @AgentID INT
EXEC uspGetAgencyID
	@AgencyName2 = @AgencyName,
    @AgencyID2 = @AgencyID OUTPUT
IF @AgencyID IS NULL
	BEGIN
    	PRINT '@AgencyID is empty...check spelling';
		THROW 54321, '@AgencyID cannot be NULL; process is terminating', 1;
	END
BEGIN TRANSACTION G1
INSERT INTO tblAGENT(AgencyID, AgentFirstName, AgentLastName, AgentDOB, AgentEmail, AgentState)
VALUES (@AgencyID, @AgentFname, @AgentLname, @AgentDOB, @AgentEmail, @AgentState)
IF @@ERROR <> 0
	BEGIN
		PRINT 'Something broke during commit...rollback transaction';
		ROLLBACK TRANSACTION G1
	END
ELSE
COMMIT TRANSACTION G1
GO

-- xiv. wrapper_uspINSERT_tblAGENT (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE OR ALTER PROCEDURE wrapper_uspINSERT_tblAGENT
    @Run INT
AS
DECLARE @AgencyNamey VARCHAR(255), @AgentFnamey VARCHAR(255), @AgentLnamey VARCHAR(255), @AgentDOBy DATE, @AgentEmaily VARCHAR(255), @AgentStatey VARCHAR(255)
DECLARE @Agency_PK INT
DECLARE @Agency_Count INT = (SELECT COUNT(*) FROM tblAGENCY)

WHILE @Run > 0
BEGIN
    SET @Agency_PK = (SELECT RAND() * @Agency_Count + 1) 
    IF NOT EXISTS (SELECT AgencyID FROM tblAGENCY WHERE AgencyID = @Agency_PK)
    BEGIN
        PRINT 'Found a blank PK for AgencyID; re-running the look-up process'
        SET @Agency_PK = (SELECT RAND() * @Agency_Count + 1)
        IF NOT EXISTS (SELECT AgencyID FROM tblAGENCY WHERE AgencyID = @Agency_PK)
        BEGIN
            PRINT 'Wow...Found another blank AgencyID...will try a third time'
            SET @Agency_PK = (SELECT RAND() * @Agency_Count + 1)
            IF NOT EXISTS (SELECT AgencyID FROM tblAGENCY WHERE AgencyID = @Agency_PK)
            BEGIN
            PRINT 'WTF?? Found another blank AgencyID...will try a fourth time'
            SET @Agency_PK = (SELECT RAND() * @Agency_Count + 1)
            IF NOT EXISTS (SELECT AgencyID FROM tblAGENCY WHERE AgencyID = @Agency_PK)
                BEGIN
                PRINT 'I give up!! Hard-coding value of class to a known number of 1'
                SET @Agency_PK = 1
                END
            END
        END
    END

SET @AgencyNamey = (SELECT AgencyName FROM tblAGENCY WHERE AgencyID = @Agency_PK)

CREATE TABLE #AgentTempTable (
    AgentFirstName VARCHAR(255),
    AgentLastName VARCHAR(255),
    AgentEmail VARCHAR(255),
    AgentDOB DATE,
    AgentState VARCHAR(255)
)

INSERT INTO #AgentTempTable
VALUES
    ('Alex', 'Smith', 'alex.smith1@email.com', '1986-04-11', 'California'),
    ('Sarah', 'Johnson', 'sarah.johnson@email.com', '1996-02-20', 'New York'),
    ('David', 'Brown', 'david.brown@email.com', '1981-01-07', 'Texas'),
    ('Emily', 'Davis', 'emily.davis@email.com', '1964-03-30', 'Florida'),
    ('Michael', 'Wilson', 'michael.wilson@email.com', '1991-04-03', 'Illinois'),
    ('Jennifer', 'Anderson', 'jennifer.anderson@email.com', '1957-01-22', 'Pennsylvania'),
    ('Brian', 'Taylor', 'brian.taylor@email.com', '1975-03-04', 'Ohio'),
    ('Jessica', 'Jackson', 'jessica.jackson@email.com', '1981-09-28', 'Michigan'),
    ('Matthew', 'Harris', 'matthew.harris@email.com', '1960-12-25', 'Georgia'),
    ('Olivia', 'White', 'olivia.white@email.com', '1981-11-26', 'Arizona'),
    ('Kevin', 'Martinez', 'kevin.martinez@email.com', '1986-10-28', 'North Carolina'),
    ('Lauren', 'Lewis', 'lauren.lewis@email.com', '1977-02-05', 'Virginia'),
    ('Chris', 'Clark', 'chris.clark@email.com', '1983-07-24', 'Colorado'),
    ('Samantha', 'Turner', 'samantha.turner@email.com', '1959-08-11', 'Massachusetts'),
    ('Daniel', 'Baker', 'daniel.baker@email.com', '1991-12-08', 'Washington'),
    ('Amanda', 'Hall', 'amanda.hall@email.com', '1958-03-20', 'New Jersey'),
    ('Ryan', 'Young', 'ryan.young@email.com', '1973-05-09', 'Maryland'),
    ('Megan', 'Carter', 'megan.carter@email.com', '1975-11-13', 'Minnesota'),
    ('Jason', 'Walker', 'jason.walker@email.com', '1968-03-09', 'Wisconsin'),
    ('Stephanie', 'Garcia', 'stephanie.garcia@email.com', '1967-05-24', 'Oregon'),
    ('Eric', 'Allen', 'eric.allen@email.com', '1981-07-25', 'Nevada'),
    ('Rachel', 'Hall', 'rachel.hall@email.com', '1958-12-11', 'Tennessee'),
    ('John', 'Murphy', 'john.murphy@email.com', '1967-10-08', 'Missouri'),
    ('Allison', 'Mitchell', 'allison.mitchell@email.com', '1988-07-29', 'Utah'),
    ('Patrick', 'Adams', 'patrick.adams@email.com', '1997-07-30', 'Kansas')

DECLARE @RandomRow INT;
SET @RandomRow = CAST((RAND() * 24) AS INT) + 1;

WITH NumberedAgents AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum,
        AgentFirstName,
        AgentLastName,
        AgentEmail,
        AgentDOB,
        AgentState
    FROM #AgentTempTable
)
SELECT    
    @AgentFnamey = AgentFirstName,
    @AgentLnamey = AgentLastName,
    @AgentEmaily = AgentEmail,
    @AgentDOBy = AgentDOB,
    @AgentStatey = AgentState
FROM NumberedAgents
WHERE RowNum = @RandomRow;

DROP TABLE #AgentTempTable

EXEC uspINSERT_tblAGENT
    @AgencyName = @AgencyNamey,
    @AgentFname = @AgentFnamey,
    @AgentLname = @AgentLnamey,
    @AgentEmail = @AgentEmaily,
    @AgentDOB = @AgentDOBy,
    @AgentState = @AgentStatey
SET @Run = @Run -1
END
GO

-- xv. uspINSERT_DETAIL
CREATE PROCEDURE uspINSERT_DETAIL
    @DetailTypeName VARCHAR(255),
    @DetailName VARCHAR(255),
    @DetailDescr VARCHAR(255)
AS
DECLARE @DetailTypeID INT

EXEC uspGetDetailTypeID
    @DetailTypeName2 = @DetailTypeName,
    @DetailTypeID2 = @DetailTypeID OUTPUT

IF @DetailTypeID IS NULL
    BEGIN
        PRINT '@DetailTypeID is empty, check spelling';
        THROW 54321, '@DetailTypeID cannot be null', 1;
    END

BEGIN TRANSACTION G1
INSERT INTO tblDETAIL (DetailTypeID, DetailName, DetailDescr)
VALUES (@DetailTypeID, @DetailName, @DetailDescr)
IF @@ERROR <> 0
    BEGIN
    	PRINT 'TRX failed';
        ROLLBACK TRANSACTION G1
    END
ELSE
    COMMIT TRANSACTION G1
GO

-- xvi. wrapper_uspINSERT_DETAIL (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_DETAIL
    @Run INT
AS
DECLARE @DetailTypeNamey VARCHAR(255),
    @DetailNamey VARCHAR(255),
    @DetailDescry VARCHAR(255)
DECLARE @DetailType_PK INT
DECLARE @DetailType_Count INT = (SELECT COUNT(*) FROM tblDETAIL_TYPE)

WHILE @Run > 0
BEGIN
    SET @DetailType_PK = (SELECT RAND() * @DetailType_Count + 1)
    SET @DetailTypeNamey = (SELECT DetailTypeName FROM tblDETAIL_TYPE WHERE DetailTypeID = @DetailType_PK)
    SET @DetailNamey = (SELECT CONVERT(varchar(255), NEWID()))
    SET @DetailDescry = (SELECT CONVERT(varchar(255), NEWID()))

    EXEC uspINSERT_DETAIL
        @DetailTypeName = @DetailTypeNamey,
        @DetailName = @DetailNamey,
        @DetailDescr = @DetailDescry

    SET @Run = @Run - 1
END
GO

-- xvii. uspINSERT_PROPERTY
CREATE PROCEDURE uspINSERT_PROPERTY
    @PropertyTypeName VARCHAR(255),
    @PropertyAddress VARCHAR(255),
    @PropertyDescr VARCHAR(255),
    @PropertyCity VARCHAR(255),
    @PropertyState VARCHAR(255),
    @PropertyZip VARCHAR(5)
AS
DECLARE @PropertyTypeID INT

EXEC uspGetPropertyTypeID
    @PropertyTypeName2 = @PropertyTypeName,
    @PropertyTypeID2 = @PropertyTypeID OUTPUT

IF @PropertyTypeID IS NULL
    BEGIN
        PRINT '@PropertyTypeID is empty, check spelling';
        THROW 54321, '@PropertyTypeID cannot be null', 1;
    END

BEGIN TRANSACTION G1
INSERT INTO tblPROPERTY (PropertyTypeID, PropertyAddress, PropertyDescr, PropertyCity, PropertyState, PropertyZip)
VALUES (@PropertyTypeID, @PropertyAddress, @PropertyDescr, @PropertyCity, @PropertyState, @PropertyZip)
IF @@ERROR <> 0
    BEGIN
    	PRINT 'TRX failed';
        ROLLBACK TRANSACTION G1
    END
ELSE
    COMMIT TRANSACTION G1
GO

-- xviii. wrapper_uspINSERT_PROPERTY (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_PROPERTY
    @Run INT
AS
DECLARE @PropertyTypeNamey VARCHAR(255),
    @PropertyAddressy VARCHAR(255),
    @PropertyDescry VARCHAR(255),
    @PropertyCityy VARCHAR(255),
    @PropertyStatey VARCHAR(255),
    @PropertyZipy VARCHAR(5)
DECLARE @PropertyType_PK INT
DECLARE @PropertyType_Count INT = (SELECT COUNT(*) FROM tblPROPERTY_TYPE)

WHILE @Run > 0
BEGIN
    SET @PropertyType_PK = (SELECT RAND() * @PropertyType_Count + 1)
    SET @PropertyTypeNamey = (SELECT PropertyTypeName FROM tblPROPERTY_TYPE WHERE PropertyTypeID = @PropertyType_PK)
    SET @PropertyAddressy = (SELECT CONVERT(varchar(255), NEWID()))
    SET @PropertyCityy = (SELECT CONVERT(varchar(255), NEWID()))
    SET @PropertyStatey = (SELECT CONVERT(varchar(255), NEWID()))
    SET @PropertyZipy = (SELECT CONVERT(varchar(255), NEWID()))

    EXEC uspINSERT_PROPERTY
        @PropertyTypeName = @PropertyTypeNamey,
        @PropertyAddress = @PropertyAddressy,
        @PropertyDescr = @PropertyDescry,
        @PropertyCity = @PropertyCityy,
        @PropertyState = @PropertyStatey,
        @PropertyZip = @PropertyZipy

    SET @Run = @Run - 1
END
GO

-- xix. uspINSERT_LISTING
CREATE PROCEDURE uspINSERT_LISTING
    @AgentFirstName VARCHAR(255),
    @AgentLastName VARCHAR(255),
    @AgentDOB DATE,
    @PropertyAddress VARCHAR(255),
    @PropertyCity VARCHAR(255),
    @PropertyState VARCHAR(255),
    @PropertyZip VARCHAR(5),
    @ListingTypeName VARCHAR(255),
    @ListingPrice NUMERIC(9,2),
    @ListingDate DATE
AS
DECLARE @AgentID INT, @PropertyID INT, @ListingTypeID INT
EXEC uspGetAgentID
    @AgentFirstName2 = @AgentFirstName,
    @AgentLastName2 = @AgentLastName,
    @AgentDOB2 = @AgentDOB,
    @AgentID2 = @AgentID OUTPUT

IF @AgentID IS NULL
    BEGIN
        PRINT '@AgentID is empty, check spelling';
        THROW 54321, '@AgentID cannot be null', 1;
    END

EXEC uspGetPropertyID
    @PropertyAddress2 = @PropertyAddress,
    @PropertyCity2 = @PropertyCity,
    @PropertyState2 = @PropertyState,
    @PropertyZip2 = @PropertyZip,
    @PropertyID2 = @PropertyID OUTPUT 

IF @PropertyID IS NULL
    BEGIN
        PRINT '@PropertyID is empty, check spelling';
        THROW 54321, '@PropertyID cannot be null', 1;
    END

EXEC uspGetListingTypeID
    @ListingTypeName2 = @ListingTypeName,
    @ListingTypeID2 = @ListingTypeID OUTPUT

IF @ListingTypeID IS NULL
    BEGIN
        PRINT '@ListingTypeID is empty, check spelling';
        THROW 54321, '@ListingTypeID cannot be null', 1;
    END

BEGIN TRANSACTION G1
INSERT INTO tblLISTING (PropertyID, ListingTypeID, AgentID, ListingPrice, ListingDate)
VALUES (@PropertyID, @ListingTypeID, @AgentID, @ListingPrice, @ListingDate)
IF @@ERROR <> 0
    BEGIN
    	PRINT 'TRX failed';
        ROLLBACK TRANSACTION G1
    END
ELSE
    COMMIT TRANSACTION G1
GO

-- xx. wrapper_uspINSERT_LISTING (Synthetic Transaction - 'Wrapper' Stored Procedure)
CREATE PROCEDURE wrapper_uspINSERT_LISTING
    @Run INT
AS
DECLARE @AgentFirstNamey VARCHAR(255),
    @AgentLastNamey VARCHAR(255),
    @AgentDOBy DATE,
    @PropertyAddressy VARCHAR(255),
    @PropertyCityy VARCHAR(255),
    @PropertyStatey VARCHAR(255),
    @PropertyZipy VARCHAR(5),
    @ListingTypeNamey VARCHAR(255),
    @ListingPricey NUMERIC(9,2),
    @ListingDatey DATE
DECLARE @Agent_PK INT, @Property_PK INT, @ListingType_PK INT
DECLARE @Agent_Count INT = (SELECT COUNT(*) FROM tblAGENT)
DECLARE @Property_Count INT = (SELECT COUNT(*) FROM tblPROPERTY)
DECLARE @ListingType_Count INT = (SELECT COUNT(*) FROM tblLISTING_TYPE)

WHILE @Run > 0
BEGIN

    SET @Agent_PK = (SELECT RAND() * @Agent_Count + 1)
    SET @Property_PK = (SELECT RAND() * @Property_Count + 1)
    SET @ListingType_PK = (SELECT RAND() * @ListingType_Count + 1)

    SET @AgentFirstNamey = (SELECT AgentFirstName FROM tblAGENT WHERE AgentID = @Agent_PK)
    SET @AgentLastNamey = (SELECT AgentLastName FROM tblAGENT WHERE AgentID = @Agent_PK)
    SET @AgentDOBy = (SELECT AgentDOB FROM tblAGENT WHERE AgentID = @Agent_PK)
    SET @PropertyAddressy = (SELECT PropertyAddress FROM tblPROPERTY WHERE PropertyID = @Property_PK)
    SET @PropertyCityy = (SELECT PropertyCity FROM tblPROPERTY WHERE PropertyID = @Property_PK)
    SET @PropertyStatey = (SELECT PropertyState FROM tblPROPERTY WHERE PropertyID = @Property_PK)
    SET @PropertyZipy = (SELECT PropertyZip FROM tblPROPERTY WHERE PropertyID = @Property_PK)
    SET @ListingTypeNamey = (SELECT ListingTypeName FROM tblLISTING_TYPE WHERE ListingTypeID = @ListingType_PK)

    SET @ListingPricey =(SELECT RAND() * 10000)
    SET @ListingDatey = (SELECT DATEADD(DAY, -(SELECT RAND() * 10000), GETDATE()))

    EXEC uspINSERT_LISTING
        @AgentFirstName = @AgentFirstNamey,
        @AgentLastName = @AgentLastNamey,
        @AgentDOB = @AgentDOBy,
        @PropertyAddress = @PropertyAddressy,
        @PropertyCity = @PropertyCityy,
        @PropertyState = @PropertyStatey,
        @PropertyZip = @PropertyZipy,
        @ListingTypeName = @ListingTypeNamey,
        @ListingPrice = @ListingPricey,
        @ListingDate = @ListingDatey
    
    SET @Run = @Run - 1
END
GO

-- POPULATE USING PEEPS
INSERT INTO team1_project.dbo.tblCUSTOMER (CustTypeID, CustFirstName, CustLastName, CustDOB, CustEmail, CustCity, CustState, CustZip)
SELECT TOP 100000
    CAST((RAND() * 10 + 1) AS INT) AS CustTypeID,
    CustomerFname, 
    CustomerLname, 
    DateOfBirth, 
    Email, 
    CustomerCity, 
    CustomerState, 
    CustomerZip
FROM PEEPS.dbo.tblCUSTOMER
GO

INSERT INTO team1_project.dbo.tblAGENCY (AgencyName, AgencyEmail)
SELECT TOP 1000
    CustomerLname,
    Email
FROM PEEPS.dbo.tblCUSTOMER
GO


INSERT INTO team1_project.dbo.tblAGENT (AgencyID, AgentFirstName, AgentLastName, AgentDOB, AgentEmail, AgentState)
SELECT TOP 100000
    CAST((RAND() * 100 + 1) AS INT) AS AgencyID,
    CustomerFname, 
    CustomerLname, 
    DateOfBirth, 
    Email, 
    CustomerState
FROM PEEPS.dbo.tblCUSTOMER
GO

INSERT INTO team1_project.dbo.tblPROPERTY (PropertyTypeID, PropertyAddress, PropertyDescr, PropertyCity, PropertyState, PropertyZip)
SELECT TOP 100000
    CAST((RAND() * 20 + 1) AS INT) AS PropertyTypeID,
    CustomerAddress, 
    CustomerLname, 
    CustomerCity, 
    CustomerState, 
    CustomerZip
FROM PEEPS.dbo.tblCUSTOMER
GO

-- POPULATE/TEST USING SYNTHETIC TRANSACTION
/*
wrapper_uspINSERT_LISTING 10
GO
wrapper_uspINSERT_tblVISIT 10
GO
wrapper_uspINSERT_PROPERTY_DETAIL 10
GO
wrapper_uspINSERT_tblREVIEW 10
GO
wrapper_uspINSERT_tblFORM 10
GO
wrapper_uspINSERT_APP_STATUS 10
GO
*/

-- CHECK CONSTRAINT
-- i No one younger than 18 can submit an application form
CREATE FUNCTION fn_Cust18Form()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
EXISTS (SELECT *
    FROM tblCUSTOMER C
        JOIN tblVISIT V ON C.CustID = V.CustID
        JOIN tblFORM F ON V.VisitID = F.VisitID
        JOIN tblFORM_TYPE FT ON F.FormTypeID = FT.FormTypeID
    WHERE C.CustDOB < DATEADD(YEAR, -18, GETDATE())
        AND FT.FormTypeName = 'Application')
SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblFORM
ADD CONSTRAINT CK_No18Apps
CHECK (dbo.fn_Cust18Form() = 0)
GO

-- ii No agents can be handling properties from a different state
CREATE FUNCTION fn_AgentProperty()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
EXISTS (SELECT *
    FROM tblAgent A
        JOIN tblLISTING L ON A.AgentID = L.AgentID
        JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
    WHERE A.AgentState != P.PropertyState)
SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblLISTING
ADD CONSTRAINT CK_AgentPropertyState
CHECK (dbo.fn_AgentProperty() = 0) 
GO

-- iii. A rental application form can only be submitted after they have visited the property
CREATE FUNCTION fn_SubmitFormVisit()
RETURNS INT
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (
	SELECT *
  	FROM tblVISIT V
  		JOIN tblFORM F ON V.VisitID = F.VisitID
  		JOIN tblFORM_TYPE FT ON F.FormTypeID = FT.FormTypeID
  		JOIN tblAPP_STATUS AST ON F.FormID = AST.FormID
  		JOIN tblSTATUS ST ON AST.StatusID = ST.StatusID
	WHERE FT.FormTypeName = 'Rental Application'
    	AND V.VisitDate <= F.FormDate)
  SET @RET = 1
RETURN @RET
END
GO

ALTER TABLE tblFORM
ADD CONSTRAINT ck_NoSubmitFormWithoutVisit
CHECK (dbo.fn_SubmitFormVisit() = 0)
GO

-- iv Properties may only be visited if the property is being actively sold or open house (ListingTypeName = 'For Sale' AND ListingTypeName = 'Open House')
CREATE FUNCTION fn_VisitProperty()
RETURNS INT
AS
BEGIN
DECLARE @RET INT = 0
IF EXISTS (
	SELECT *
  	FROM tblVISIT V
  		JOIN tblLISTING L ON V.ListingID = L.ListingID
  		JOIN tblLISTING_TYPE LT ON L.ListingTypeID = LT.ListingTypeID
	WHERE (LT.ListingTypeName <> 'For Sale'
  		OR LT.ListingTypeName <> 'Open House')
)
	SET @RET = 1
RETURN @RET
END
GO

ALTER TABLE tblVISIT
ADD CONSTRAINT ck_NoVisitProperty
CHECK (dbo.fn_VisitProperty() = 0)
GO

-- v A property can't have a listing price that is negative
CREATE FUNCTION fn_ListingPriceNonNeg()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
    EXISTS (SELECT *
        FROM tblPROPERTY P
        JOIN tblLISTING L ON  P.PropertyID = L.PropertyID
        WHERE L.ListingPrice < 0)
    SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblPROPERTY
ADD CONSTRAINT CK_ListingPriceNonNeg
CHECK (dbo.fn_ListingPriceNonNeg() = 0)
GO

-- vi A listing can only get its corresponding form(Rental/RentalApplication and Sale/BuyerApplication)
CREATE FUNCTION fn_ListingToApp()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
    EXISTS (SELECT *
        FROM tblLISTING L
            JOIN tblLISTING_TYPE LT ON L.ListingTypeID = LT.ListingTypeID
            JOIN tblVISIT V ON L.ListingID = V.ListingID
            JOIN tblFORM F ON V.VisitID = F.VisitID
            JOIN tblFORM_TYPE FT ON F.FormTypeID = FT.FormTypeID
        WHERE (LT.ListingTypeName = 'For Rent' AND FT.FormTypeName <> 'Rental Application') OR 
            (LT.ListingTypeName = 'For Sale' AND FT.FormTypeName <> 'Purchase Application'))
    SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblLISTING
ADD CONSTRAINT CK_ListingToApp
CHECK (dbo.fn_ListingToApp() = 0) 
GO

-- vii Houses with x number of bathrooms can’t be in a certain state (lets say New Hampshire can only have 5 or less bathrooms)
CREATE FUNCTION fn_NHBathroomsFiveLess()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
    EXISTS (SELECT *
        FROM tblPROPERTY P
        	JOIN tblPROPERTY_DETAIL PD ON  PD.PropertyID = P.PropertyID
            JOIN tblDETAIL D ON D.DetailID = PD.DetailID
        WHERE P.PropertyState = 'New Hampshire, NH'
        	AND D.DetailName = 'Bathrooms'
           	AND PD.Quantity > 5)
    SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblPROPERTY
ADD CONSTRAINT CK_NHBathroomsFiveLess
CHECK (dbo.fn_NHBathroomsFiveLess() = 0)
GO

-- viii A house cannot have no bedrooms

CREATE FUNCTION fn_HouseNoBedrooms()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
    EXISTS (SELECT *
        FROM tblPROPERTY P
        	JOIN tblPROPERTY_DETAIL PD ON  PD.PropertyID = P.PropertyID
            JOIN tblDETAIL D ON D.DetailID = PD.DetailID
        WHERE D.DetailName = 'Bedrooms'
           	AND PD.Quantity <= 0)
    SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblPROPERTY
ADD CONSTRAINT CK_HouseNoBedrooms
CHECK (dbo.fn_HouseNoBedrooms() = 0)
GO

-- COMPUTED COLUMN
-- i Average numeric rating for each listing for properties with more than 2 bathrooms
CREATE FUNCTION fn_AvgRatingListing(@PK INT)
RETURNS NUMERIC(3,2)
AS
BEGIN

DECLARE @RET NUMERIC(3,2) = (SELECT AVG(RatingNumber)
    FROM tblRATING R
        JOIN tblREVIEW RW ON R.RatingID = RW.RatingID
        JOIN tblVISIT V ON RW.VisitID = V.VisitID
        JOIN tblLISTING L ON V.ListingID = L.ListingID
        JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
        JOIN tblPROPERTY_DETAIL PD ON P.PropertyID = PD.PropertyID
        JOIN tblDETAIL D ON PD.DetailID = D.DetailID
    WHERE L.ListingID = @PK
        AND PD.Quantity > 2
        AND D.DetailName = 'Bathrooms')

RETURN @RET
END
GO

ALTER TABLE tblLISTING
ADD Calc_AvgRating AS (dbo.fn_AvgRatingListing(ListingID))
GO

-- ii Total number of listings for each property in the state of Washington
CREATE FUNCTION fn_CountListingProperty(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(*)
    FROM tblPROPERTY P
        JOIN tblLISTING L ON P.PropertyID = L.PropertyID
    WHERE P.PropertyID = @PK
        AND P.PropertyState = 'Washington, WA')

RETURN @RET
END
GO

ALTER TABLE tblPROPERTY
ADD Calc_CountListing AS (dbo.fn_CountListingProperty(PropertyID))
GO

-- iii. Average price of houses by zipcodes in the city of Seattle
CREATE FUNCTION fn_AvgPriceHousesZip(@ZipCode VARCHAR(5))
RETURNS NUMERIC(9,2)
AS
BEGIN

DECLARE @RET NUMERIC(9,2) = (
	SELECT AVG(L.ListingPrice)
  	FROM tblLISTING L
  		JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
  		JOIN tblPROPERTY_TYPE PT ON P.PropertyTypeID = PT.PropertyTypeID
	WHERE P.PropertyZip = @ZipCode
  		AND PT.PropertyTypeName = 'House'
  		AND P.PropertyCity = 'Seattle'
)
RETURN @RET
END
GO

ALTER TABLE tblPROPERTY
ADD Calc_AvgPrice AS (dbo.fn_AvgPriceHousesZip(PropertyZip))
GO

-- iv. Total Number of agents born before the 2000's in a given state
CREATE FUNCTION fn_CountAdultAgent(@State VARCHAR(255))
RETURNS INT
AS
BEGIN 

DECLARE @RET INT = (
	SELECT COUNT(*)
	FROM tblAGENT A
  	WHERE A.AgentState = @State
  		AND YEAR(A.AgentDOB) < 2000
)

RETURN @RET
END
GO

ALTER TABLE tblAGENT
ADD Calc_CountListing AS (dbo.fn_CountAdultAgent(AgentState))
GO

-- v Number of visits that are looking for a house in a state (COUNT)
CREATE FUNCTION fn_NumOfVisitBuyersInWash(@PK INT)
RETURNS NUMERIC(3,2)
AS
BEGIN

DECLARE @RET NUMERIC(3,2) = (SELECT COUNT(CustFirstName)
    FROM tblVISIT V 
        JOIN tblCUSTOMER C ON C.CustID = V.CustID
        JOIN tblCUSTOMER_TYPE CT ON C.CustTypeID = CT.CustTypeID
    WHERE V.VisitID = @PK
    AND C.CustState = 'Washington, WA'
    AND CT.CustTypeName = 'Buyer')

RETURN @RET
END
GO

ALTER TABLE tblVISIT
ADD Calc_CountVisit AS (dbo.fn_NumOfVisitBuyersInWash(VisitID))
GO


-- vi Average age of customer buyers in the zipcode given (AVG)
CREATE FUNCTION fn_AvgCustAge(@CustZip VARCHAR(5))
RETURNS NUMERIC(4,2)
AS
BEGIN

DECLARE @RET NUMERIC(4,2) = (
	SELECT AVG((YEAR(GETDATE()) - YEAR(C.CustDOB))) AS AvgAge
  	FROM tblCUSTOMER C
  		JOIN tblCUSTOMER_TYPE CT ON C.CustTypeID = CT.CustTypeID
	WHERE C.CustID = @CustZip
  		AND CT.CustTypeName = 'Buyer'
)
RETURN @RET
END
GO

ALTER TABLE tblCUSTOMER
ADD Calc_AvgCustAge AS (dbo.fn_AvgCustAge(CustZip))
GO


-- vii Average amount of bedrooms in a given city
CREATE FUNCTION fn_AvgBedroomsCity(@City VARCHAR(255))
RETURNS Numeric(3, 2)
AS
BEGIN

DECLARE @RET Numeric(3,2) = (SELECT AVG(PD.Quantity)
    FROM tblPROPERTY P
        JOIN tblPROPERTY_DETAIL PD ON PD.PropertyID = P.PropertyID
        JOIN tblDETAIL D ON D.DetailID = PD.DetailID
    WHERE P.PropertyCity = @City
        AND D.DetailName = 'Bedrooms')

RETURN @RET
END
GO

ALTER TABLE tblPROPERTY
ADD Calc_AvgBedroomsCity AS (dbo.fn_AvgBedroomsCity(PropertyCity))
GO

-- viii Number of forms a given customer has filled out after 2010
CREATE FUNCTION fn_CountCustomerForms(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(*)
    FROM tblCUSTOMER C
        JOIN tblVISIT V ON V.CustID = C.CustID
        JOIN tblFORM F ON F.VisitID = V.VisitID
    WHERE C.CustID = @PK
    	AND YEAR(FormDate) > 2010)

RETURN @RET
END
GO

ALTER TABLE tblCUSTOMER
ADD Calc_CountCustomerForms AS (dbo.fn_CountCustomerForms(CustID))
GO


-- VIEWS
-- i Customers that have left more than 20 reviews with a last name of Fevold who also have houses in California worth more than $1,000,000
CREATE OR ALTER VIEW VW_FevoldCaliforniaReviews AS
SELECT A.*, TotalPrice
FROM
(SELECT C.CustID, C.CustFirstName, C.CustLastName, COUNT(*) AS NumReviews
FROM tblCUSTOMER C
    JOIN tblVISIT V ON C.CustID = V.CustID
    JOIN tblREVIEW R ON V.VisitID = R.VisitID
WHERE C.CustLastName = 'Fevold'
GROUP BY C.CustID, C.CustFirstName, C.CustLastName
HAVING COUNT(*) > 20) A,

(SELECT C.CustID, C.CustFirstName, C.CustLastName, SUM(L.ListingPrice) AS TotalPrice
FROM tblCUSTOMER C
    JOIN tblVISIT V ON C.CustID = V.CustID
    JOIN tblLISTING L ON V.ListingID = L.ListingID
    JOIN tblLISTING_TYPE LT ON L.ListingTypeID = LT.ListingTypeID
    JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
WHERE P.PropertyState = 'California, CA'
GROUP BY C.CustID, C.CustFirstName, C.CustLastName
HAVING SUM(L.ListingPrice) > 1000000) B

WHERE A.CustID = B.CustID
GO

-- ii Listing of properties in Texas with an average rating of at least 4.5
CREATE OR ALTER VIEW VW_TexasPropertyRating_FourPointFive AS
SELECT P.PropertyID, P.PropertyAddress, AVG(R.RatingNumber) AS AverageRating
FROM tblPROPERTY P
    JOIN tblLISTING L ON P.PropertyID = L.PropertyID
    JOIN tblVISIT V ON L.ListingID = V.ListingID
    JOIN tblREVIEW RW ON V.VisitID = RW.VisitID
    JOIN tblRATING R ON RW.RatingID = R.RatingID
WHERE P.PropertyState = 'Texas, TX'
GROUP BY P.PropertyID, P.PropertyAddress
HAVING AVG(R.RatingNumber) >= 4.5
GO

-- iii. Listing of properties that were listed within the last 90 days with a listing price less than $750,000, who have had at least 3 customer visits
CREATE OR ALTER VIEW VW_Property_90Days_750k_3Cust AS
SELECT A.*, B.NumVisits
FROM
(SELECT L.ListingID, L.ListingDate, L.ListingPrice
FROM tblLISTING L
	JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
WHERE L.ListingDate >= DATEADD(DAY, -90, GETDATE())
	AND L.ListingPrice < 750000) A,
(SELECT L.ListingID, COUNT(*) AS NumVisits
FROM tblVISIT V 
	JOIN tblLISTING L ON V.ListingID = L.ListingID
  	JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
GROUP BY L.ListingID
HAVING COUNT(*) >= 3) B

WHERE A.ListingID = B.ListingID
GO

-- iv. Top 100 listing prices for houses with more than 5 bedrooms in the state of California
CREATE OR ALTER VIEW VW_Top100CaliHouses_MoreThanFiveBedrooms AS
SELECT TOP 100 L.ListingID, L.ListingPrice, P.PropertyZip, P.PropertyCity, P.PropertyState
FROM tblLISTING L
  JOIN tblLISTING_TYPE LT ON L.ListingTypeID = LT.ListingTypeID
  JOIN tblPROPERTY P ON L.PropertyID = P.PropertyID
  JOIN tblPROPERTY_TYPE PT ON P.PropertyTypeID = PT.PropertyTypeID
  JOIN tblPROPERTY_DETAIL PD ON P.PropertyID = PD.PropertyID
  JOIN tblDETAIL D ON PD.DetailID = D.DetailID
WHERE LT.ListingTypeName = 'For Sale'
  AND PT.PropertyTypeName = 'House' 
  AND P.PropertyState = 'California, CA'
  AND PD.Quantity > 5
  AND D.DetailName = 'Bedrooms'
ORDER BY L.ListingPrice DESC
GO

-- v Properties that have at least 2 bedrooms and 2 bathrooms in Florida and in the 40th and 60th price percentile
CREATE OR ALTER VIEW VW_Florida2Bed2Bath AS
WITH CTE_PricePercentile (PropertyID, TotalPrice, PricePercentile)
AS (
SELECT P.PropertyID, SUM(L.ListingPrice), 
  	NTILE(100) OVER (ORDER BY SUM(L.ListingPrice) DESC)
FROM tblPROPERTY P
	JOIN tblLISTING L ON P.PropertyID = L.PropertyID
    JOIN tblPROPERTY_DETAIL PD ON P.PropertyID = PD.PropertyID
    JOIN tblDETAIL D ON PD.DetailID = D.DetailID
WHERE P.PropertyState = 'Florida, FL'
	AND (D.DetailName = 'Bathrooms' AND PD.Quantity >= 2) 
	AND (D.DetailName = 'Bedrooms' AND PD.Quantity >= 2) 
GROUP BY P.PropertyID)
SELECT * FROM CTE_PricePercentile WHERE PricePercentile BETWEEN 40 AND 60
GO

-- vi Customers who are buyers, located in zip code 98208, are in a percentile greater than the 90th percentile for amount of visits(aka super visitors)
CREATE OR ALTER VIEW VW_SuperCustVisits98208 AS
WITH CTE_VisitPercentile(CustID,CountVisit, VisitPercentile)
AS (
SELECT C.CustID, COUNT(V.VisitID), 
	NTILE(100) OVER (ORDER BY COUNT(V.VisitID) DESC)
FROM tblCUSTOMER C 
    JOIN tblCUSTOMER_TYPE CT ON C.CustTypeID = CT.CustTypeID
  	JOIN tblVISIT V ON C.CustID = V.CustID
WHERE CT.CustTypeName = 'Buyer'
AND C.CustZip = '98208'
GROUP BY C.CustID)
SELECT * FROM CTE_VisitPercentile WHERE VisitPercentile > 90
GO

-- vii Listing of the properties in the city of Chicago and a listing price greater than 450k with an average rating between the 42nd to 69.3th percentile
CREATE OR ALTER VIEW VW_PropertyRating420_693 AS
WITH CTE_PropertyRating420_693 (P_ID, P_Address, L_Price, AverageRating, Percentile)
AS (SELECT P.PropertyID, P.PropertyAddress, L.ListingPrice, AVG(R.RatingNumber), 
    NTILE(1000) OVER (ORDER BY AVG(R.RatingNumber) DESC)
    FROM tblPROPERTY P
    JOIN tblLISTING L ON P.PropertyID = L.PropertyID
    JOIN tblVISIT V ON L.ListingID = V.ListingID
    JOIN tblREVIEW RW ON V.VisitID = RW.VisitID
    JOIN tblRATING R ON RW.RatingID = R.RatingID
    WHERE P.PropertyCity = 'Chicago'
    AND L.ListingPrice > 450000
    GROUP BY P.PropertyID, P.PropertyAddress, L.ListingPrice)
SELECT * FROM CTE_PropertyRating420_693 WHERE Percentile BETWEEN 420 AND 693
GO

-- viii Listing of customers in Seattle who left reviews with an average between 2 and 3 stars
CREATE OR ALTER VIEW VW_SeattleCustomersAVGTwoStarReview AS
SELECT C.CustID, C.CustFirstName, C.CustLastName, AVG(R.RatingNumber) AS AverageRating
FROM tblCUSTOMER C
    JOIN tblVISIT V ON C.CustID = V.CustID
    JOIN tblREVIEW RW ON V.VisitID = RW.VisitID
    JOIN tblRATING R ON RW.RatingID = R.RatingID
WHERE C.CustCity = 'Seattle'
GROUP BY C.CustID, C.CustFirstName, C.CustLastName
HAVING AVG(R.RatingNumber) BETWEEN 2 AND 3
GO

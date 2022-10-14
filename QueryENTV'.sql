CREATE DATABASE [ENTV]
GO
USE [ENTV]
GO

CREATE TABLE MsCustomer(
	CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL,
	CustomerEmail VARCHAR(50) NOT NULL CHECK (CustomerEmail like '%@yahoo.com' or CustomerEmail like '%@gmail.com'),
	CustomerGender VARCHAR(10) NOT NULL CHECK (CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female'), -- blm pasti
	CustomerPhone VARCHAR(13) NOT NULL CHECK (CustomerPhone like '+62%'),
	CustomerAddress VARCHAR (50) NOT NULL,
	CustomerDOB DATE NOT NULL
)

CREATE TABLE MsTelevisionBrand(
	TelevisionBrandID CHAR(5) PRIMARY KEY CHECK (TelevisionBrandID LIKE 'TB[0-9][0-9][0-9]'),
	TelevisionBrandName VARCHAR(50) NOT NULL
)

CREATE TABLE MsTelevision(
	TelevisionID CHAR(5) PRIMARY KEY CHECK (TelevisionID LIKE 'TE[0-9][0-9][0-9]'),
	TelevisionName VARCHAR(50) NOT NULL,
	TelevisionPrice VARCHAR(30) CHECK (TelevisionPrice BETWEEN 1000000 AND 20000000), 
	TelevisionBrandID CHAR(5) FOREIGN KEY REFERENCES MsTelevisionBrand(TelevisionBrandID) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE SalesTrHeader(
	SalesID CHAR(5) PRIMARY KEY CHECK (SalesID LIKE 'SA[0-9][0-9][0-9]'),
	CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
	SalesTrDate DATE NOT NULL,
)

CREATE TABLE SalesTrDetail(
	SalesID CHAR(5) FOREIGN KEY REFERENCES SalesTrHeader(SalesID) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT NOT NULL,
	TelevisionID CHAR(5) FOREIGN KEY REFERENCES MsTelevision(TelevisionID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (SalesID, TelevisionID)
)

CREATE TABLE MsStaff(
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffEmail VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(10) NOT NULL CHECK (StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),-- blm pasti
	StaffPhone VARCHAR(50) NOT NULL CHECK (StaffPhone LIKE '+62%'),
	StaffAddress VARCHAR(50) NOT NULL,
	StaffSalary VARCHAR(30)  NOT NULL,
	StaffDOB DATE CHECK (YEAR(StaffDOB) <= 2000),
)

CREATE TABLE MsVendor(
	VendorID CHAR(5) PRIMARY KEY CHECK (VendorID LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(50) NOT NULL CHECK (LEN(VendorName) >= 3),
	VendorPhone VARCHAR(13) NOT NULL,
	VendorEmail VARCHAR(50) NOT NULL,
	VendorAddress VARCHAR(50) NOT NUll,
)

CREATE TABLE PurchaseTrHeader(
	PurchaseID CHAR(5) PRIMARY KEY CHECK (PurchaseID LIKE 'PE[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE,
	VendorID CHAR(5) FOREIGN KEY REFERENCES MsVendor(VendorID) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE PurchaseTrDetail(
	TelevisionID CHAR(5)  FOREIGN KEY REFERENCES MsTelevision(TelevisionID) ON UPDATE CASCADE ON DELETE CASCADE,
	PurchaseID CHAR(5) FOREIGN KEY REFERENCES PurchaseTrHeader(PurchaseID) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT NOT NULL,
	PRIMARY KEY (TelevisionID, PurchaseID)
)



INSERT INTO MsStaff VALUES
('ST001','Tommy Anton','tommy.Anton@yahoo.com','Male','+628132873459','Jalan penjara 128 Jakarta', 'Rp 2.500.000','1994-02-24'),
('ST002', 'Floyd Amin','floyd.Amin@gmail.com', 'Male','+62814579472','Jalan salak 26 Jakarta', 'Rp 2.700.000', '1990-09-05'),
('ST003', 'Emily', 'emily@yahoo.com','Female','+627857945321', 'Jalan Putri Atas 299 Jakarta', 'Rp 2.500.000', '1995-01-09'),
('ST004', 'Trex Kuncoro','Trex.kuncoro@yahoo.com','Male','+627845912374','Jalan Raya Grogol 198 Jakarta', 'Rp 2.500.000', '1998-02-14'),
('ST005', 'Robert', 'robert@gmail.com', 'Male','+624596378542', 'Jalan Pinus 1 Jakarta', 'Rp 2.500.000', '1991-11-28')
('ST006', 'Daxter Kim','daxter.kim@gmail.com', 'Male', '+627894128967','Jalan Kunir 55 Jakarta','Rp 2.700.000','1989-06-05'),
('ST007', 'Daley Waters','daley.waters@gmail.com', 'Male', '+629472579111','Jalan Cemara Raya 003 Jakarta','Rp 2.500.000','1993-08-06'),
('ST008', 'Duncan', 'duncan@gmail.com','Male', '+629741578966','Jalan Kina Barat 99 Jakarta','Rp 2.500.000','1995-04-03'),
('ST009', 'Violet', 'violet@gmail.com','Female', '+628794125712','Jalan Bibit 144','Rp2.500.000','1996-03-29'),
('ST010', 'Audrey Burgess','audrey.burgess@gmail.com','Female', '+627784125997','Jalan Kura-kura 98','Rp2.500.000','1995-11-12')
('ST0011','Deddy Cahyadi','Deddy.Cahyadi@yahoo.com','Male','+62814898459','Jalan Raya Sirnagalih 18 Jakarta', 'Rp 2.500.000','1988-05-14'),
('ST0012', 'Jaimin','Jaimin@gmail.com', 'Male','+6281459582','Jalan Mangga 21 Jakarta', 'Rp 2.500.000', '1985-04-30'),
('ST0013', 'Emi', 'emi55@yahoo.com','Female','+62785123371', 'Jalan Putri Bawah 9 Jakarta', 'Rp 2.500.000', '1995-09-15'),
('ST0014', 'Ronny Wen','Ronny23@yahoo.com' 'Male', '+627145792374','Jalan Raya Pringgodani 98 Jakarta', 'Rp 2.500.000', '1981-11-23'),
('ST0015', 'Harry Gunawan', 'Harry.Gunawan@gmail.com', 'Male','+627894512342', 'Jalan Pinus Timur 140 Jakarta', 'Rp 2.500.000', '1990-12-1')


INSERT INTO MsVendor VALUES
('VE001','ArieSamsung','+628771584964','Arie.Samsung@gmail.com','Jalan Benteng Atas 23 Jakarta'),
('VE002','BennyPolytron','+628258967589','Benny.Polytron@gmail.com','Jalan Jendral Soedirman 22 Jakarta'),
('VE003','CharlieLG','+628617597389','Charlie.LG@gmail.com','Jalan Jendral Ahmad Yani 255 Jakarta'),
('VE004','DannySonny','+628611257889','Danny.Sonny@gmail.com','Jalan Jendral Soedirman 22 Jakarta'),
('VE005','EliaSharp','+628628285589','Elia.Sharp@gmail.com','Jalan Semangka 2 Jakarta'),
('VE006','FannyPanasonic','+622258739589','Fanny.Panasonic@gmail.com','Jalan Persia 100 Jakarta'),
('VE007','GerryPhillips','+623917847589','Gerry.Phillips@gmail.com','Jalan Pahlawan 186 Jakarta'),
('VE008','HeriXiaomi','+62869225699','Heri.Xiaomi@gmail.com','Jalan Panglima 126 Jakarta'),
('VE009','IvanChanghong','+628668739589','Ivan.Changhong@gmail.com','Jalan Tebu 117 Jakarta'),
('VE010','JaniceRealme','+628669638759','Janice.Realme@gmail.com','Jalan Naga 223 Jakarta'),
('VE011','KimmyTCL','+628692278939','Kimmy.TCL@gmail.com','Jalan Bendera 242 Jakarta'),
('VE012','LeniCoocaa','+628628697319','Leni.Coocaa@gmail.com','Jalan Ir. Soekarno 29 Jakarta'),
('VE013','MimiToshiba','+628622965789','Mimi.Toshiba@gmail.com','Jalan Ki Hajara Dewantoro 1 Jakarta'),
('VE014','NeniAkari','+628622591139','Neni.Akari@gmail.com','Jalan Slamet Riyadi 229 Jakarta'),
('VE015','OniCHIQ','+628286337159','Oni.CHIQ@gmail.com','Jalan Dr Radjiman 221 Jakarta'),


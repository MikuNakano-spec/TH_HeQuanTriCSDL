use QLBanHang

CREATE TABLE Hangsx (
mahangsx NCHAR(10) PRIMARY KEY,
tenhang NVARCHAR(20),
diachi NVARCHAR(30),
sodt NVARCHAR(20),
email NVARCHAR(30)
);

CREATE TABLE Sanpham (
masp NCHAR(10) PRIMARY KEY,
mahangsx NCHAR(10) FOREIGN KEY REFERENCES Hangsx(mahangsx),
tensp NVARCHAR(20),
soluong INT,
mausac NVARCHAR(20),
giaban MONEY,
donvitinh NCHAR(10),
mota NVARCHAR(MAX)
);

CREATE TABLE Nhanvien (
manv NCHAR(10) PRIMARY KEY,
tennv NVARCHAR(20),
gioitinh NVARCHAR(10),
diachi NVARCHAR(30),
sodt NVARCHAR(20),
email NVARCHAR(30),
phong NVARCHAR(30)
);

CREATE TABLE Nhap (
sohdn NCHAR(10) PRIMARY KEY,
masp NCHAR(10) FOREIGN KEY REFERENCES Sanpham(masp),
manv NCHAR(10) FOREIGN KEY REFERENCES Nhanvien(manv),
ngaynhap DATETIME,
soluongN INT,
dongiaN MONEY
);

CREATE TABLE Xuat (
sohdx NCHAR(10) PRIMARY KEY,
masp NCHAR(10) FOREIGN KEY REFERENCES Sanpham(masp),
manv NCHAR(10) FOREIGN KEY REFERENCES Nhanvien(manv),
ngayxuat DATE,
soluongX INT
);
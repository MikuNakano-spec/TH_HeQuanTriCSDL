CREATE VIEW cau1_lab21 AS
SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, sx.Mahangsx, sx.Tenhang, sx.Diachi, sx.Sodt, sx.email, nv.Manv AS Ma,
nv.Tennv, nv.Gioitinh, nv.Diachi AS DChi, nv.Sodt AS SDT, nv.email AS EmailNV, 
nv.Phong, np.Ngaynhap, np.soluongN, np.dongiaN, x.Sohdx, x.Manv,x.Ngayxuat, x.soluongX
FROM Sanpham sp
JOIN Hangsx sx ON sp.mahangsx = sx.mahangsx
JOIN Nhap np ON sp.masp = np.masp
JOIN Xuat x ON sp.masp = x.masp
JOIN Nhanvien nv ON np.manv = nv.manv AND x.manv = nv.manv;



CREATE VIEW cau2_lab21 AS
SELECT TOP 100 * 
FROM Sanpham 
ORDER BY giaban DESC


CREATE VIEW cau3_lab21 AS
SELECT sp.masp AS MaSP,sp.tensp AS TenSP, sp.soluong AS SL, sp.mausac AS Mau, sp.giaban AS Gia, sp.donvitinh AS DVT, sp.mota AS MoTa,
sx.mahangsx AS MaHSX, sx.Tenhang AS TenHang, sx.Diachi AS DChi, sx.Sodt AS SDT, sx.email AS Email
FROM Sanpham sp
INNER JOIN Hangsx sx on sx.Mahangsx = sp.mahangsx
WHERE sx.Tenhang = 'Samsung'

CREATE VIEW cau4_lab21 AS
SELECT nv.Manv AS MaNV, nv.Tennv AS Ten, nv.Gioitinh AS GioiTinh, nv.Diachi AS DChi, nv.Sodt AS SDT, nv.email AS Email, nv.Phong AS Phong
FROM Nhanvien nv
WHERE nv.Gioitinh = 'nữ' AND nv.Phong = 'kế toán'

CREATE VIEW cau5_lab21 AS
SELECT TOP 100 n.sohdn, sp.masp, sp.tensp, hsx.tenhang, n.soluongN, n.dongiaN, n.soluongN * n.dongiaN as tiennhap, 
sp.mausac, sp.donvitinh, n.ngaynhap, nv.tennv, nv.phong
FROM Nhap n
INNER JOIN Sanpham sp ON n.masp = sp.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
INNER JOIN Nhanvien nv ON n.manv = nv.manv
ORDER BY tiennhap ASC


CREATE VIEW cau6_lab21 AS
SELECT TOP 100 x.Sohdx, sp.masp, sp.tensp, sx.tenhang, x.soluongX, sp.giaban, x.soluongX*giaban as tienxuat, 
sp.mausac, sp.donvitinh, x.ngayxuat, nv.tennv, nv.phong
FROM Xuat x
INNER JOIN Sanpham sp ON x.Masp = sp.masp
INNER JOIN Hangsx sx ON sp.mahangsx = sx.Mahangsx
INNER JOIN Nhanvien nv ON x.Manv = nv.Manv
WHERE MONTH(X.ngayxuat) = 10 AND YEAR(X.ngayxuat) = 2018
ORDER BY tienxuat DESC


CREATE VIEW cau7_lab21 AS
SELECT TOP 100 np.sohdn, sp.masp, sp.tensp, np.soluongN, np.dongiaN, np.ngaynhap,nv.tennv, nv.phong
FROM Nhap np
INNER JOIN Sanpham sp ON np.masp = sp.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
INNER JOIN Nhanvien nv ON np.manv = nv.manv
WHERE hsx.tenhang = 'Samsung' AND YEAR(np.ngaynhap) = 2017
ORDER BY np.sohdn ASC


CREATE VIEW cau8_lab21 AS
SELECT TOP 10* 
FROM Xuat
WHERE YEAR(ngayxuat)=2018
ORDER BY soluongX DESC



CREATE VIEW cau9_lab21 AS
SELECT TOP 10*
FROM Sanpham
ORDER BY giaban DESC


CREATE VIEW cau10_lab21 AS
SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, sx.Mahangsx, sx.Tenhang, sx.Diachi, sx.Sodt, sx.email
FROM Sanpham sp
INNER JOIN Hangsx sx on sx.mahangsx = sp.mahangsx
WHERE sx.tenhang ='Samsung' AND giaban between 100000 and 500000


CREATE VIEW cau11_lab21 AS
SELECT SUM(soluongN*dongiaN) as N'Tổng tiền đã nhập'
FROM Nhap np
INNER JOIN Sanpham sp on sp.masp = np.masp
INNER JOIN Hangsx sx on sx.mahangsx = sp.mahangsx
WHERE YEAR(np.ngaynhap) = 2020 and sx.tenhang = 'Samsung'


CREATE VIEW cau12_lab21 AS
SELECT SUM(soluongX*giaban) as N'Tổng tiền xuất'
FROM Xuat x
INNER JOIN Sanpham sp on sp.masp = x.masp
WHERE x.ngayxuat = '2018-09-02'


CREATE VIEW cau13_lab21 AS
SELECT TOP 1 tiennhap = soluongN*dongiaN, sohdn, ngaynhap
FROM Nhap np
WHERE YEAR(np.ngaynhap) = 2018
ORDER BY tiennhap DESC


CREATE VIEW cau14_lab21 AS
SELECT TOP 10  mahangsx, tensp, soluongN
FROM Sanpham sp
INNER JOIN Nhap np on sp.masp = np.masp
ORDER BY soluongN DESC


CREATE VIEW cau15_lab21 AS
SELECT sp.masp, sp.tensp
FROM Sanpham sp
INNER JOIN Hangsx sx on sx.mahangsx = sp.mahangsx
INNER JOIN Nhap np on np.masp = sp.masp
INNER JOIN Nhanvien nv on nv.manv = np.manv
WHERE sx.tenhang = 'Samsung' AND nv.manv = 'NV01'


CREATE VIEW cau16_lab21 AS
SELECT np.sohdn, sp.masp, np.soluongN, np.ngaynhap
FROM Nhap np
INNER JOIN Sanpham sp on sp.masp = np.masp
INNER JOIN Xuat x on x.masp = sp.masp
INNER JOIN Nhanvien nv on nv.manv = x.manv
WHERE sp.masp = 'SP05' AND nv.manv = 'NV01'


CREATE VIEW cau17_lab21 AS
SELECT nv.manv, nv.tennv
FROM Nhanvien nv
INNER JOIN Xuat x on x.manv = nv.manv
WHERE x.masp = 'SP02' AND x.ngayxuat = '2020-02-03'


CREATE VIEW cau18_lab22 AS
SELECT hsx.tenhang, COUNT(sp.masp) AS N'SoLoaiSP'
FROM Sanpham sp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
GROUP BY hsx.tenhang

CREATE VIEW cau19_lab22 AS
SELECT sp.masp, sp.tensp, SUM(np.soluongN * np.dongiaN) AS tongtien
FROM Nhap np
INNER JOIN Sanpham sp ON np.masp = sp.masp
WHERE YEAR(np.ngaynhap) = 2018
GROUP BY sp.masp, sp.tensp

CREATE VIEW cau20_lab22 AS
SELECT TOP 100 sp.masp, sp.tensp, SUM(x.soluongX) AS TongSoLuongXuat
FROM SanPham sp
INNER JOIN Xuat x ON sp.masp = x.masp
INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
WHERE YEAR(x.ngayxuat) = 2018 AND hsx.tenhang = 'Samsung'
GROUP BY sp.masp, sp.tensp
HAVING SUM(x.soluongX) > 10000
ORDER BY TongSoLuongXuat DESC

CREATE VIEW cau21_lab22 AS
SELECT phong, COUNT(*) AS soluong_nam
FROM NhanVien 
WHERE gioitinh = N'Nam'
GROUP BY phong

CREATE VIEW cau22_lab22 AS
SELECT hsx.tenhang, SUM(np.soluongN) AS tong_soluong_nhap
FROM Hangsx hsx JOIN Sanpham sp ON hsx.mahangsx = sp.mahangsx
		   JOIN Nhap np ON sp.masp = np.masp
WHERE YEAR(np.ngaynhap) = 2018
GROUP BY hsx.tenhang

CREATE VIEW cau23_lab22 AS
SELECT nv.manv, nv.tennv, SUM(soluongX * giaban) AS tong_tien_xuat
FROM Xuat x
JOIN SanPham sp ON x.masp = sp.masp
JOIN NhanVien nv ON x.manv = nv.manv
WHERE YEAR(ngayxuat) = 2018
GROUP BY nv.manv, nv.tennv

CREATE VIEW cau24_lab22 AS
SELECT manv, SUM(soluongN*dongiaN) as TongTienNhap
FROM Nhap 
WHERE MONTH(ngaynhap) = 8 AND YEAR(ngaynhap) = 2018
GROUP BY manv
HAVING SUM(soluongN*dongiaN) > 100000

CREATE VIEW cau25_lab22 AS
SELECT *
FROM SanPham
WHERE masp NOT IN (
  SELECT masp
  FROM Xuat
)

CREATE VIEW cau26_lab22 AS
SELECT sp.*
FROM SanPham sp
INNER JOIN Xuat x ON sp.masp = x.masp
WHERE YEAR(sp.mota) = 2018 AND YEAR(x.ngayxuat) = 2018

CREATE VIEW cau27_lab22 AS
SELECT nv.tennv 
FROM Nhap np JOIN Xuat x ON np.manv = x.manv
JOIN Nhanvien nv ON np.manv = nv.manv
GROUP BY nv.manv, NV.tennv

CREATE VIEW cau28_lab22 AS
SELECT tennv
FROM Nhap np JOIN Xuat x ON np.manv = x.manv JOIN Nhanvien nv ON np.manv = nv.manv
WHERE np.manv NOT IN (SELECT DISTINCT manv FROM Nhap)
AND x.manv NOT IN (SELECT DISTINCT manv FROM Xuat)
GROUP BY nv.manv, NV.tennv

SELECT * FROM cau28_lab22


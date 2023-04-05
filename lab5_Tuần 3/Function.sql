CREATE FUNCTION cau1 (@masp NCHAR(10))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @tenhang VARCHAR(50)

	SELECT @tenhang = hsx.tenhang 
	FROM Hangsx hsx 
	INNER JOIN SanPham sp ON sp.mahangsx = hsx.mahangsx
	WHERE sp.masp = @masp
	RETURN @tenhang
end;

CREATE FUNCTION cau2 (@x int, @y int)
RETURNS INT
AS 
BEGIN
	DECLARE @TongGiaTri int

	SELECT @TongGiaTri = SUM(np.soluongN * np.dongiaN)
	FROM Nhap np
	WHERE YEAR(np.ngaynhap) BETWEEN @x and @y
	RETURN @TongGiaTri
end;


CREATE FUNCTION cau3 (@x nvarchar(20), @y int)
RETURNS INT
AS
BEGIN
	DECLARE @Tong INT

	SELECT @Tong = SUM(np.soluongN) - SUM(x.soluongX)
	FROM Sanpham sp
	INNER JOIN Nhap np on sp.masp = np.masp
	INNER JOIN Xuat x ON sp.masp = x.masp
	WHERE sp.tensp = @x AND YEAR(x.ngayxuat) = @y
	RETURN @Tong
end;

ALTER FUNCTION cau4 (@x DATETIME, @y DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @tong INT

	SELECT @tong = SUM(np.soluongN * np.dongiaN)
	FROM Nhap np
	WHERE np.Ngaynhap BETWEEN @x AND @y
	RETURN @tong
end;

CREATE FUNCTION cau5 (@x INT, @A NVARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @tong INT

	SELECT @tong = SUM(x.soluongX * sp.giaban)
	FROM Xuat x
	INNER JOIN Sanpham sp ON sp.masp = x.Masp
	INNER JOIN Hangsx sx ON sx.Mahangsx = sp.mahangsx
	WHERE sx.Tenhang = @A AND YEAR(x.Ngayxuat) = @x
	RETURN @tong
end;


CREATE FUNCTION cau6 (@Phong nvarchar(30))
RETURNS INT
AS 
BEGIN
	DECLARE @tong INT

	SELECT @tong = COUNT(nv.Manv)
	FROM Nhanvien nv
	WHERE nv.Phong = @Phong
	RETURN @tong
end;


CREATE FUNCTION cau7 (@x nvarchar(20), @y DATE)
RETURNS INT
AS
BEGIN
	DECLARE @TongSanPhamXuat int

	SELECT @TongSanPhamXuat = SUM(soluongX)
	FROM Xuat x
	INNER JOIN Sanpham sp ON sp.masp = x.masp
	WHERE @x = sp.tensp and x.ngayxuat = @y
	RETURN @TongSanPhamXuat
end;


CREATE FUNCTION cau8 (@x NCHAR(10))
RETURNS nvarchar(20)
AS 
BEGIN
	DECLARE @so_dien_thoai nvarchar(20)
	SELECT @so_dien_thoai = nv.Sodt
	FROM Nhanvien nv
	INNER JOIN Xuat x ON x.manv = nv.manv
	INNER JOIN Sanpham sp ON sp.masp = x.masp
	WHERE @x = x.sohdx
	RETURN @so_dien_thoai
end;

SELECT dbo.cau8('X03') AS N'Số điện thoại'

CREATE FUNCTION cau9 (@x nvarchar(20), @y int)
RETURNS INT
AS
BEGIN
	DECLARE @Tong INT

	SELECT @Tong = SUM(np.soluongN) - SUM(x.soluongX)
	FROM Sanpham sp
	INNER JOIN Nhap np on sp.masp = np.masp
	INNER JOIN Xuat x ON sp.masp = x.masp
	WHERE sp.tensp = @x AND YEAR(x.ngayxuat) = @y
	RETURN @Tong
end;

SELECT dbo.cau9('F1 Plus',2019)

CREATE FUNCTION cau10 (@x nvarchar(20))
RETURNS INT
AS 
BEGIN
	DECLARE @TongSoLuongSanPham INT

	SELECT @TongSoLuongSanPham = SUM(sp.soluong)
	FROM Sanpham sp
	INNER JOIN Hangsx hsx ON hsx.mahangsx = sp.mahangsx
	WHERE @x = hsx.tenhang 
	RETURN @TongSoLuongSanPham
end;

select dbo.cau10('Samsung') AS N'Tổng số lượng sản phẩm'
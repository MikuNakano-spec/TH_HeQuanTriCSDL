CREATE FUNCTION cau1_lab6(@hang NVARCHAR(100))
RETURNS @ketqua TABLE (
    masp NCHAR(10),
    tensp NVARCHAR(20),
    soluong INT,
    mausac NVARCHAR(20),
    giaban FLOAT,
    donvitinh NVARCHAR(10),
    mota NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO @ketqua
    SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON hsx.mahangsx = sp.mahangsx
    WHERE hsx.tenhang = @hang;
    RETURN;
END;

SELECT * FROM cau1_lab6 ('Samsung')

CREATE FUNCTION cau2_lab6 (@x DATETIME, @y DATETIME)
RETURNS @ketqua TABLE (
	masp nchar(10), 
	tensp nvarchar(20), 
	soluong int, 
	mausac nvarchar(20),
	giaban float, 
	donvitinh nvarchar(10), 
	mota nvarchar(MAX), 
	mahangsx nchar(10),
	tenhang nvarchar(20), 
	diachi nvarchar(30), 
	sodt nvarchar(20), 
	email nvarchar(30)
)
AS 
BEGIN
	INSERT INTO @ketqua
	SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, sx.Mahangsx, sx.Tenhang,
	sx.Diachi, sx.Sodt, sx.email
	FROM Sanpham sp
	INNER JOIN Hangsx sx ON sx.Mahangsx = sp.mahangsx
	INNER JOIN Nhap n ON n.Masp = sp.masp
	WHERE n.Ngaynhap BETWEEN @x AND @y
RETURN
END;
SELECT * FROM cau2_lab6('2019-05-02 00:00:00.000','2020-07-04 00:00:00.000')

CREATE FUNCTION cau3_lab6 (@hang NVARCHAR(100), @op INT)
RETURNS @ketqua TABLE (
	masp nchar(10), 
	tensp nvarchar(20),
	soluong int,
	mausac nvarchar(20),
	giaban float, 
	donvitinh nvarchar(10), 
	mota nvarchar(MAX)
)
AS
BEGIN
	INSERT INTO @ketqua
	SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota
	FROM Sanpham sp
	INNER JOIN Hangsx hsx ON hsx.Mahangsx = sp.mahangsx
	WHERE @hang = hsx.Tenhang AND (@op = 0 AND sp.soluong = 0) OR (@op = 1 AND sp.soluong >0)
	RETURN 
END;
SELECT * FROM cau3_lab6('Samsung',1)

CREATE FUNCTION cau4_lab6 (@phong nvarchar(30))
RETURNS @ketqua TABLE (
	manv nchar(10),
	tennv nvarchar(20), 
	gioitinh nchar(10),
	diachi nvarchar(20), sodt nvarchar(30), email nvarchar(30), phong nvarchar(30)
)
AS
BEGIN
	INSERT INTO @ketqua
	SELECT *
	FROM Nhanvien 
	WHERE @phong = Phong
	RETURN
END;
SELECT * FROM cau4_lab6('K? toán')

CREATE FUNCTION cau5_lab6 (@dchi nvarchar(30))
RETURNS @ketqua TABLE (
	mahangsx nchar(30), 
	tenhang nvarchar(30), 
	diachi nvarchar(30), 
	sodt nvarchar(30), 
	email nvarchar(30)
)
AS 
BEGIN
	INSERT INTO @ketqua
	SELECT *
	FROM Hangsx
	WHERE Diachi LIKE @dchi
	RETURN
END;
SELECT * FROM cau5_lab6 ('China')

CREATE FUNCTION cau6_lab6 (@x INT, @y INT)
RETURNS @result TABLE (
    tensp NVARCHAR(50),
    tenhang NVARCHAR(50),
    ngayxuat DATE
)
AS
BEGIN
    INSERT INTO @result (tensp, tenhang, ngayxuat)
    SELECT sp.tensp, hsx.tenhang, x.ngayxuat
    FROM Xuat x
    INNER JOIN Sanpham sp ON x.masp = sp.masp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE YEAR(x.ngayxuat) BETWEEN @x AND @y
    
    RETURN;
END;


SELECT * FROM cau6_lab6 (2020, 2022);

ALTER FUNCTION cau7_lab6 (@HangSanXuat NCHAR(10), @LuaChon INT)
RETURNS @ketqua TABLE (
    masp NVARCHAR(10),
    tensp NVARCHAR(50),
    soluong INT,
    giaban DECIMAL(18, 2),
    donvitinh NVARCHAR(10)
)
AS
BEGIN
    INSERT INTO @ketqua
    SELECT CONVERT(NVARCHAR(10), sp.masp), sp.tensp, sp.soluong, sp.giaban, sp.donvitinh
    FROM Sanpham sp
    INNER JOIN (
        SELECT Sohdn, masp, soluongN as soluong, dongiaN as giaban
        FROM Nhap
        UNION ALL
        SELECT Sohdx, masp, soluongX as soluong, NULL as giaban
        FROM Xuat
    ) AS N ON sp.masp = N.masp
    INNER JOIN Hangsx ON sp.mahangsx = Hangsx.mahangsx
    WHERE Hangsx.tenhang= @HangSanXuat AND(
            (@LuaChon = 0 AND N.soluong > 0) 
            OR (@LuaChon = 1 AND (N.soluong IS NULL OR N.soluong >= 0))
        );
    RETURN;
END;

SELECT * FROM cau7_lab6('Samsung', 0);

CREATE FUNCTION cau8_lab6(@ngayNhap DATETIME)
RETURNS @ketqua TABLE (
    manv nchar(10),
    tennv NVARCHAR(50),
    ngaynhap DATE,
    tensp NVARCHAR(50),
    soluong INT,
    dongia DECIMAL(18, 2),
    thanhtien DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO @ketqua
    SELECT nv.manv, nv.tennv, n.ngaynhap, sp.tensp, n.soluongN, n.dongiaN, n.soluongN * n.dongiaN AS thanhtien
    FROM Nhap n
    INNER JOIN Sanpham sp ON n.masp = sp.masp
    INNER JOIN Nhanvien nv ON n.manv = nv.manv
    WHERE n.ngaynhap = @ngayNhap;
    
    RETURN;
END;

SELECT * FROM cau8_lab6('2020-07-04 00:00:00.000');

CREATE FUNCTION cau9_lab6(@x DECIMAL(18, 2), @y DECIMAL(18, 2), @z NVARCHAR(50))
RETURNS @ketqua TABLE (
    masp nchar(10),
    tensp NVARCHAR(50),
    giaban DECIMAL(18, 2),
    donvitinh NVARCHAR(10),
    tenhangsx NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @ketqua
    SELECT sp.masp, sp.tensp, sp.giaban, sp.donvitinh, hsx.tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE hsx.tenhang = @z AND sp.giaban BETWEEN @x AND @y;
    RETURN;
END;

SELECT * FROM cau9_lab6(0, 100000000, 'Samsung');

CREATE FUNCTION cau10_lab6()
RETURNS @ketqua TABLE (
    masp NCHAR(10),
    tensp NVARCHAR(50),
    hangsx NVARCHAR(50),
    soluong INT,
    giaban DECIMAL(18, 2),
    donvitinh NVARCHAR(10)
)
AS
BEGIN
    INSERT INTO @ketqua
    SELECT sp.masp, sp.tensp, hs.tenhang, sp.soluong, sp.giaban, sp.donvitinh
    FROM Sanpham sp
    INNER JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx;
    RETURN;
END;

SELECT * FROM cau10_lab6();
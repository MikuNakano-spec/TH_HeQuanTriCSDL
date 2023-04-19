CREATE PROCEDURE lab8_cau1
    @manv nchar(10), 
    @tennv nvarchar(20), 
    @gioitinh nvarchar(10), 
    @diachi nvarchar(30), 
    @sodt nvarchar(20), 
    @email nvarchar(30), 
    @phong nvarchar(30), 
    @flag int
AS
BEGIN
    IF (@flag = 0)
    BEGIN
        IF (@gioitinh <> 'Nam' AND @gioitinh <> 'Nữ')
			BEGIN
				SELECT 1 AS 'MaLoi' 
				RETURN
			END
        
        INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)
        
        SELECT 0 AS 'MaLoi' 
        RETURN
    END
    
    IF (@flag = 1) 
    BEGIN
        IF (@gioitinh <> 'Nam' AND @gioitinh <> 'Nữ')
			BEGIN
				SELECT 1 AS 'MaLoi'
				RETURN
			END
        
        UPDATE Nhanvien 
        SET tennv = @tennv, 
            gioitinh = @gioitinh, 
            diachi = @diachi, 
            sodt = @sodt, 
            email = @email,
            phong = @phong
        WHERE manv = @manv
        
        SELECT 0 AS 'MaLoi' 
        RETURN
    END
END

CREATE PROCEDURE lab8_cau2 
    @masp nchar(10), 
    @tenhang nvarchar(20), 
    @tensp nvarchar(20), 
    @soluong int, 
    @mausac nvarchar(20), 
    @giaban money, 
    @donvitinh nchar(10), 
    @mota nvarchar(MAX), 
    @flag int
AS
BEGIN
    IF (@flag = 0) 
    BEGIN
        IF NOT EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
			BEGIN
				SELECT 1 AS 'MaLoi'
				RETURN
			END
        
        IF (@soluong < 0)
			BEGIN
				SELECT 2 AS 'MaLoi' 
				RETURN
			END

        INSERT INTO Sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang), @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
        
        SELECT 0 AS 'MaLoi' 
        RETURN
    END
    
    IF (@flag = 1)
    BEGIN
        IF NOT EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
			BEGIN
				SELECT 1 AS 'MaLoi'
				RETURN
			END
        
        IF (@soluong < 0)
			BEGIN
				SELECT 2 AS 'MaLoi' 
				RETURN
			END
        
        UPDATE Sanpham 
        SET mahangsx = (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang), 
            tensp = @tensp, 
            soluong = @soluong, 
            mausac = @mausac, 
            giaban = @giaban, 
            donvitinh = @donvitinh, 
            mota = @mota
        WHERE masp = @masp
        
        SELECT 0 AS 'MaLoi' 
        RETURN
    END
END

CREATE PROCEDURE lab8_cau3
	@manv nchar(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
		BEGIN
			SELECT 1 AS 'MaLoi' 
			RETURN
		END

    BEGIN TRANSACTION 

    DELETE FROM Nhap WHERE manv = @manv

    DELETE FROM Xuat WHERE manv = @manv

    DELETE FROM Nhanvien WHERE manv = @manv

    IF @@ERROR <> 0 
		BEGIN
			ROLLBACK
			SELECT 1 AS 'MaLoi' 
			RETURN
		END

    COMMIT 
    SELECT 0 AS 'MaLoi' 
END

CREATE PROCEDURE lab8_cau4
	@masp nchar(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
		BEGIN
			SELECT 1 AS 'MaLoi' 
			RETURN
		END

    BEGIN TRANSACTION 

    DELETE FROM Nhap WHERE masp = @masp

    DELETE FROM Xuat WHERE masp = @masp

    DELETE FROM Sanpham WHERE masp = @masp

    IF @@ERROR <> 0 
    BEGIN
        ROLLBACK
        SELECT 1 AS 'MaLoi' 
        RETURN
    END

    COMMIT 
    SELECT 0 AS 'MaLoi' 
END

CREATE PROCEDURE lab8_cau5
	@mahangsx nchar(10),
	@tenhang nvarchar(20),
	@diachi nvarchar(30),
	@sodt nvarchar(20),
	@email nvarchar(30)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM Hangsx where tenhang = @tenhang)
		BEGIN
			SELECT 0 AS 'MaLoi'
			RETURN;
		END

	INSERT INTO Hangsx (mahangsx, tenhang, diachi, sodt, email)
	VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email);

	IF EXISTS (SELECT * FROM Hangsx where tenhang = @tenhang)
		BEGIN
			SELECT 1 AS 'MaLoi'
			RETURN
		END
END

CREATE PROCEDURE lab8_cau6
	@sohdn nchar(10),
    @masp nchar(10),
    @manv nchar(10),
    @ngaynhap datetime,
    @soluongN int,
    @dongiaN money
AS
BEGIN
	 IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
		 BEGIN
			SELECT 1 AS 'MaLoi'
			RETURN;
		END	

	 IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
		 BEGIN
			SELECT 2 AS 'MaLoi'
			RETURN;
		END	

	IF EXISTS (SELECT 1 FROM Nhap WHERE sohdn = @sohdn)
        UPDATE Nhap
        SET masp = @masp,
            manv = @manv,
            ngaynhap = @ngaynhap,
            soluongN = @soluongN,
            dongiaN = @dongiaN
        WHERE sohdn = @sohdn
    ELSE
        INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES (@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)

    SELECT 0 AS 'MaLoi'
	RETURN
END

CREATE PROCEDURE lab8_cau7
    @sohdx nchar(10), 
    @masp nchar(10), 
    @manv nchar(10), 
    @ngayxuat datetime, 
    @soluongX int
AS
BEGIN
    SET NOCOUNT ON;

    
    IF NOT EXISTS(SELECT * FROM Sanpham WHERE masp = @masp)
		BEGIN
			SELECT 1 AS 'MaLoi' 
			RETURN;
		END

    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
		BEGIN
			SELECT 2 AS 'MaLoi'
			RETURN;
		END
 
    IF @soluongX > (SELECT SoLuong FROM Sanpham WHERE masp = @masp)
		BEGIN
			SELECT 3 AS 'MaLoi'
			RETURN;
		END

    IF EXISTS(SELECT * FROM Xuat WHERE sohdx = @sohdx)
		BEGIN
      
			UPDATE Xuat 
			SET masp = @masp, 
				manv = @manv, 
				ngayxuat = @ngayxuat, 
				soluongX = @soluongX 
			WHERE sohdx = @sohdx;
		END
    ELSE
		BEGIN
      
			INSERT INTO Xuat (sohdx, masp, manv, ngayxuat, soluongX) 
			VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX);
		END

		SELECT 0 AS 'MaLoi'
		RETURN
END
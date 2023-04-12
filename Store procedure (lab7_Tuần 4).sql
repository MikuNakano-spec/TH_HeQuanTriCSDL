CREATE PROCEDURE cau1_lab7 (@ma nchar(10),
	@tenhang nvarchar(20),
	@diachi nvarchar(20),
	@sodt nvarchar(11),
	@email nvarchar(30))
AS
BEGIN
	if(exists(select * from Hangsx where tenhang = @tenhang))
		print N'Tên hàng đã tồn tại, mời nhập tên khác'
	else
		insert into Hangsx values (@ma,@tenhang,@diachi,@sodt,@email)
END

CREATE PROCEDURE cau2_lab7 (@ma nchar(10),
	@mahangxs nchar(10),
	@tensp nvarchar(20),
	@soluong int,
	@mausac nvarchar(20),
	@giaban money,
	@donvitinh nchar(10),
	@mota nvarchar(MAX))
AS
BEGIN
	if (exists(select * from Sanpham where masp = @ma))
		begin
			UPDATE Sanpham 
			SET tensp = @tensp, 
				mahangsx = @mahangxs,
				soluong = @soluong, 
				mausac = @mausac, 
				giaban = @giaban, 
				donvitinh = @donvitinh, 
				mota = @mota
			WHERE masp = @ma
			SELECT 'Đã cập nhật thông tin sản phẩm thành công' as ThongBao
		end
	else
		begin
			insert into Sanpham values (@ma, @tensp, @mahangxs, @soluong, @mausac, @giaban, @donvitinh, @mota)
			SELECT 'Đã thêm sản phẩm mới thành công' as ThongBao
		end
end

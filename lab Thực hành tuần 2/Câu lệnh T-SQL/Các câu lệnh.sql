use QLBanHang

/* Câu 1
	SELECT * FROM Hangsx
	SELECT * FROM Nhanvien
	SELECT * FROM Nhap
	SELECT * FROM Sanpham
	SELECT * FROM Xuat
*/

/* Câu 2
	SELECT * FROM Sanpham
	ORDER BY giaban DESC
*/

/* Câu 3
	SELECT *
	FROM Sanpham
	INNER JOIN Hangsx on Hangsx.Mahangsx = Sanpham.mahangsx
	WHERE Hangsx.Tenhang = 'Samsung'
*/

/* Câu 4
	SELECT * FROM Nhanvien
	WHERE Gioitinh = 'nữ' AND Phong = 'Kế toán'
*/

/* Câu 5
	SELECT np.sohdn, sp.masp,
	sp.tensp, hsx.tenhang,
	np.soluongN, np.dongiaN,
	np.soluongN * np.dongiaN as tiennhap,
	sp.mausac, sp.donvitinh, np.ngaynhap,
	nv.tennv, nv.phong
	FROM Nhap np
	INNER JOIN Sanpham sp ON np.masp = sp.masp
	INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
	INNER JOIN Nhanvien nv ON np.manv = nv.manv
	ORDER BY tiennhap ASC
*/

/* Câu 6
	SELECT x.sohdx, sp.masp, sp.tensp, hsx.tenhang, x.soluongX, 
	x.soluongX * sp.giaban as tienxuat, 
	sp.mausac, sp.donvitinh, x.ngayxuat,
	nv.tennv, nv.phong
	FROM Xuat x
	INNER JOIN Sanpham sp ON x.masp = sp.masp
	INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
	INNER JOIN Nhanvien nv ON x.manv = nv.manv
	WHERE MONTH(x.ngayxuat) = 10 AND YEAR(x.ngayxuat) = 2018
	ORDER BY x.sohdx ASC
*/
/* Câu 7
	SELECT np.sohdn, sp.masp, sp.tensp, np.soluongN, np.dongiaN, np.ngaynhap,
	nv.tennv, nv.phong
	FROM Nhap np
	INNER JOIN Sanpham sp ON np.masp = sp.masp
	INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
	INNER JOIN Nhanvien nv ON np.manv = nv.manv
	WHERE hsx.tenhang = 'Samsung' AND YEAR(np.ngaynhap) = 2017
	ORDER BY np.sohdn ASC
*/

/* Câu 8
	SELECT TOP 10* 
	FROM Xuat
	WHERE YEAR(ngayxuat)=2018
	ORDER BY soluongX DESC
*/

/* Câu 9
	SELECT TOP 10*
	FROM Sanpham
	ORDER BY giaban DESC
*/

/* Câu 10
	SELECT * 
	FROM Sanpham sp
	INNER JOIN Hangsx sx on sx.mahangsx = sp.mahangsx
	WHERE sx.tenhang ='Samsung' AND giaban between 100000 and 500000
*/

/* Câu 11
	SELECT SUM(soluongN*dongiaN) as N'Tổng tiền đã nhập'
	FROM Nhap np
	INNER JOIN Sanpham sp on sp.masp = np.masp
	INNER JOIN Hangsx sx on sx.mahangsx = sp.mahangsx
	WHERE YEAR(np.ngaynhap) = 2020 and sx.tenhang = 'Samsung'
*/ 

/* Câu 12
	SELECT SUM(soluongX*giaban) as N'Tổng tiền xuất'
	FROM Xuat x
	INNER JOIN Sanpham sp on sp.masp = x.masp
	WHERE x.ngayxuat = '2018-09-02'
*/ 

/* Câu 13
	SELECT TOP 1 tiennhap = soluongN*dongiaN, sohdn, ngaynhap
	FROM Nhap np
	WHERE YEAR(np.ngaynhap) = 2018
	ORDER BY tiennhap DESC
*/

/* Cấu 14
	SELECT TOP 10  mahangsx, tensp, soluongN
	FROM Sanpham sp
	INNER JOIN Nhap np on sp.masp = np.masp
	ORDER BY soluongN DESC
 */

/* Câu 15
	SELECT sp.masp, sp.tensp
	FROM Sanpham sp
	INNER JOIN Hangsx sx on sx.mahangsx = sp.mahangsx
	INNER JOIN Nhap np on np.masp = sp.masp
	INNER JOIN Nhanvien nv on nv.manv = np.manv
	WHERE sx.tenhang = 'Samsung' AND nv.manv = 'NV01'
*/ 

/* Câu 16
	SELECT np.sohdn, sp.masp, np.soluongN, np.ngaynhap
	FROM Nhap np
	INNER JOIN Sanpham sp on sp.masp = np.masp
	INNER JOIN Xuat x on x.masp = sp.masp
	INNER JOIN Nhanvien nv on nv.manv = x.manv
	WHERE sp.masp = 'SP05' AND nv.manv = 'NV01'
*/ 

/* Câu 17
	SELECT nv.manv, nv.tennv
	FROM Nhanvien nv
	INNER JOIN Xuat x on x.manv = nv.manv
	WHERE x.masp = 'SP02' AND x.ngayxuat = '2020-02-03'
*/
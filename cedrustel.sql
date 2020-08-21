CREATE DATABASE CedrusTel
--- 
CREATE TABLE UsersDetail( FullName nvarchar(200) NOT NULL,
						  Address1 nvarchar(200) NOT NULL,
						  PhoneNumber int NOT NULL,
						  Birthday datetime DEFAULT(getdate()))
--
INSERT INTO UsersDetail VALUES (N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 987654321, '1987-11-18')
INSERT INTO UsersDetail VALUES (N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 09873452, '1987-11-18')
INSERT INTO UsersDetail VALUES (N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 09832323, '1987-11-18')
INSERT INTO UsersDetail VALUES (N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 09434343, '1987-11-18')

---
INSERT INTO UsersDetail VALUES (N'Triệu Huy Hoàng', N'Mai Dịch, Cầu Giấy, Hà Nội', 0869941629, '2000-7-1')
INSERT INTO UsersDetail VALUES (N'Nguyễn Văn Cảnh', N'Mai Dịch, Cầu Giấy, Hà Nội', 0131231312, '2000-7-1')
INSERT INTO UsersDetail VALUES (N'Đẹp Văn Trai', N'Mai Dịch, Cầu Giấy, Hà Nội', 1231243242, '2000-1-1')
INSERT INTO UsersDetail VALUES (N'Đẹp Văn Trai', N'Mai Dịch, Cầu Giấy, Hà Nội', 1231243242, '2009-12-12')

----4. Viết các câu lênh truy vấn để

SELECT * FROM UsersDetail
SELECT PhoneNumber From UsersDetail

---5. Viết các câu lệnh truy vấn để lấy-- a Liệt kê danh sách người trong danh bạ theo thứ thự alphabet.SELECT * FROM UsersDetail ORDER BY FullName ASC--b) Liệt kê các số điện thoại của người có thên là Nguyễn Văn An.
SELECT PhoneNumber FROM UsersDetail WHERE FullName = N'Nguyễn Văn An'
--c) Liệt kê những người có ngày sinh là 12/12/09
SELECT * FROM UsersDetail where DAY(Birthday) = 12 and MONTH(Birthday) = 12 and YEAR(Birthday) = 2009

--6 a) Tìm số lượng số điện thoại của mỗi người trong danh bạ.
SELECT FullName, count(*) as 'Soluongdienthoai' from UsersDetail GROUP BY FullName
--b) Tìm tổng số người trong danh bạ sinh vào thang 12.
SELECT count(*) as 'Songuoi' from UsersDetail where MONTH(Birthday) = 12
--c) Hiển thị toàn bộ thông tin về người, của từng số điện 
SELECT * From UsersDetail
--d ) Hiển thị toàn bộ thông tin về người, của số điện thoại 123456789
SELECT * FROM UsersDetail WHERE PhoneNumber=123456789
--7
--a) Viết câu lệnh để thay đổi trường ngày sinh là trước ngày hiện tại.
ALTER TABLE UsersDetail ADD CONSTRAINT C_Birthday CHECK(Birthday < getdate())
--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.ALTER TABLE UsersDetail ADD CONSTRAINT PK_PHONE PRIMARY KEY(PhoneNumber)--c) Viết câu lệnh để thêm trường ngày bắt đầu liên lạc.ALTER TABLE UsersDetail ADD StartDate datetime

--8
--a 1. ◦ IX_HoTen : đặt chỉ mục cho cột Họ và tên
CREATE INDEX IX_HoTen ON UsersDetail(FullName)
--2.IX_SoDienThoai: đặt chỉ mục cho cột Số điện thoại

CREATE INDEX IX_SoDienThoai ON UsersDetail(PhoneNumber)

--b 
CREATE VIEW View_SoDienThoai AS SELECT FullName, PhoneNumber From UsersDetail

CREATE VIEW View_SinhNhat AS SELECT FullName,Birthday,PhoneNumber FROM UsersDetail WHERE MONTH(Birthday) = MONTH(getdate())

CREATE PROCEDURE SP_Them_DanhBa

@FullName nvarchar(255),
@Address1 nvarchar(200),
@PhoneNumber int,
@Birthday datetime,
@StartDate datetime
AS
BEGIN

	INSERT INTO UsersDetail VALUES(@FullName,@Address1,@PhoneNumber,@Birthday,@StartDate)
END
GO

CREATE PROCEDURE SP_Tim_DanhBa

@FullName nvarchar(255)
AS
BEGIN

	SELECT * FROM UsersDetail where FullName like @FullName
END
GO
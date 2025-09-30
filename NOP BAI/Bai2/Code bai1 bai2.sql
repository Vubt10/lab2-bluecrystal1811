-- ================================
-- BÀI 1: TẠO CSDL QLDA
-- ================================

-- 1. Tạo database
CREATE DATABASE QLDA;
GO
USE QLDA;
GO

-- 2. Tạo bảng PHONGBAN
CREATE TABLE PHONGBAN (
    TENPHG NVARCHAR(50),
    MAPHG INT PRIMARY KEY,
    TRPHG CHAR(3),
    NG_NHANCHUC DATE
);

-- 3. Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    HONV NVARCHAR(20),
    TENLOT NVARCHAR(20),
    TENNV NVARCHAR(20),
    MANV CHAR(3) PRIMARY KEY,
    NGSINH DATE,
    DCHI NVARCHAR(100),
    PHAI NVARCHAR(3),
    LUONG DECIMAL(10,2),
    MA_NQL CHAR(3) NULL,
    PHG INT REFERENCES PHONGBAN(MAPHG)
);

-- 4. Tạo bảng DEAN
CREATE TABLE DEAN (
    TENDA NVARCHAR(100),
    MADA INT PRIMARY KEY,
    DDIEM_DA NVARCHAR(50),
    PHONG INT REFERENCES PHONGBAN(MAPHG)
);

-- 5. Tạo bảng THANNHAN
CREATE TABLE THANNHAN (
    MA_NVIEN CHAR(3),
    TENTN NVARCHAR(50),
    PHAI NVARCHAR(3),
    NGSINH DATE,
    QUANHE NVARCHAR(20),
    PRIMARY KEY (MA_NVIEN, TENTN),
    FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)
);

-- 6. Tạo bảng DIADIEM_PHG
CREATE TABLE DIADIEM_PHG (
    MAPHG INT REFERENCES PHONGBAN(MAPHG),
    DIADIEM NVARCHAR(50),
    PRIMARY KEY (MAPHG, DIADIEM)
);

-- 7. Tạo bảng CONGVIEC
CREATE TABLE CONGVIEC (
    MADA INT REFERENCES DEAN(MADA),
    STT INT,
    TEN_CONG_VIEC NVARCHAR(100),
    PRIMARY KEY (MADA, STT)
);

-- 8. Tạo bảng PHANCONG
CREATE TABLE PHANCONG (
    MA_NVIEN CHAR(3) REFERENCES NHANVIEN(MANV),
    MADA INT REFERENCES DEAN(MADA),
    STT INT,
    THOIGIAN DECIMAL(5,1),
    PRIMARY KEY (MA_NVIEN, MADA, STT),
    FOREIGN KEY (MADA, STT) REFERENCES CONGVIEC(MADA, STT)
);

-- ================================
-- CHÈN DỮ LIỆU MẪU
-- ================================

-- Phòng ban
INSERT INTO PHONGBAN VALUES
(N'Nghiên cứu', 5, '005', '1978-05-22'),
(N'Điều hành', 4, '008', '1985-01-01'),
(N'Quản lý',   1, '006', '1971-06-19');

-- Nhân viên
INSERT INTO NHANVIEN VALUES
(N'Đinh', N'Bá',    N'Tiên',  '009', '1960-02-11', N'119 Cống Quỳnh, Tp HCM', N'Nam', 30000, '005', 5),
(N'Nguyễn', N'Thanh', N'Tùng', '005', '1962-08-20', N'222 Nguyễn Văn Cừ, Tp HCM', N'Nam', 40000, '006', 5),
(N'Bùi', N'Ngọc', N'Hằng', '007', '1954-03-11', N'332 Nguyễn Thái Học, Tp HCM', N'Nam', 25000, '001', 4),
(N'Lê', N'Quỳnh', N'Như',  '001', '1967-02-01', N'291 Hồ Văn Huê, Tp HCM', N'Nữ', 43000, '006', 4),
(N'Nguyễn', N'Mạnh', N'Hùng','004', '1967-03-04', N'95 Bà Rịa, Vũng Tàu', N'Nam', 38000, '005', 5),
(N'Trần', N'Thanh', N'Tâm',  '003', '1957-05-04', N'34 Mai Thị Lự, Tp HCM', N'Nam', 25000, '005', 5),
(N'Trần', N'Hồng', N'Quang','008', '1967-09-01', N'80 Lê Hồng Phong, Tp HCM', N'Nam', 25000, '001', 4),
(N'Phạm', N'Văn', N'Vinh',  '006', '1965-01-01', N'45 Trưng Vương, Hà Nội', N'Nữ', 55000, NULL, 1);

-- Đề án
INSERT INTO DEAN VALUES
(N'Sản phẩm X', 1, N'Vũng Tàu', 5),
(N'Sản phẩm Y', 2, N'Nha Trang', 5),
(N'Sản phẩm Z', 3, N'TP HCM', 5),
(N'Tin học hoá', 10, N'Hà Nội', 4),
(N'Cáp quang', 20, N'TP HCM', 1),
(N'Đào tạo', 30, N'Hà Nội', 4);

-- Thân nhân
INSERT INTO THANNHAN VALUES
('005', N'Trinh', N'Nữ', '1976-04-05', N'Con gái'),
('005', N'Khang', N'Nam', '1973-10-25', N'Con trai'),
('005', N'Phương', N'Nữ', '1948-05-03', N'Vợ chồng'),
('001', N'Minh', N'Nam', '1932-02-29', N'Vợ chồng'),
('009', N'Tiến', N'Nam', '1978-01-01', N'Con trai'),
('009', N'Châu', N'Nữ', '1978-12-30', N'Con gái'),
('009', N'Phương', N'Nữ', '1957-05-05', N'Vợ chồng');

-- Địa điểm phòng ban
INSERT INTO DIADIEM_PHG VALUES
(1, N'TP HCM'),
(4, N'Hà Nội'),
(5, N'TAU'),
(5, N'NHA TRANG'),
(5, N'TP HCM');

-- Công việc
INSERT INTO CONGVIEC VALUES
(1,1,N'Thiết kế sản phẩm X'),
(1,2,N'Thử nghiệm sản phẩm X'),
(2,1,N'Sản xuất sản phẩm Y'),
(2,2,N'Quảng cáo sản phẩm Y'),
(3,1,N'Khuyến mãi sản phẩm Z'),
(10,1,N'Tin học hoá phòng nhân sự'),
(10,2,N'Tin học hoá phòng kinh doanh'),
(20,1,N'Lắp đặt cáp quang'),
(30,1,N'Đào tạo nhân viên Marketing'),
(30,2,N'Đào tạo chuyên viên thiết kế');

-- Phân công
INSERT INTO PHANCONG VALUES
('009',1,1,32),
('009',2,2,8),
('004',3,1,40),
('003',1,2,20.0),
('003',2,1,20.0),
('008',10,1,35),
('008',30,2,5),
('001',30,1,20),
('001',20,1,15),
('006',20,1,30),
('005',3,1,10),
('005',10,2,10),
('005',20,1,10),
('007',30,2,30),
('007',10,2,10);

--  Tính diện tích và chu vi hình chữ nhật
USE QLDA;
GO

DECLARE @dai FLOAT = 7.5, @rong FLOAT = 4.2;
DECLARE @dientich FLOAT, @chuvi FLOAT;

SET @dientich = @dai * @rong;
SET @chuvi = 2 * (@dai + @rong);

SELECT @dai AS ChieuDai, @rong AS ChieuRong, @dientich AS DienTich, @chuvi AS ChuVi;
GO

-- . Nhân viên có lương cao nhất
USE QLDA;
GO

SELECT TOP 1 
    MANV,
    CONCAT(COALESCE(HONV,''), ' ', COALESCE(TENLOT,''), ' ', COALESCE(TENNV,'')) AS HoTen,
    LUONG
FROM NHANVIEN
ORDER BY LUONG DESC;
GO



-- . Nhân viên có lương trên mức trung bình của phòng “Nghiên cứu”
USE QLDA;
GO

DECLARE @deptName NVARCHAR(50) = N'Nghiên cứu';
DECLARE @maphg INT;
DECLARE @avgLuong DECIMAL(18,2);

-- Lấy id phòng
SELECT @maphg = MAPHG FROM PHONGBAN WHERE TENPHG = @deptName;

IF @maphg IS NULL
BEGIN
    PRINT N'Không tìm thấy phòng: ' + @deptName;
END
ELSE
BEGIN
    -- Lấy mức lương trung bình (chú ý AVG trả về NULL nếu không có nhân viên)
    SELECT @avgLuong = AVG(CONVERT(DECIMAL(18,2), LUONG))
    FROM NHANVIEN
    WHERE PHG = @maphg;

    IF @avgLuong IS NULL
    BEGIN
        PRINT N'Phòng ' + @deptName + N' chưa có nhân viên.';
    END
    ELSE
    BEGIN
        PRINT N'Mức lương trung bình của phòng ' + @deptName + N' = ' + CONVERT(NVARCHAR(20), @avgLuong);

        SELECT 
            MANV,
            CONCAT(COALESCE(HONV,''), ' ', COALESCE(TENLOT,''), ' ', COALESCE(TENNV,'')) AS HoTen,
            LUONG
        FROM NHANVIEN
        WHERE PHG = @maphg
          AND LUONG > @avgLuong;
    END
END
GO

-- . Các phòng ban có lương TB > 30,000
USE QLDA;
GO

DECLARE @threshold DECIMAL(18,2) = 30000.00;

SELECT 
    pb.TENPHG,
    COUNT(nv.MANV) AS SoLuongNV,
    AVG(nv.LUONG) AS LuongTB
FROM PHONGBAN pb
JOIN NHANVIEN nv ON pb.MAPHG = nv.PHG
GROUP BY pb.TENPHG
HAVING AVG(nv.LUONG) > @threshold;
GO



-- . Mỗi phòng ban và số lượng đề án chủ trì
USE QLDA;
GO

SELECT 
    pb.TENPHG,
    COUNT(da.MADA) AS SoDeAnChuTri
FROM PHONGBAN pb
LEFT JOIN DEAN da ON pb.MAPHG = da.PHONG
GROUP BY pb.TENPHG;
GO

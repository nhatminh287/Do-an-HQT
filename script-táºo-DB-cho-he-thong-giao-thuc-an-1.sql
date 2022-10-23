-- Script tạo DB cho hệ thống giao thức ăn
use master
go

drop database if exists ESHOPPING
go

create database ESHOPPING
go

use ESHOPPING
go

create table QuanTri
(
	AdminID char(10),
	HoTen nvarchar(50),
	Email varchar(50),
	SoDienThoai char(10),
	Username varchar(50),

	constraint pkQuanTri primary key(AdminID)
)
go

create table NhanVien
(
	NhanVienID char(10),
	HoTen nvarchar(50),
	Email varchar(50),
	SoDienThoai char(10),
	Username varchar(50),

	constraint pkNhanVien primary key(NhanVienID)
)
go

create table KhachHang
(
	KhachHangID char(10),
	HoTen nvarchar(50),
	SoDienThoai char(10),
	DiaChi Text,
	Email varchar(50),
	TKNganHangID char(10),
	Username varchar(50),

	constraint pkKhachHang primary key(KhachHangID)
)
go

create table DoiTac
(
	DoiTacID char(10),
	Email varchar(50),
	NguoiDaiDien nvarchar(50),
	SoLuongQuan int,
	SoLuongDonDuKien int,
	DiaChiKinhDoanh text,
	SoDienThoai char(10),
	TrangThai nvarchar(20),
	Username varchar(50),

	constraint pkDoiTac primary key(DoiTacID)
)
go

create table TaiXe
(
	TaiXeID char(10),
	HoTen nvarchar(50),
	CMND varchar(20),
	SoDienThoai char(10),
	DiaChi text,
	BienSoXe varchar(10),
	KhuVucHoatDong text,
	Email varchar(50),
	TKNganHangID char(10),
	Username varchar(50),

	constraint pkTaiXe primary key(TaiXeID)
)
go

create table TaiKhoan
(
	Username varchar(50),
	MatKhau text,
	TrangThai nvarchar(20),

	constraint pkTaiKhoan primary key(Username)
)
go

create table TaiKhoanNganHang
(
	TKNganHangID char(10),
	SoTaiKhoan varchar(20),
	NganHang nvarchar(20),
	ChiNhanh text,

	constraint pkTaiKhoanNganHang primary key(TKNganHangID)
)
go

create table HopDong
(
	HopDongID char(10),
	MaSoThue varchar(10),
	NguoiDaiDien nvarchar(50),
	SoChiNhanh int,
	TKNganHangID char(10),
	NgayKichHoat date,
	NgayHetHan date,
	TrangThai nvarchar(20),
	NhanVienLap char(10),
	DoiTacID char(10),

	constraint pkHopDong primary key(HopDongID)
)
go

create table Quan
(
	QuanID char(10),
	TenQuan nvarchar(50),
	LoaiAmThuc nvarchar(20),
	NgayDangKi date,
	TinhTrang nvarchar(20),
	DoiTacID char(10),

	constraint pkQuan primary key(QuanID)
)
go

create table ChiNhanh
(
	ChiNhanhID char(10),
	TenChiNhanh nvarchar(50),
	DiaChi text,
	MoCua time,
	DongCua time,
	QuanID char(10),
	HopDongID char(10),
	ThucDonID char(10),
	TinhTrang nvarchar(20),

	constraint pkChiNhanh primary key(ChiNhanhID)
)
go

create table ThucDon
(
	ThucDonID char(10),
	TenThucDon nvarchar(50),

	constraint pkThucDon primary key(ThucDonID)
)
go

create table Mon
(
	MonID char(10),
	TenMon nvarchar(50),
	MieuTaMon text,
	Gia int,
	TinhTrang nvarchar(20),
	ThucDonID char(10),

	constraint pkMon primary key(MonID)
)
go

create table DonHang
(
	DonHangID char(10),
	NguoiNhan nvarchar(50),
	SoDienThoai char(10),
	DiaChiNhanHang text,
	NgayDatHang date,
	PhiSanPham int,
	PhiVanChuyen int,
	TrangThai nvarchar(20),
	KhachHangID char(10),
	TaiXeID char(10),

	constraint pkDonHang primary key(DonHangID)
)
go

create table ChiTietDonHang
(
	MonID char(10),
	DonHangID char(10),
	SoLuong int,
	GiaBan int,
	GhiChuTuyChon text,
	DanhGia nvarchar(20),

	constraint pkChiTietDonHang primary key(MonID, DonHangID)
)
go

alter table QuanTri add
constraint fkQuanTri_Username foreign key(Username) references TaiKhoan(Username)
go

alter table NhanVien add
constraint fkNhanVien_Username foreign key(Username) references TaiKhoan(Username)
go

alter table KhachHang add
constraint fkKhachHang_Username foreign key(Username) references TaiKhoan(Username),
constraint fkKhachHang_TKNganHangID foreign key(TKNganHangID) references TaiKhoanNganHang(TKNganHangID)
go

alter table DoiTac add
constraint fkDoiTac_Username foreign key(Username) references TaiKhoan(Username)
go

alter table TaiXe add
constraint fkTaiXe_Username foreign key(Username) references TaiKhoan(Username),
constraint fkTaiXe_TKNganHangID foreign key(TKNganHangID) references TaiKhoanNganHang(TKNganHangID)
go

alter table HopDong add
constraint fkHopDong_TKNganHangID foreign key(TKNganHangID) references TaiKhoanNganHang(TKNganHangID),
constraint fkHopDong_NhanVienLap foreign key(NhanVienLap) references NhanVien(NhanVienID),
constraint fkHopDong_DoiTacID foreign key(DoiTacID) references DoiTac(DoiTacID)
go

alter table Quan add
constraint fkQuan_DoiTacID foreign key(DoiTacID) references DoiTac(DoiTacID)
go

alter table ChiNhanh add
constraint fkChiNhanh_HopDongID foreign key(HopDongID) references HopDong(HopDongID),
constraint fkChiNhanh_ThucDonID foreign key(ThucDonID) references ThucDon(ThucDonID)
go

alter table Mon add
constraint fkMon_ThucDonID foreign key(ThucDonID) references ThucDon(ThucDonID)
go

alter table DonHang add
constraint fkDonHang_KhachHangID foreign key(KhachHangID) references KhachHang(KhachHangID),
constraint fkDonHang_TaiXeID foreign key(TaiXeID) references TaiXe(TaiXeID)
go

alter table ChiTietDonHang add
constraint fkChiTietDonHang_MonID foreign key(MonID) references Mon(MonID),
constraint fkChiTietDonHang_DonHangID foreign key(DonHangID) references DonHang(DonHangID)
go

--Nhập dữ liệu cho DB

select * from chinhanh--
select * from ChiTietDonHang
select * from DoiTac--
select * from DonHang--
select * from HopDong--
select * from KhachHang--
select * from Mon--
select * from NhanVien--
select * from Quan--
select * from QuanTri--
select * from TaiKhoan--
select * from TaiKhoanNganHang--
select * from TaiXe--
select * from ThucDon--

INSERT INTO TaiKhoan
values('nv3','123',null), 
		('nv2','123',null),
		('tk1','123',null),
		('admin3','123',null),
		('admin2','123',null),
		('admin1','123',null),
		('taixe01','123',null),
		('doitac01','123',null), 
		('khachhang01','123',null)

INSERT INTO TaiKhoanNganHang
values('7890','094278904','ocb',N'Bình Thạnh'), 
		('4567','094235454','ocb',N'Bình Thạnh'), 
		('1234','098765454','acb','pham van dong') 


INSERT INTO QuanTri
values('ad03',N'Lê Minh Phú','lmp@gmail.com','0123452289','admin3'), 
		('ad02',N'Lê Minh Tâm','lmt@gmail.com','0123452289','admin2'), 
	('ad01',N'Lê Minh Hoàng','lmh@gmail.com','0123452289','admin1') 

INSERT INTO NhanVien
values('nv03',N'Lê Minh Đức','lmd@gmail.com','0123456789','nv3'), 
('nv02',N'Lê Minh Đức','lmd@gmail.com','0123456789','nv2'), 
('nv01',N'Lê Minh Đức','lmd@gmail.com','0123456789','tk1') 

INSERT INTO KhachHang
values('kh01',N'Nguyễn văn','0123456789',N'123 cmt8 Tân Bình Hồ Chí Minh','nv@gmail.com','1234','khachhang01') 

INSERT INTO DoiTac
values('dt01','nvb@gmail.com',N'Nguyễn văn b',3,4,N'345 Nguyễn Thị minh Khai quận 1 HCM','123456778',null,'doitac01') 

INSERT INTO HopDong
values('hopdong01','11111',N'Nguyễn văn b',3,'7890','20221010','20241010',null,'nv01','dt01')

INSERT INTO Quan
values('quan01',N'Tam Mao',N'Ăn Vặt','20221022',N'Còn','dt01')

insert into ThucDon
values('thucdon01',N'bánh Tráng')

INSERT INTO TaiXe
values('tx01',N'Dương Quá','123123123','1233455678',N'10 Bắc Hải Quận 10 HCM','123321',N'Quận 10','dq@gmail.com','4567','taixe01')

insert into Mon
values('mon01',N'Bánh tráng nướng',N'abc',10000,N'Còn','thucdon01')

insert into ThucDon
values('thucdon01',N'bánh Tráng')

insert into ChiNhanh
values('chinhanh01',N'Tam Mao',N'333 Cao Thắng Quận 10 HCM','07:00','20:00','quan01','hopdong01','thucdon01',null)

insert into DonHang
values('dohang01','abc','0987654321','123 nguyễn văn cừ quận 5 hcm','20221022',10000,15000,'dang van chuyen','kh01','tx01')


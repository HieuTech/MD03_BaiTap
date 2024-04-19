create database QuanLyBanHang2;
use QuanLyBanHang2;

create table KhachHang
(
    MaKH     varchar(4) PRIMARY KEY,
    TenKH    varchar(30) not null,
    DiaChi   varchar(50),
    NgaySinh datetime,
    SoDT     varchar(15) unique
);

insert into KhachHang (MaKH, TenKH, DiaChi, NgaySinh, SoDT)
VALUES ('KH1', 'John Smith', '123 Main Street, City, Country', '1990-01-01', '123456789'),
       ('KH2', 'Alice Johnson', '456 Elm Street, City, Country', '1995-05-15', '987654321'),
       ('KH3', 'Bob Brown', '789 Oak Street, City, Country', '1988-08-08', '456123789'),
       ('KH4', 'Jane Doe', '321 Pine Street, City, Country', '1985-12-25', '789456123'),
       ('KH5', 'Mary White', '456 Maple Street, City, Country', '1992-03-10', '654789321');

create table NhanVien
(
    MaNV       varchar(4) PRIMARY KEY,
    HoTen      varchar(30) not null,
    GioiTinh   bit         not null,
    DiaChi     varchar(50) not null,
    NgaySinh   datetime    not null,
    DienThoai  varchar(15),
    Email      text,
    NoiSinh    varchar(20) not null,
    NgayVaoLam datetime,
    MaNQL      varchar(4)

);
INSERT INTO NhanVien (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
VALUES ('1', 'John Doe', 1, '123 Main Street, City, Country', '1990-01-01', '123456789', 'john.doe@example.com', 'City',
        '2020-01-01', NULL),
       ('2', 'Jane Smith', 0, '456 Elm Street, City, Country', '1995-05-15', '987654321', 'jane.smith@example.com',
        'City', '2019-06-01', '1'),
       ('3', 'Alice Johnson', 0, '789 Oak Street, City, Country', '1988-08-08', '456123789',
        'alice.johnson@example.com', 'City', '2021-03-15', '1'),
       ('4', 'Bob Brown', 1, '321 Pine Street, City, Country', '1985-12-25', '789456123', 'bob.brown@example.com',
        'City', '2022-02-20', '2');
create table NhaCungCap
(
    MaNCC     varchar(5) PRIMARY KEY,
    TenNCC    varchar(50) not null,
    DiaChi    varchar(50) not null,
    DienThoai varchar(15) not null,
    Email     varchar(30) not null,
    Website   varchar(30)
);

insert into NhaCungCap (MaNCC, TenNCC, DiaChi, DienThoai, Email, Website)
values ('1', 'ABC Company', '123 Main Street, City, Country', '123456789', 'abc@example.com', 'www.abc.com'),
       ('2', 'XYZ Corporation', '456 Elm Street, City, Country', '987654321', 'xyz@example.com', 'www.xyz.com'),
       ('3', 'LMN Enterprises', '789 Oak Street, City, Country', '456123789', 'lmn@example.com', NULL),
       ('4', 'PQR Ltd.', '321 Pine Street, City, Country', '789456123', 'pqr@example.com', 'www.pqr.com');


create table LoaiSP
(
    MaLoaiSP  varchar(4) PRIMARY KEY,
    TenloaiSP varchar(30)  not null,
    GhiChu    varchar(100) not null
);

insert into LoaiSP (MaLoaiSP, TenloaiSP, GhiChu)
values ('1', 'demo', 'ghi chu'),
       ('2', 'demo', 'ghi chu'),
       ('3', 'demo', 'ghi chu');

create table SanPham
(
    MaSP      varchar(4) PRIMARY KEY,
    MaloaiSP  varchar(4)  not null,
    TenSP     varchar(4)  not null,
    DonViTinh varchar(10) not null,
    GhiChu    varchar(100)
);

insert into SanPham (MaSP, MaloaiSP, TenSP, DonViTinh, GhiChu)
values ('1', '1', 'Java', '10', 'note'),
       ('2', '2', 'Java', '10', 'note'),
       ('3', '3', 'Java', '10', 'note'),
       ('4', '3', 'Java', '10', 'note');

update SanPham
set DonViTinh = 'chai'
where MaSP in ('2', '3');


alter table SanPham
    add CONSTRAINT fk_MaSP_MaloaiSP FOREIGN KEY (MaloaiSP) REFERENCES LoaiSP (MaLoaiSP);

create table PhieuNhap
(
    SoPN     varchar(5) PRIMARY KEY,
    MaNV     varchar(4) not null,
    MaNCC    varchar(5) not null,
    NgayNhap datetime   not null DEFAULT CURRENT_DATE,
    GhiChu   varchar(100)

);

insert into PhieuNhap (SoPN, MaNV, MaNCC, NgayNhap, GhiChu)
VALUES ('1', '3', '1', '2024-12-12', 'notes'),
       ('2', '3', '1', '2024-12-12', 'database'),
       ('3', '3', '1', '2024-12-12', 'sql'),
       ('4', '2', '2', '2024-12-24', 'java');
update PhieuNhap
set NgayNhap = '2024-05-20'
where SoPN = '1';
update PhieuNhap
set NgayNhap = '2024-08-22'
where SoPN = '2';

alter table PhieuNhap
    add CONSTRAINT fk_SoPN_MaNV FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);
alter table PhieuNhap
    add CONSTRAINT fk_SoPN_MaNCC FOREIGN KEY (MaNCC)
        REFERENCES NhaCungCap (MaNCC);

create table CTPhieuNhap
(
    MaSp    varchar(4) not null,
    SoPN    varchar(5) not null,
    Soluong smallint   not null DEFAULT 0,
    GiaNhap REAL       not null check (GiaNhap >= 0)
);
insert into CTPhieuNhap (MaSp, SoPN, Soluong, GiaNhap)
VALUES ('2', '1', 2, 30000),
       ('3', '2', 4, 60000),
       ('4', '3', 6, 20000);


alter table CTPhieuNhap
    add CONSTRAINT fk_MaSP_CTPhieuNhap FOREIGN KEY (MaSp)
        REFERENCES SanPham (MaSP);

alter table CTPhieuNhap
    add CONSTRAINT fk_SoPN_CTPhieuNhap FOREIGN KEY (SoPN)
        REFERENCES PhieuNhap (SoPN);

create table PhieuXuat
(
    SoPX    varchar(5) PRIMARY KEY,
    MaNV    varchar(4) not null,
    MaKH    varchar(4) not null,
    NgayBan datetime   not null DEFAULT CURRENT_DATE(),
    GhiChu  text                default null
);

insert into PhieuXuat (SoPX, MaNV, MaKH, NgayBan, GhiChu)
VALUES ('1', '4', 'KH1', '2024-04-05', 'java'),
       ('2', '2', 'KH2', '2024-08-05', 'test'),
       ('3', '3', 'KH3', '2024-03-05', 'demo'),
       ('4', '2', 'KH4', '2024-01-09', 'demo');



alter table PhieuXuat
    add CONSTRAINT fk_SoPX_MaNV FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV);
alter table PhieuXuat
    add CONSTRAINT fk_SoPX_MaKH FOREIGN KEY (MaKH) REFERENCES
        KhachHang (MaKH);

create table CTPhieuXuat
(
    SoPX    varchar(5) not null,
    MaSP    varchar(4) not null,
    SoLuong SMALLINT   not null,
    GiaBan  real       not null
);

INSERT INTO CTPhieuXuat (SoPX, MaSP, SoLuong, GiaBan)
VALUES ('1', '2', 10, 5.99),
       ('1', '2', 5, 9.99),
       ('2', '3', 8, 5.99),
       ('3', '3', 15, 7.49),
       ('4', '4', 20, 6.99);

alter table CTPhieuXuat
    add CONSTRAINT fk_CTPhieuXuat_SoPX FOREIGN KEY (SoPX) REFERENCES PhieuXuat (SoPX);
alter table CTPhieuXuat
    add CONSTRAINT fk_CTPhieuXuat_MaSP FOREIGN KEY (MaSP) REFERENCES
        SanPham (MaSP);


# Bai 4

update KhachHang
set SoDT =123123123
where MaKH = 'KH1';
update NhanVien
set HoTen = 'update name'
where MaNV = '1';

#Bai 5
delete
from CTPhieuNhap
where SoPN = '1';
delete
from PhieuNhap
where MaNV = '1';
delete
from NhanVien
where MaNV = '1';

delete
from SanPham
where MaSp = '1';

#Bai 6.1
select MaNV
     , HoTen
     , GioiTinh
     , NgaySinh
     , DiaChi
     , DienThoai
     , Tuoi
from NhanVien
order by Tuoi desc;

alter table NhanVien
    add column Tuoi int;

update NhanVien
set Tuoi = 22
where MaNV = 2;
update NhanVien
set Tuoi = 25
where MaNV = 3;
update NhanVien
set Tuoi = 12
where MaNV = 4;

#Bai 6.2

select SoPN, MaNV, MaNCC
from PhieuNhap
where NgayNhap = '2024-12-12';

select PN.SoPN, NV.HoTen as HoTenNhanVien, PN.NgayNhap, NCC.TenNCC as TenNhaCungCap
from PhieuNhap PN
         join NhanVien NV on NV.MaNV = PN.MaNV
         join NhaCungCap NCC on NCC.MaNCC = PN.MaNCC
where YEAR(NgayNhap) = 2024
  and day(NgayNhap) = 12
  and month(NgayNhap) = 12;

#Bai 6.3

select *
from SanPham
where DonViTinh = 'chai';

#Bai 6.4

select CTPN.SoPN,
       CTPN.MaSp,
       SP.TenSP,
       SP.TenSP,
       SP.DonViTinh,
       CTPN.Soluong,
       CTPN.GiaNhap,
       CTPN.GiaNhap * CTPN.Soluong as ThanhTien

from CTPhieuNhap as CTPN
         join SanPham as SP on SP.MaSP = CTPN.MaSp
where month(current_date());

#Bai 6.5

select PN.MaNCC,
       NCC.TenNCC,
       NCC.DiaChi,
       NCC.DienThoai,
       PN.SoPN,
       PN.NgayNhap

from PhieuNhap as PN
         join NhaCungCap as NCC on NCC.MaNCC = PN.MaNCC
where month(PN.NgayNhap) = 12
order by PN.NgayNhap desc;

#Bai 6.6

select CTPX.SoPX,
       NV.HoTen                   as NhanVienBanHang,
       PX.NgayBan,
       SP.MaSP,
       SP.TenSP,
       SP.DonViTinh,
       CTPX.GiaBan,
       CTPX.GiaBan * CTPX.SoLuong as DoanhThu

from CTPhieuXuat CTPX
         join PhieuXuat PX on PX.SoPX = CTPX.SoPX
         join NhanVien NV on NV.MaNV = PX.MaNV
         join SanPham SP on SP.MaSP = CTPX.MaSP
where MONTH(PX.NgayBan) between 01 and 06;

#Bai 7.7

select *
from NhanVien
where MONTH(NgaySinh) = current_date();

#Bai 6.8

select CTPX.SoPX
     , NV.HoTen
     , PX.NgayBan
     , SP.MaSP
     , SP.TenSP
     , SP.DonViTinh
     , CTPX.SoLuong
     , CTPX.GiaBan
     , SUM(CTPX.SoLuong * CTPX.GiaBan) as doanhthu

from CTPhieuXuat CTPX
         join SanPham SP on CTPX.MaSP = SP.MaSP
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
         join NhanVien NV on PX.MaNV = NV.MaNV
where PX.NgayBan between '2024-02-14' and ' 2024-05-16';

#Bai 6.9

select PX.SoPX, PX.NgayBan, PX.MaKH, KH.TenKH, SUM(CPX.GiaBan * CPX.SoLuong) as TriGia

from PhieuXuat PX
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
         join KhachHang KH on KH.MaKH = PX.MaKH
group by KH.MaKH;

#Bai 6.10

select sum(CTPX.SoLuong) as Total

from CTPhieuXuat CTPX
         join SanPham SP on CTPX.MaSP = SP.MaSP
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
where MONTH(PX.NgayBan) between 1 and 6
  and SP.TenSP = 'Rice';

#Bai 6.11

select MONTH(PX.NgayBan)             as MoiThang,
       PX.MaKH,
       KH.TenKH,
       KH.DiaChi,
       sum(CPX.SoLuong * CPX.GiaBan) as TongTien

from KhachHang as KH
         join PhieuXuat PX on PX.MaKH = KH.MaKH
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
group by MONTH(PX.NgayBan), PX.MaKH, MONTH(PX.NgayBan), KH.TenKH, KH.DiaChi;

#Bai 6.12

select MONTH(PX.NgayBan) as months,
       YEAR(PX.NgayBan)  as years,
       SP.MaSP,
       SP.TenSP,
       SP.DonViTinh,
       CTPX.SoLuong      as TongSoLuong

from CTPhieuXuat as CTPX
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
         join SanPham SP on CTPX.MaSP = SP.MaSP
where MONTH(PX.NgayBan) between 1 and 12
order by MONTH(PX.NgayBan);

#Bai 6.13

select MONTH(PX.NgayBan) as month, sum(CTPX.GiaBan * CTPX.SoLuong) as DoanhThu

from CTPhieuXuat as CTPX
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
where MONTH(PX.NgayBan) between 1 and 6
order by MONTH(PX.NgayBan);

#Bai 6.14
select CTPX.SoPX, NV.HoTen, KH.TenKH, SUM(CTPX.GiaBan * CTPX.SoLuong) as TongTriGia

from CTPhieuXuat as CTPX
         join PhieuXuat PX on CTPX.SoPX = PX.SoPX
         join NhanVien NV on PX.MaNV = NV.MaNV
         join KhachHang as KH on PX.MaKH = KH.MaKH
where MONTH(PX.NgayBan) between 4 and 6;

#Bai 6.15

select PX.SoPX,
       KH.MaKH,
       KH.TenKH,
       NV.HoTen,
       PX.NgayBan,
       SUM(CPX.SoLuong * CPX.GiaBan) as TriGia

from PhieuXuat as PX
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
         join KhachHang KH on PX.MaKH = KH.MaKH
         join NhanVien NV on PX.MaNV = NV.MaNV
where MONTH(PX.NgayBan) = CURRENT_DATE();

#Bai 6.16

select PX.MaNV,
       NV.HoTen,
       SP.MaSP,
       SP.TenSP,
       SP.DonViTinh,
       SUM(CPX.SoLuong)

from NhanVien NV
         join PhieuXuat PX on PX.MaNV = NV.MaNV
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
         join SanPham as SP on SP.MaSP = CPX.MaSP
group by PX.MaNV;

#Bai 6.17

select PX.SoPX,
       PX.NgayBan,
       SP.MaSP,
       SP.TenSP,
       CPX.SoLuong,
       SP.DonViTinh,
       SUM(CPX.SoLuong * CPX.GiaBan) as ThanhTien

from PhieuXuat PX
         join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
         join SanPham SP on CPX.MaSP = SP.MaSP
         join KhachHang KH on PX.MaKH = KH.MaKH
where MONTH(PX.NgayBan) between 4 and 6
  and KH.MaKH = 'KH1'
group by PX.SoPX;

#Bai 6.18

select SP.MaSP, SP.TenSP, sp.MaloaiSP, sp.DonViTinh

from SanPham as SP
         join CTPhieuXuat CPX on SP.MaSP = CPX.MaSp
         join PhieuXuat PX on CPX.SoPX = PX.SoPX
where MONTH(PX.NgayBan) between 1 and 6
  and SP.GhiChu = 'Chua Ban Duoc';

#Bai 6.19

#Them 1 truong SoGiaoDich
alter table NhaCungCap
    add column SoGiaoDich varchar(10);

alter table NhaCungCap add COLUMN  NgayGiaoDich DATE;

update NhaCungCap
set ``.NhaCungCap.NgayGiaoDich =
    case
        when MaNCC = 1 then '2024-02-12'
        when MaNCC = 2 then '2024-05-12'
        when MaNCC = 3 then '2024-06-12'
        when MaNCC = 4 then '2024-04-12'
end
where MaNCC in (1,2,3,4);
#Them Gia Tri
update NhaCungCap
set SoGiaoDich =
    CASE
        When MaNCC = 1 then 1
        When MaNCC = 2 then 0
        when MaNCC = 3 then 2
when MaNCC = 4 then 3
end
where MaNCC in (1,2,3,4);

select *

    from NhaCungCap as NCC
where MONTH(NCC.NgayGiaoDich) between 4 and 6 and NCC.SoGiaoDich = 0;


#Bai 6.20

select KH.MaKH, SUM(CTPX.GiaBan * CTPX.SoLuong)

    from KhachHang KH
        join PhieuXuat PX on KH.MaKH = PX.MaKH
join CTPhieuXuat CTPX on CTPX.SoPX = PX.SoPX
where MONTH(PX.NgayBan) between 1 and 6
having SUM(CTPX.GiaBan * CTPX.SoLuong)= (
    select Max(Total)
    from (
        select SUM(CTPX.GiaBan * CTPX.SoLuong)
        as Total
        from PhieuXuat PX
        join CTPhieuXuat CTPX on PX.SoPX = CTPX.SoPX
        where (month(PX.NgayBan)) between 1 and 6
        ) as Subquery
    )
;
#Bonus
#Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm
select *

from KhachHang KH
join PhieuXuat PX on KH.MaKH = PX.MaKH
join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
# where MONTH(PX.NgayBan) between 1 and 6
HAVING SUM(CPX.GiaBan * CPX.SoLuong) = (
    select MinTotal
    from (
        select SUM(CPX.GiaBan * CPX.SoLuong) as MinTotal
        from KhachHang KH
                 join PhieuXuat PX on KH.MaKH = PX.MaKH
                 join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
#         where MONTH(PX.NgayBan) between 1 and 6
        order by MinTotal
        limit 1
         )
    as Subquery
    );

#Bai 6.21

select KH.MaKH, SUM(CPX.SoLuong)

    from KhachHang KH
join PhieuXuat PX on KH.MaKH = PX.MaKH
join CTPhieuXuat CPX on PX.SoPX = CPX.SoPX
group by KH.MaKH;

#Bai 6.22
#Hien thi nhan vien ko co dai dien ban hang
select * from NhanVien as NV
where NV.MaNQL = 'null';


#Bai 6.23

select count(CASE when NV.GioiTinh = true then 1 end) as NhanViennam,
       count(case when NV.GioiTinh = false then 0 end) as NhanVienNu
    from NhanVien as NV;
#Bai 6.24

select
    nv.MaNQL, nv.HoTen, YEAR(CURRENT_DATE) - YEAR(nv.NgayVaoLam) as ThamNien

from NhanVien AS NV
;

#Bai 6.25
select nv.HoTen
    from NhanVien as NV where
(YEAR(CURRENT_DATE()) - YEAR(NV.NgaySinh) > 14 AND NV.GioiTinh = true)
or
(YEAR(CURRENT_DATE()) - YEAR(NV.NgaySinh) > 55 AND NV.GioiTinh = false);

#Bai 6.26
select
    nv.HoTen,
    case
        when NV.GioiTinh = true then YEAR(NV.NgayVaoLam) + 60
        when NV.GioiTinh = false then YEAR(NV.NgayVaoLam) + 55
        end as NamVeHuu
    from NhanVien as NV;

#Bai 6.27

select
  nv.HoTen,
    case
        when year(current_date) - year(nv.NgayVaoLam) < 1 then 200000
        when year(current_date) - year(nv.NgayVaoLam) >= 1 and
             year(current_date) - year(nv.NgayVaoLam) < 3 then 400000
        when year(current_date) - year(nv.NgayVaoLam) >= 3 and
             year(current_date) - year(nv.NgayVaoLam) < 5 then 600000
        when year(current_date) - year(nv.NgayVaoLam) >= 5 and
             year(current_date) - year(nv.NgayVaoLam) < 10 then 800000
       when              year(current_date) - year(nv.NgayVaoLam) > 10 then 1000000
        end as TienThuong

from NhanVien as nv;

#Bai 6.28

select
    *

    from SanPham sp
 join LoaiSP LSP on LSP.MaLoaiSP = sp.MaloaiSP
where LSP.TenloaiSP = 'Hoa My Pham';

#Bai 6.29

select
    * from SanPham sp
join LoaiSP LS on sp.MaloaiSP = ls.MaLoaiSP
where ls.TenloaiSP = 'Quan Ao';

#Bai 6.30

select
    count(*)
from SanPham sp
join LoaiSP LS on sp.MaloaiSP = LS.MaLoaiSP
where ls.TenloaiSP = 'Quan Ao';

#Bai 6.31

select
    count(*)
from SanPham SP
join LoaiSP LS on SP.MaloaiSP = LS.MaLoaiSP
where ls.TenloaiSP = 'Hoa My Pham';

#Bai 6.32

select
    count(MaSP) as SoLuong, LSP.TenloaiSP
from LoaiSP LSP
join SanPham SP on SP.MaloaiSP = LSP.MaLoaiSP
group by  LSP.TenloaiSP;









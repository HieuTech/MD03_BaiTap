create database QuanLyVatLieu;
use QuanLyVatLieu;

create table PhieuXuat
(
    soPx     int primary key auto_increment,
    ngayXuat datetime

);
create table PhieuXuatChiTiet
(
    soPx        int,
    maVt        int,
    donGiaXuat  double,
    soLuongXuat int
);
create table VatTu
(
    maVT  int primary key auto_increment,
    tenVT varchar(2550)

);
alter table PhieuXuatChiTiet
    add constraint fk_MaVT_VatTu
    foreign key (maVt) references VatTu(maVT);

alter table PhieuXuatChiTiet
    add constraint fk_PX_PXChiTiet
        foreign key (soPx) references PhieuXuat (soPx);

create table PhieuNhap
(
    soPn     int primary key auto_increment,
    ngayNhap datetime

);
create table PhieuNhapChiTiet
(
    soPn        int,
    maVt        int,
    donGiaNhap  double,
    soLuongNhap int
);
alter table PhieuNhapChiTiet
    add constraint fk_PN_VatTu
        foreign key (maVt) references VatTu(maVT);

alter table PhieuNhapChiTiet
    add constraint fk_PN_PNChiTiet
        foreign key (soPn) references PhieuNhap (soPn);
create table NhaCungCap
(
    maNCC     int primary key auto_increment,
    tenNCC varchar(255),
    diaChi varchar(255),
    soDienThoai varchar(255)

);
create table DonDatHang
(
    soDH     int primary key auto_increment,
    maNCC int,
    ngayDH datetime

);
alter table DonDatHang
    add constraint fk_DDH_MNCC
        foreign key (maNCC) references NhaCungCap (maNCC);
create table ChiTietDonDatHang
(
    soDH        int,
    maVt        int
);
alter table ChiTietDonDatHang
    add constraint fk_CTDH_VATTU
        foreign key (maVt) references VatTu (maVT);



alter table ChiTietDonDatHang
    add constraint fk_CTDH_soDH
        foreign key (soDH) references DonDatHang (soDH);

-- Thêm dữ liệu vào bảng VatTu
INSERT INTO VatTu (tenVT) VALUES
                              ('Bút bi đen'),
                              ('Giấy A4'),
                              ('Mực in HP'),
                              ('Băng dính'),
                              ('Thước kẻ');

-- Thêm dữ liệu vào bảng NhaCungCap
INSERT INTO NhaCungCap (tenNCC, diaChi, soDienThoai) VALUES
                                                         ('Công ty A', '123 Đường ABC, Thành phố X', '0123456789'),
                                                         ('Công ty B', '456 Đường XYZ, Thành phố Y', '0987654321'),
                                                         ('Công ty C', '789 Đường DEF, Thành phố Z', '0123456789'),
                                                         ('Công ty D', '101 Đường GHI, Thành phố K', '0987654321'),
                                                         ('Công ty E', '112 Đường JKL, Thành phố L', '0123456789');

-- Thêm dữ liệu vào bảng DonDatHang
INSERT INTO DonDatHang (maNCC, ngayDH) VALUES
                                           (1, '2024-04-20 08:00:00'),
                                           (2, '2024-04-21 09:00:00'),
                                           (3, '2024-04-22 10:00:00'),
                                           (4, '2024-04-23 11:00:00'),
                                           (5, '2024-04-24 12:00:00');

-- Thêm dữ liệu vào bảng ChiTietDonDatHang
INSERT INTO ChiTietDonDatHang (soDH, maVt) VALUES
                                               (1, 1),
                                               (1, 2),
                                               (2, 3),
                                               (2, 4),
                                               (3, 5);

-- Thêm dữ liệu vào bảng PhieuNhap
INSERT INTO PhieuNhap (ngayNhap) VALUES
                                     ('2024-04-20 08:00:00'),
                                     ('2024-04-21 09:00:00'),
                                     ('2024-04-22 10:00:00'),
                                     ('2024-04-23 11:00:00'),
                                     ('2024-04-24 12:00:00');

-- Thêm dữ liệu vào bảng PhieuNhapChiTiet
INSERT INTO PhieuNhapChiTiet (soPn, maVt, donGiaNhap, soLuongNhap) VALUES
                                                                       (1, 1, 10000, 100),
                                                                       (1, 2, 5000, 200),
                                                                       (2, 3, 20000, 50),
                                                                       (2, 4, 3000, 300),
                                                                       (3, 5, 15000, 80);

-- Thêm dữ liệu vào bảng PhieuXuat
INSERT INTO PhieuXuat (ngayXuat) VALUES
                                     ('2024-04-20 08:00:00'),
                                     ('2024-04-21 09:00:00'),
                                     ('2024-04-22 10:00:00'),
                                     ('2024-04-23 11:00:00'),
                                     ('2024-04-24 12:00:00');

-- Thêm dữ liệu vào bảng PhieuXuatChiTiet
INSERT INTO PhieuXuatChiTiet (soPx, maVt, donGiaXuat, soLuongXuat) VALUES
                                                                       (1, 1, 12000, 80),
                                                                       (1, 2, 6000, 150),
                                                                       (2, 3, 22000, 30),
                                                                       (2, 4, 3500, 250),
                                                                       (3, 5, 17000, 60);

#1
select VT.*
    from PhieuXuat px
             join PhieuXuatChiTiet PXCT on px.soPx = PXCT.soPx

        join VatTu VT on VT.maVT = PXCT.maVt
where PXCT.soLuongXuat > 100;

#2
select VT.*
    from PhieuXuat px
    join PhieuXuatChiTiet PXCT on px.soPx = PXCT.soPx
join VatTu VT on PXCT.maVt = VT.maVT
where px.ngayXuat = '2024-04-22 10:00:00';

#3
select VT.*
    from PhieuNhap pn
join PhieuNhapChiTiet PNCT on pn.soPn = PNCT.soPn
join VatTu VT on PNCT.maVt = VT.maVT
where PNCT.donGiaNhap > 10000;

#4
select VT.*


    from PhieuXuat px
join PhieuXuatChiTiet PXCT on px.soPx = PXCT.soPx
join VatTu VT on PXCT.maVt = VT.maVT
where PXCT.soLuongXuat > 100;

#5
select * from NhaCungCap where soDienThoai like '0123%' and diaChi like '%Z%';
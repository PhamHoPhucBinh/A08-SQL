CREATE DATABASE QuanLiVatTu;
use QuanLiVatTu;
CREATE TABLE VatTu(
    TenVatTu VARCHAR(20),
    MaVatTu VARCHAR(10) PRIMARY KEY
);
CREATE TABLE PhieuXuat(SoPX int PRIMARY KEY, NgayXuat DATE);
CREATE TABLE PhieuNhap(soPN INT PRIMARY KEY, NgayNhap DATE);
CREATE TABLE DonDatHang(
    SoDatHang INT PRIMARY KEY,
    NgayDatHang DATE
);
CREATE TABLE NhaCungCap(
    MaNhaCungCap INT PRIMARY KEY not null,
    TenNhaCungCap VARCHAR(30),
    DiaChiNhaCungCap VARCHAR(50),
	SDT int,
    FOREIGN KEY (SoDatHang) REFERENCES DonDatHang(SoDatHang)
);
CREATE TABLE ChiTietPhieuXuat(
    SoLuongXuat INT,
    DGXuat INT,
    SoPX INT,
    MaVatTu VARCHAR(10),
    FOREIGN KEY (SoPX) REFERENCES PhieuXuat(SoPX),
    FOREIGN KEY (MaVatTu) REFERENCES VatTu(MaVatTu)
);
CREATE TABLE ChiTietPhieuNhap(
    DGNhap INT,
    SoLuongNhap INT,
    MaVatTu VARCHAR(10),
    SoPN INT,
    FOREIGN KEY (MaVatTu) REFERENCES VatTu(MaVatTu),
    FOREIGN KEY (SoPN) REFERENCES PhieuNhap(SoPN)
);
CREATE TABLE ChiTietDonDatHang(
    SoDatHang INT,
    MaVatTu VARCHAR(10),
    FOREIGN KEY (MaVatTu) REFERENCES VatTu(MaVatTu),
    FOREIGN KEY (SoDatHang) REFERENCES DonDatHang(SoDatHang)
);
CREATE TABLE SoDienThoai(
    idSDT  INT,
    sdt VARCHAR(11),
    MaNhaCungCap INT,
    foreign key (sdt) references nhacungcap(SDT),
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
    );

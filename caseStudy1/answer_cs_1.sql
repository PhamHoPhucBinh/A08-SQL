-- câu 1 : insert data
-- cau 2: hiển thị tên nvien theo chữ đầu và độ dài
SELECT 
    *
FROM
    nhan_vien
WHERE
    ho_ten LIKE 'H%' OR ho_ten LIKE 'T%'
        OR ho_ten LIKE 'K%'
        AND LENGTH(ho_ten) <= 15;
-- câu 3 : tuổi dựa trên ngày sinh và lọc địa chỉ : 
select ho_ten, DATEDIFF(CURDATE(), ngay_sinh)/365 as age from khach_hang 
where (dia_chi like '%Đà Nẵng%' or dia_chi like '%Quảng Trị%') and DATEDIFF(CURDATE(), ngay_sinh)/365 between 18 and  50;

-- câu 4 : đếm số lần mỗi khách hàng đã từng đặt phòng và chỉ đếm những khách hàng có tên loại khách hàng là "Diamond"
select khach_hang.ho_ten,hop_dong.ma_khach_hang ,count(*) as num_bookings
from hop_dong
join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
where khach_hang.ma_loai_khach = 1
group by hop_dong.ma_khach_hang, khach_hang.ho_ten
order by num_bookings;

-- câu 5 : left join để hiển thị những data null và SUM trong filter SQL
select khach_hang.ma_khach_hang , khach_hang.ho_ten , loai_khach.ten_loai_khach, hop_dong.ma_hop_dong, dich_vu.ten_dich_vu, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc
, sum(dich_vu.chi_phi_thue + hop_dong_chi_tiet.so_luong*dich_vu_di_kem.gia) as tong_tien 
from khach_hang
left join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
left join hop_dong on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
left join dich_vu on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
left join dich_vu_di_kem on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
group by khach_hang.ma_khach_hang, khach_hang.ho_ten,loai_khach.ten_loai_khach,hop_dong.ma_hop_dong,dich_vu.ten_dich_vu,hop_dong.ngay_lam_hop_dong,hop_dong.ngay_ket_thuc,tong_tien 
order by khach_hang.ma_khach_hang asc;

-- câu 6 : lọc theo quý và năm
select distinct dich_vu.ma_dich_vu , dich_vu.ten_dich_vu, dich_vu.dien_tich, dich_vu.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu 
from dich_vu
join loai_dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
join hop_dong on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
where dich_vu.ma_dich_vu not in ( 
select hop_dong.ma_dich_vu
from hop_dong 
where month(hop_dong.ngay_lam_hop_dong) in (1,2,3) and year(hop_dong.ngay_lam_hop_dong) = 2021
)
order by dien_tich desc;


-- câu 7 : hiển thị từng được đặt trong 2020 nhưng chưa đc đặt trong 2021 ( lọc theo năm ) : 
select dich_vu.ma_dich_vu ,dich_vu.ten_dich_vu, dich_vu.dien_tich, dich_vu.so_nguoi_toi_da, dich_vu.chi_phi_thue, dich_vu.ma_loai_dich_vu, 
loai_dich_vu.ma_loai_dich_vu,loai_dich_vu.ten_loai_dich_vu
from dich_vu
join loai_dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
where dich_vu.ma_dich_vu Not in (
select dich_vu.ma_dich_vu
from dich_vu
join hop_dong on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
where year(hop_dong.ngay_lam_hop_dong) = 2021
)
AND dich_vu.ma_dich_vu IN (
select dich_vu.ma_dich_vu
from dich_vu
join hop_dong on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2020
)
GROUP BY dich_vu.ma_dich_vu;
-- câu 8 : hiển thị k trùng nhau bằng 3 cách
select distinct ho_ten from khach_hang;
select ho_ten from khach_hang group by ho_ten;
select ho_ten from khach_hang group by ho_ten having count(*) = 1;
-- câu 9 : đếm số lần được đặt hàng theo mỗi tháng
select month(hop_dong.ngay_lam_hop_dong) as 'Tháng' , count(distinct hop_dong.ma_khach_hang) as 'Số Khách Đặt'
from hop_dong
where year(hop_dong.ngay_lam_hop_dong) = 2021 
group by month(hop_dong.ngay_lam_hop_dong);
-- câu 10 : sum để đếm tổng số lần được sử dụng
select hop_dong.ma_hop_dong, hop_dong.ngay_lam_hop_dong, hop_dong.ngay_ket_thuc,  hop_dong.tien_dat_coc, sum(hop_dong_chi_tiet.so_luong) as so_luong_dich_vu_di_kem
from hop_dong
left join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
group by hop_dong.ma_hop_dong ;
-- câu 11 : Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”
select dich_vu_di_kem.ten_dich_vu_di_kem , dich_vu_di_kem.ma_dich_vu_di_kem
from dich_vu_di_kem
inner join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
inner join hop_dong on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
inner join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
inner join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
where loai_khach.ten_loai_khach = 'Diamond' and (khach_hang.dia_chi  like '%Vinh%' or khach_hang.dia_chi like '%Quảng Ngãi%') ;

-- câu 12 : đã từng đặt 1 trong time zone và loại trừ 1 timezone khác
SELECT hop_dong.ma_hop_dong, nhan_vien.ho_ten, khach_hang.ho_ten, khach_hang.so_dien_thoai, dich_vu.ten_dich_vu, hop_dong.tien_dat_coc,
SUM(hop_dong_chi_tiet.so_luong) AS so_luong_dich_vu_di_kem
FROM hop_dong 
INNER JOIN nhan_vien ON hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
INNER JOIN khach_hang ON hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
INNER JOIN dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
INNER JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
INNER JOIN dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2020 AND MONTH(hop_dong.ngay_lam_hop_dong) IN (10,11,12)
AND hop_dong.ma_hop_dong NOT IN (
    SELECT hop_dong.ma_hop_dong
    FROM hop_dong 
    WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2021 AND MONTH(hop_dong.ngay_lam_hop_dong) IN (1,2,3)
)
GROUP BY hop_dong.ma_hop_dong, nhan_vien.ho_ten, khach_hang.ho_ten, khach_hang.so_dien_thoai, dich_vu.ten_dich_vu, hop_dong.tien_dat_coc;


-- câu 13 : đếm số dvdk và filter ra số lớn nhất
select s.ten_dich_vu_di_kem,  max(s.sum_so_luong) as max_soluong
from (
select dich_vu_di_kem.ten_dich_vu_di_kem as ten_dich_vu_di_kem, sum(hop_dong_chi_tiet.so_luong) as sum_so_luong
from dich_vu_di_kem
join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
join hop_dong on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
group by  dich_vu_di_kem.ma_dich_vu_di_kem) s ;


-- câu 14 :Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT hop_dong.ma_hop_dong, loai_dich_vu.ten_loai_dich_vu, dich_vu_di_kem.ten_dich_vu_di_kem,
COUNT(hop_dong_chi_tiet.ma_dich_vu_di_kem) as num_used
FROM hop_dong
inner join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu
inner join loai_dich_vu on loai_dich_vu.ma_loai_dich_vu = dich_vu.ma_loai_dich_vu
inner join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong  = hop_dong.ma_hop_dong
inner join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
GROUP BY dich_vu_di_kem.ten_dich_vu_di_kem
HAVING num_used = 1;

-- câu 15 : hàm tối đa bao nhiêu lần record
select nhan_vien.ma_nhan_vien, nhan_vien.ho_ten, trinh_do.ten_trinh_do , bo_phan.ten_bo_phan, nhan_vien.so_dien_thoai, nhan_vien.dia_chi
from nhan_vien
join trinh_do on nhan_vien.ma_trinh_do = trinh_do.ma_trinh_do
join bo_phan on nhan_vien.ma_bo_phan = bo_phan.ma_bo_phan
join hop_dong on nhan_vien.ma_nhan_vien = hop_dong.ma_nhan_vien
where hop_dong.ngay_lam_hop_dong >= '2020-01-01' AND hop_dong.ngay_lam_hop_dong <= '2021-12-31'
GROUP BY nhan_vien.ma_nhan_vien, nhan_vien.ho_ten, trinh_do.ten_trinh_do, bo_phan.ten_bo_phan, nhan_vien.so_dien_thoai, nhan_vien.dia_chi
HAVING COUNT(hop_dong.ma_hop_dong) <= 3;

-- câu 16 : xóa row đc filter theo cond
DELETE FROM nhan_vien
WHERE ma_nhan_vien NOT IN (
    SELECT DISTINCT ma_nhan_vien
    FROM hop_dong
    WHERE YEAR(ngay_lam_hop_dong) >= 2019 AND YEAR(ngay_lam_hop_dong) <= 2021
);
-- câu 17 : update theo condition
UPDATE khach_hang
SET ma_loai_khach = '1'
WHERE ma_khach_hang IN (
SELECT DISTINCT hd.ma_khach_hang
FROM hop_dong hd
JOIN hop_dong hdg ON hd.ma_hop_dong = hdg.ma_hop_dong
WHERE hdg.ngay_lam_hop_dong BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY hd.ma_khach_hang
HAVING SUM(hd.tong_tien) > 10000000
) AND ma_loai_khach = '2';

-- câu 18 :  xóa theo condition thời gian
delete from khach_hang
where ma_khach_hang in (
select distinct ma_khach_hang
from hop_dong
where year(ngay_lam_hop_dong) < 2021);

DELETE FROM khach_hang 
WHERE ma_khach_hang IN (
    SELECT DISTINCT ma_khach_hang 
    FROM hop_dong 
    WHERE YEAR(ngay_lam_hop_dong) < 2021
);


-- câu 19 : Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.
UPDATE dich_vu_di_kem
SET gia = gia * 2
WHERE ma_dich_vu_di_kem IN (
    SELECT ma_dich_vu_di_kem
    FROM hop_dong_chi_tiet
    INNER JOIN hop_dong ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    WHERE YEAR(ngay_lam_hop_dong) = 2020
    GROUP BY ma_dich_vu_di_kem
    HAVING COUNT(*) > 10
);

-- câu 20 : Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, 
-- thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh

SELECT ma_nhan_vien AS id, ho_ten, email, so_dien_thoai, ngay_sinh
FROM nhan_vien

UNION ALL

SELECT ma_khach_hang AS id, ho_ten, email, so_dien_thoai, ngay_sinh
FROM khach_hang;



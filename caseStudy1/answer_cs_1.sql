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
group by hop_dong.ma_hop_dong;
-- câu 11 : Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”
select dich_vu_di_kem.ten_dich_vu_di_kem , dich_vu_di_kem.ma_dich_vu_di_kem
from dich_vu_di_kem
inner join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
inner join hop_dong on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
inner join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
inner join loai_khach on khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
where khach_hang.ma_khach_hang = 1 and khach_hang.dia_chi in ('%Quảng Ngãi%');
-- câu 12 : đã từng đặt 1 trong time zone và loại trừ 1 timezone khác
select hop_dong.ma_hop_dong, nhan_vien.ho_ten , khach_hang.ho_ten, khach_hang.so_dien_thoai, dich_vu.ten_dich_vu , hop_dong.tien_dat_coc,
sum(hop_dong_chi_tiet.so_luong) as so_luong_dich_vu_di_kem
from hop_dong 
inner join nhan_vien on hop_dong.ma_nhan_vien = nhan_vien.ma_nhan_vien
inner join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
inner join dich_vu on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
inner join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
inner join dich_vu_di_kem on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
where year(hop_dong.ngay_lam_hop_dong) = 2020 and month(hop_dong.ngay_lam_hop_dong) in (10,11,12)
and hop_dong.ma_hop_dong not in (
select hop_dong.ngay_lam_hop_dong
from hop_dong 
where year(hop_dong.ngay_lam_hop_dong) = 2021 and month(hop_dong.ngay_lam_hop_dong) in (1,2,3)
)
group by hop_dong.ma_hop_dong, nhan_vien.ho_ten , khach_hang.ho_ten, khach_hang.so_dien_thoai, dich_vu.ten_dich_vu , hop_dong.tien_dat_coc,so_luong_dich_vu_di_kem;

-- câu 13 : đếm số dvdk và filter ra số lớn nhất
select dich_vu_di_kem.ten_dich_vu_di_kem , count(*) as so_lan_su_dung
from dich_vu_di_kem
join hop_dong_chi_tiet on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem
join hop_dong on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong
join khach_hang on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
group by dich_vu_di_kem.ten_dich_vu_di_kem 
order by so_lan_su_dung;

-- câu 14 :
select hop_dong_chi_tiet.ma_dich_vu_di_kem ,count(hop_dong_chi_tiet.ma_dich_vu_di_kem) as num_used , 
hop_dong.ma_hop_dong , loai_dich_vu.ten_loai_dich_vu , dich_vu_di_kem.ten_dich_vu_di_kem
from hop_dong
inner join hop_dong_chi_tiet on hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
inner join dich_vu_di_kem on hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
inner join dich_vu on hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
inner join loai_dich_vu on dich_vu.ma_loai_dich_vu = loai_dich_vu.ma_loai_dich_vu
group by hop_dong.ma_hop_dong , loai_dich_vu.ten_loai_dich_vu , dich_vu_di_kem.ten_dich_vu_di_kem, num_used
having count(hop_dong_chi_tiet.ma_dich_vu_di_kem);

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
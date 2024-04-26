use QuanLyDiemSV;
-- 1. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh
-- viên, Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã
-- sinh viên tăng dần

select MaSV, HoSV, TenSV, HocBong

from dmsv
order by MaSV;

-- 2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên,
-- Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.

select MaSV, HoSV, Phai, (YEAR(CURDATE()) - YEAR(NgaySinh)) as Age

from dmsv
order by Phai;


-- 3. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông
-- tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.

select HoSV,
       NgaySinh,
       HocBong
from dmsv
order by NgaySinh, HocBong desc;

-- 4. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã
-- môn, Tên môn, Số tiết.

select *
from DMMH
where TenMH like 'T%';
-- 5. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm
-- các thông tin: Họ tên sinh viên, Ngày sinh, Phái.

select *
from dmsv
where TenSV like '%I';
-- 6. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, gồm
-- các thông tin: Mã khoa, Tên khoa.

select *
from DMKhoa
where TenKhoa LIKE '_N%';


-- 7. Liệt kê những sinh viên mà họ có chứa chữ Thị.

select *
from dmsv
where HoSV like '%Thị%';
;
-- 8. Cho biết danh sách các sinh viên có học bổng lớn hơn 100,000, gồm các
-- thông tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ
-- được sắp xếp theo thứ tự Mã khoa giảm dần

select *
from dmsv
where HocBong > 100000
order by MaKhoa desc;



-- 9. Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm
-- các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.

select *
from dmsv
where HocBong > 90000
  and NoiSinh = 'Hà Nội';

-- 10.Danh sách các sinh viên của khoa Anh văn và khoa Vật lý, gồm các thông
-- tin: Mã sinh viên, Mã khoa, Phái.

select *
from dmsv
where MaKhoa in (select Makhoa
                 from DMKhoa
                 where TenKhoa in ('Anh Văn', 'Vật Lý'));

-- 11.Cho biết những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày
-- 05/06/1992 gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học
-- bổng.

select *
from dmsv
where NgaySinh between '1991/01/01' and '1992/06/05';

-- 12.Danh sách những sinh viên có học bổng từ 80.000 đến 150.000, gồm các
-- thông tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.

select *
from dmsv
where HocBong between 80000 and 150000;

-- 13.Cho biết những môn học có số tiết lớn hơn 30 và nhỏ hơn 45, gồm các thông
-- tin: Mã môn học, Tên môn học, Số tiết.

select *
from DMMH
where SoTiet between 30 and 45;

-- 14.Liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các
-- thông tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.

select *
from dmsv
where MaKhoa in (select MaKhoa from DMKhoa where TenKhoa in ('Anh Văn', 'Tin học'))
  and Phai = 'Nam';

-- 15.Liệt kê những sinh viên nữ, tên có chứa chữ N

select *
from dmsv
where Phai = 'Nữ'
  and TenSV like 'M%';

-- 16.Danh sách sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02, gồm các
-- thông tin: Họ sinh viên, Tên sinh viên, Nơi sinh, Ngày sinh.

select *
from dmsv
where NoiSinh = 'Hà Nội'
  and MONTH(NgaySinh) = 2;
-- 17.Cho biết những sinh viên có tuổi lớn hơn 20, thông tin gồm: Họ tên sinh
-- viên, Tuổi,Học bổng.

select *
from dmsv
where YEAR(curdate()) - YEAR(NgaySinh) > 20;

-- 18.Danh sách những sinh viên có tuổi từ 20 đến 25, thông tin gồm: Họ tên sinh
-- viên, Tuổi, Tên khoa.

select *
from dmsv
where YEAR(curdate()) - YEAR(NgaySinh) between 20 and 35;
-- 19.Danh sách sinh viên sinh vào mùa xuân năm 1990, gồm các thông tin: Họ
-- tên sinh viên,Phái, Ngày sinh.

select *
from dmsv
where (MONTH(NgaySinh) between 1 and 4)
  and YEAR(NgaySinh) = 1990;

-- 20.Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên,
-- Phái, Mã khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học
-- bổng cao” nếu giá trị của field học bổng lớn hơn 500,000 và ngược lại hiển
-- thị là “Mức trung bình”

select MaSV, Phai, MaKhoa, case when HocBong > 100000 then 'HocBongCao' else 'MucTrungBinh' end as MucHocBong
from dmsv;


-- 21.Cho biết tổng số sinh viên của toàn trường

select count(*) as TongSinhVien
from dmsv;

-- 22.Cho biết tổng sinh viên và tổng sinh viên nữ.
select (select count(*) as TongSinhVien
        from dmsv)                                                     as TongSinhVien,
       (select count(*) as TongSinhVienNu from dmsv where Phai = 'Nữ') as TongSinhVienNu;


-- 23.Cho biết tổng số sinh viên của từng khoa.

select count(dmsv.MaKhoa) as TongSoSinhVien, DMKhoa.TenKhoa
from DMKhoa
         join dmsv on DMKhoa.MaKhoa = dmsv.MaKhoa
group by dmsv.MaKhoa;

-- 24.Cho biết số lượng sinh viên học từng môn.

select count(KetQua.MaSV) as TongSoSinhVien,DMMH.TenMH
from dmsv
         join KetQua on KetQua.MaSV = dmsv.MaSV
         join DMMH on DMMH.MaMH = KetQua.MaMH
group by DMMH.TenMH;


-- 25.Cho biết số lượng môn học mà từng sinh viên(in ra tên SV đó đã học(tức tổng số môn học có
-- trong bảng kq)

select count(MaMH) SoLuongMonHoc, dmsv.TenSV
from KetQua
         join dmsv on dmsv.MaSV = KetQua.MaSV
group by dmsv.TenSV
;

-- 26.Cho biết tổng số học bổng của mỗi khoa.

select sum(HocBong) as TongSoHocBong, MaKhoa
from dmsv
group by (MaKhoa);

-- 27.Cho biết sinh vien có học bổng cao nhất của mỗi khoa.

select *
from dmsv
where HocBong in (select max(HocBong) from dmsv group by dmsv.MaKhoa having max(HocBong));


-- 28.Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa.

select  (select count(*) SoSinhVienNam, MaKhoa
        from dmsv
        where Phai = 'Nam'
        group by MaKhoa
        ) ,

       (select count(*) as TongSoSinhVienNu, MaKhoa
        from dmsv
        where Phai = 'Nữ'
        group by MaKhoa
        )
;

select MaKhoa, sum(if( Phai like 'Nam', 1,0)) as SoNam, sum(if( Phai like 'Nữ' ,1,0 )) as SoNu from dmsv
group by Makhoa;

SELECT
    MaKhoa,
    SUM(IF(Phai LIKE 'Name', 1, 0)) AS SoNam,
    SUM(IF(Phai LIKE 'Nữ', 1, 0)) AS SoNu
FROM
    dmsv
GROUP BY
    MaKhoa;

-- 29.Cho biết số lượng sinh viên theo từng độ tuổi.

select count(*) TongSinhVien, (YEAR(curdate()) - YEAR(NgaySinh)) DoTuoi
from dmsv
group by DoTuoi;


-- 30.Cho biết những năm sinh nào có 2 sinh viên đang theo học tại trường.

select YEAR(dmsv.NgaySinh) as NamSinh
from dmsv
         join KetQua on KetQua.MaSV = dmsv.MaSV
where KetQua.MaSV in (select MaSV from KetQua group by MaSV)
limit 2;


-- 31.Cho biết những nơi nào có hơn 4 sinh viên đang theo học tại trường.

select dmsv.NoiSinh

from dmsv
where MaSV in (select MaSV from KetQua group by KetQua.MaSV having count(MaSV) > 3
);


-- 32.Cho biết những môn nào có trên 3 sinh viên dự thi.

select DMMH.TenMH
     from dmsv
join KetQua on KetQua.MaSV = dmsv.MaSV
join DMMH on DMMH.MaMH = KetQua.MaMH
where DMMH.MaMH in (
select MaMH from KetQua group by MaMH having count(MaSV)>=3)
group by DMMH.TenMH
;


-- 33.Cho biết những sinh viên thi lại trên 2 lần.

select MaSV from KetQua where LanThi = 1 and Diem < 5;


-- 34.Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0
select * from dmsv
join KetQua on KetQua.MaSV = dmsv.MaSV
where dmsv.MaSV in (select MaSV from KetQua where  LanThi = 1 group by MaSV having AVG(Diem) >7)

                                                            and dmsv.Phai = 'Nam';

-- 35.Cho biết danh sách các sinh viên rớt (diem thi lan 1 < 5) trên 2 môn ở lần thi 1 .


    select TenSV from dmsv where MaSV in (select  MaSV from KetQua where Diem < 5 and LanThi = 1 group by MaSV having  count(MaMH) >= 2);



-- 36.Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam

select DMKhoa.TenKhoa
from DMKhoa join dmsv on dmsv.MaKhoa = DMKhoa.MaKhoa
where dmsv.Phai = 'Nữ'
group by DMKhoa.TenKhoa
 having count(dmsv.Phai) >= 2
;

-- 37.Cho biết những khoa có 2 hoc sinh đạt học bổng từ 200.000 đến 300.000.

    select DMKhoa.TenKhoa

    from dmsv join DMKhoa on DMKhoa.MaKhoa = dmsv.MaKhoa
    where HocBong between 100000 and 300000;

-- 38.Cho biết số lượng sinh viên đậu (>5) và số lượng sinh viên rớt của từng môn
-- trong lần thi 1.

select (select count(dmsv.MaSV) from dmsv
                                          join KetQua on KetQua.MaSV = dmsv.MaSV
         where KetQua.Diem >= 5 and  LanThi = 1 ) as SinhVienDau,
    (select count(dmsv.MaSV) from dmsv
                                join KetQua on KetQua.MaSV = dmsv.MaSV
                                where KetQua.Diem < 5 and LanThi = 1)
     as SinhVienRot;

-- 39.Cho biết sinh viên nào có học bổng cao nhất.

    select TenSV from dmsv

    order by HocBong desc
    limit 1;



-- 40.Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất.

    select dmsv.TenSV
        from dmsv
   where MaSV = (select MaSV from KetQua
                                       join DMMH on DMMH.MaMH = KetQua.MaMH
                  where LanThi = 1 and DMMH.TenMH = 'Cơ Sở Dữ Liệu'
                  order by Diem desc
                  limit 1);




-- 41.Cho biết sinh viên khoa anh văn có tuổi lớn nhất.

select  TenSV from dmsv
where MaKhoa = (select MaKhoa from DMKhoa
                where TenKhoa = 'Anh Văn')
group by TenSV
having max(YEAR(CURDATE()) - YEAR(NgaySinh))


    ;

-- 42.Cho biết khoa nào có đông sinh viên nhất.

select TenKhoa from DMKhoa where MaKhoa in (select dmsv.MaKhoa, count(dmsv.MaKhoa) as TotalStudent  from dmsv group by dmsv.MaKhoa);





-- 43.Cho biết khoa nào có đông nữ nhất.
-- 44.Cho biết môn nào có nhiều sinh viên rớt lần 1 nhiều nhất.
-- 45.Cho biết sinh viên không học khoa anh văn có điểm thi môn phạm lớn hơn
-- điểm thi văn của sinh viên học khoa anh văn.
-- 46.Cho biết sinh viên có nơi sinh cùng với Hải.
-- 47.Cho biết những sinh viên nào có học bổng lớn hơn tất cả học bổng của
-- sinh viên thuộc khoa anh văn
-- 48.Cho biết những sinh viên có học bổng lớn hơn bất kỳ học bổng của sinh viên
-- học khóa anh văn
-- 49. ho biết sinh viên nào có điểm thi môn cơ sở dữ liệu lần 2 lớn hơn tất cả điểm
-- thi lần 1 môn cơ sở dữ liệu của những sinh viên khác.
-- 50.Cho biết những sinh viên đạt điểm cao nhất trong từng môn.
-- 51.Cho biết những khoa không có sinh viên học.
-- 52.Cho biết sinh viên chưa thi môn cơ sở dữ liệu.
-- 53.Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2.
-- 54.Cho biết môn nào không có sinh viên khoa anh văn học.
-- 55.Cho biết những sinh viên khoa anh văn chưa học môn văn phạm.
-- 56.Cho biết những sinh viên không rớt môn nào.
-- 57.Cho biết những sinh viên học khoa anh văn có học bổng và những sinh viên
-- chưa bao giờ rớt.
-- 58.Cho biết khoa nào có đông sinh viên nhận học bổng nhất và khoa nào khoa
-- nào có ít sinh viên nhận học bổng nhất.
-- 59.Cho biết 3 sinh viên có học nhiều môn nhất.
-- 60.Cho biết những môn được tất cả các sinh viên theo học.
-- 61.Cho biết những sinh viên học những môn giống sinh viên có mã số A02 học.
-- 62.Cho biết những sinh viên học những môn bằng đúng những môn mà sinh
-- viên A02 học.
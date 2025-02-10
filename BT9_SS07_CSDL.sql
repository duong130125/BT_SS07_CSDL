CREATE TABLE tblPhim (
  PhimID INT PRIMARY KEY AUTO_INCREMENT,
  Ten_phim VARCHAR(30),
  Loai_phim VARCHAR(25),
  Thoi_gian INT
);

CREATE TABLE tblPhong (
  PhongID INT PRIMARY KEY AUTO_INCREMENT,
  Ten_phong VARCHAR(20),
  Trang_thai TINYINT
);

CREATE TABLE tblGhe (
  GheID INT PRIMARY KEY AUTO_INCREMENT,
  PhongID INT,
  So_ghe VARCHAR(10)
);

CREATE TABLE tblVe (
  PhimID INT,
  GheID INT,
  Ngay_chieu DATETIME,
  Trang_thai VARCHAR(20)
);

ALTER TABLE tblGhe
ADD CONSTRAINT FK_PhongID FOREIGN KEY (PhongID)
REFERENCES tblPhong(PhongID);

ALTER TABLE tblVe
ADD CONSTRAINT FK_PhimID FOREIGN KEY (PhimID)
REFERENCES tblPhim(PhimID);

ALTER TABLE tblVe
ADD CONSTRAINT FK_GheID FOREIGN KEY (GheID)
REFERENCES tblGhe(GheID);

-- Dữ liệu cho tblPhim
INSERT INTO tblPhim (Ten_phim, Loai_phim, Thoi_gian) 
VALUES 
('Em bé Hà Nôi', 'Tâm lý', 90),
('Nhiệm vụ bất khả thi', 'Hành động', 100),
('Dị nhân', 'Viễn tưởng', 90),
('Cuốn theo chiều gió', 'Tình cảm', 120);

-- Dữ liệu cho tblPhong
INSERT INTO tblPhong (Ten_phong, Trang_thai)
VALUES 
('Phòng chiếu 1', 1),
('Phòng chiếu 2', 1),
('Phòng chiếu 3', 0);

-- Dữ liệu cho tblGhe
INSERT INTO tblGhe (PhongID, So_ghe)
VALUES 
(1, 'A3'),
(1, 'B5'),
(2, 'A7'),
(2, 'D1'),
(3, 'T2');

-- Dữ liệu cho tblVe
INSERT INTO tblVe (PhimID, GheID, Ngay_chieu, Trang_thai)
VALUES 
(1, 1, '2008-10-20', 'Đã bán'),
(1, 3, '2008-11-20', 'Đã bán'),
(1, 4, '2008-12-23', 'Đã bán'),
(2, 1, '2009-02-14', 'Đã bán'),
(3, 1, '2009-02-14', 'Đã bán'),
(2, 5, '2009-03-08', 'Chưa bán'),
(2, 3, '2009-03-08', 'Chưa bán');

select
tblphim.Ten_phim,
tblphim.Thoi_gian 
from tblphim
order by tblphim.Thoi_gian asc;

select
tblphim.Ten_phim
from tblphim 
order by tblphim.Thoi_gian desc limit 1;

select
tblphim.Ten_phim
from tblphim 
order by tblphim.Thoi_gian asc limit 1;

select
tblghe.So_ghe 
from tblghe
where tblghe.So_ghe like "A%";

alter table tblphong
modify Trang_thai varchar(25);

update tblphong
set Trang_thai = 
case 
when Trang_thai = 0 then  "Dang sua"
when Trang_thai = 1 then "Dan su dung"
when Trang_thai = null then  "Unknow"
end
where tblphong.PhongID > 0;

select
tblphim.Ten_phim
from tblphim
where length(tblphim.Ten_phim) between 15 and 25;

select
concat(Ten_Phong, " - ",Trang_Thai) as "Trang thai phong chieu"
from tblphong;

alter table tblphim
add column Mo_ta varchar(255);

update tblphim
set Mo_ta = concat("Day la bo phim the loai", " ", tblphim.Loai_Phim)
where tblphim.PhimID > 0;
select *from tblphim;

update tblphim
set Mo_ta = replace(Mo_ta,'bo phim','film')
where tblphim.PhimID > 0;

select table_name, constraint_name
from information_schema.key_column_usage
where referenced_table_name is not null
and table_name in ('tblghe', 'tblve');

alter table tblghe drop foreign key fk_phongid;
alter table tblve drop foreign key fk_phimid;
alter table tblve drop foreign key fk_gheid;


delete from tblghe;

select 
  Ngay_chieu as "Ngày giờ hiện chiếu",
  DATE_ADD(Ngay_chieu, interval 5000 minute) as "Ngày giờ chiếu + 5000 phút"
from tblVe;


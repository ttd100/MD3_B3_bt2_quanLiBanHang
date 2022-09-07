SELECT * FROM md3_b3_th1_csdl_qlsv.students;
create database QuanLiBanHang;
use QuanLiBanHang;
create table customer(
cid int primary key auto_increment,
name varchar(25),
cAge tinyint
);
insert into customer(name,cAge) values 
('Minh Quan',10),
('Ngoc Oanh',20),
('Hong Ha',50)
;
create table pOrder(
oID int primary key auto_increment,
cID int,
oDate datetime,
oTotalPrice int default null,
foreign key (cid) references customer(cid)
);
insert into porder(cid,odate)values
(1,'2006-3-21'),
(2,'2006-3-23'),
(1,'2006-3-16')
;

create table Product(
pID int primary key auto_increment,
pName varchar(25),
pPrice int 
);
insert into Product(pName,pPrice) values
('May Giat',3),
('Tu Lanh',5),
('Dieu Hoa',7),
('Quat',1),
('Bep Dien',2)
;
create table OrderDetail(
oID int,
pID int, 
odQTY int,
foreign key(oID) references porder(oID),
foreign key(pID) references product(pID)
);
insert into OrderDetail(oID,pID,odQTY)values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,	3,3)
;

-- Hitển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select oID,oDate,oTotalPrice from porder;
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select cu.*,p.pName,p.pPrice from 
orderdetail od join product p on p.pid = od.pid
join porder po on po.oid = od.oid
join customer cu on cu.cid = po.cid;
-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select name from customer
where cid not in (select cid from porder);
select * from orderdetail;
-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. 
-- Giá bán của từng loại được tính = odQTY*pPrice)
select od.pid,sum(od.odqty)as sum, p.pprice,sum(od.odqty)*p.pprice as total
 from orderdetail od
join product p on p.pid = od.pid
join porder po on po.oid = od.oid
join customer cu on cu.cid = po.cid
group by od.pid



create database veebipoodBaka;
use veebipoodBaka;
--tabel Categories
create table categories(
category_id int primary key identity(1,1),
category_name varchar(30) unique);

insert into categories(category_name)
values ('T-särk'),
('Särk'),
('Püksid'),
('lühike püksid'),
('pusa');

select * from categories;
--tabel brands
create table brands(
brand_id int primary key identity(1,1),
brand_name varchar(30) unique);

insert into brands(brand_name)
values ('Adidas'),
('Nike'),
('NewBalance'),
('Puma'),
('Gucci');

select * from brands;

--tabel Products
create table products(
product_id int primary key identity(1,1),
product_name varchar(50) not null,
brand_id int,
category_id int,
foreign key (category_id) references categories(category_id),
model_year int,
list_price decimal(7,2));


alter table products add constraint fk_brand
foreign key (brand_id) references brands(brand_id);
insert into products


select * from products;
select * from brands;
select * from categories;


insert into products(product_name, brand_id,category_id, model_year, list_price)
values ('hea püksid', 1, 3, 2025, 25.99),
 ('krutaya T-särk', 5, 1, 2026, 99.99),
 ('suve lühike püksid', 3, 4, 2020, 5.99),
 ('adidas pusa', 1, 5, 2021, 15.99);


--tabel stocks --kaks primary key
create table stocks(
store_id int,
product_id int,
quantity int,
primary key (store_id, product_id),
foreign key (product_id) references products(product_id)
);
select * from stocks

insert into stocks(store_id, product_id, quantity)
values (1, 3, 60),
 (2, 5, 80),
 (3, 1, 70),
 (3, 2, 10),
 (4, 2, 54);

--tabel Stores
create table stores(
store_id int primary key identity(1,1),
store_name varchar(30) not null,
phone varchar(13) unique not null,
email varchar(30)  unique not null,
street varchar(30),
city  varchar(30), 
_state  varchar(30), 
zip_code varchar(10), 
);
alter table stocks add constraint fk_stocks
foreign key (product_id) references products(product_id)

select * from stores
select * from products

insert into stores(store_name, phone, email, street, city, _state, zip_code)
values ('HM', +372123456789, 'hm@gmail.com', 'midagi tee', 'Tallinn', 'Hajrumaa' ,43566),
 ('Bershka', +372123456788, 'bershka@gmail.com', 'mahla tee','Tallinn', 'Hajrumaa',43566),
 ('Zara', +372123456787, 'zara@gmail.com', 'sütiste tee','Tallinn', 'Hajrumaa', 43566),
 ('Gucci', +372123456786, 'gucci@gmail.com', 'vilde tee', 'Tallinn', 'Hajrumaa', 43566),
 ('Nike', +372123456785, 'nike@gmail.com', 'estonia pst', 'Tallinn', 'Hajrumaa', 43566);


 --create tabel staffs
 create table staffs(
staff_id int primary key identity(1,1),
first_name varchar(30) not null,
last_name varchar(30) not null,
phone varchar(13) not null,
email varchar(30)  unique not null,
active bit,
store_id int,
foreign key (store_id) references stores(store_id),
manager_id int);



--create customers
create table customers(
customer_id int primary key identity(1,1),
first_name varchar(30) not null,
last_name varchar(30) not null,
email varchar(30)  unique not null,
street varchar(30),
city  varchar(30),
_state  varchar(30),
zip_code varchar(10),
);


create table orders(
order_id int primary key identity(1,1),
customer_id int,
foreign key  (customer_id) references customers(customer_id),
order_status varchar(30) check(order_status = 'valmis' or order_status = 'töötanisel' or order_status = 'makstud'),
order_date date,
required_date date,
shipped_date date,
store_id int,
foreign key (store_id) references stores(store_id),
staff_id int,
foreign key (staff_id) references staffs(staff_id));



-- order_items
create table order_items(
order_id int,
item_id int,
primary key (order_id, item_id),
product_id int,
foreign key (product_id) references products(product_id),
list_price decimal (7,2),
foreign key (order_id) references orders(order_id),
discount int);

alter table stocks add constraint fk_store
foreign key (store_id) references stores(store_id)






 -- procedure mis lisab INSERT andmeid tabelisse brands
create procedure lisaBrand
@brand_nimi varchar(30)
as
Begin
	insert into brands(brand_name) values (@brand_nimi);
	select * from brands;
end;

-- procedure kutse

exec lisaBrand 'Cropp';

-- procedure mis kustutab DELETE tabelist id järgi
create procedure kustutaBrand
@id int
as 
begin 
select * from brands;
delete from brands where brand_id=@id;
select * from brands;
end;
-- kutse
exec kustutaBrand 6;
exec kustutaBrand @id=6;

-- procedure mis otsib 1 tähte järgi brandinimed
create procedure otsing1tahte
@taht char(1)
as
begin
select * from brands where brand_name like @taht+'%';
end;
--kutse
exec otsing1tahte 'a';

--procedure mis uuendab UPDATE brandinimi id järgi
create procedure uuendaBrand
@id int,
@uus_brandNimi varchar(30)
as 
begin 
select * from brands;
update brands set brand_name =@uus_brandNimi 
where brand_id=@id;
select * from brands;
end;
--kutse
exec uuendaBrand 1, 'Abibas';

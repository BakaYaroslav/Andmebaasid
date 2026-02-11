create database veebipoodBaka2;
use veebipoodBaka2;
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

insert into products(product_name, brand_id,category_id, model_year, list_price)
values ('hea püksid', 1, 3, 2025, 25.99),
 ('krutaya T-särk', 5, 1, 2026, 99.99),
 ('suve lühike püksid', 3, 4, 2020, 5.99),
 ('adidas pusa', 1, 5, 2021, 15.99);

select * from products;
select * from brands;
select * from categories;







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


--iseseisev töö tabeli categories jaoks

 -- procedure mis lisab INSERT andmeid tabelisse brands
create procedure lisaCategory
@category_nimi varchar(30)
as
Begin
	select * from categories;
	insert into categories(category_name) values (@category_nimi);
	select * from categories;
end;

-- procedure kutse

exec lisaCategory 'uss püksid';

-- procedure mis kustutab DELETE tabelist id järgi
create procedure kustutaCategory
@id int
as 
begin 
select * from  categories;
delete from categories where category_id=@id;
select * from  categories;
end;
-- kutse
exec kustutaCategory 6;



--procedure mis uuendab UPDATE categorynimi id järgi
create procedure uuendaCategory
@id int,
@uus_categoryNimi varchar(30)
as 
begin 
select * from categories;
update categories set category_name=@uus_categoryNimi 
where category_id=@id;
select * from categories;
end;
--kutse
exec uuendaCategory 1, 'kindaid';



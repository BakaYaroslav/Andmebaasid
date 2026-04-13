create database BakaTrigger;
use BakaTrigger;
--tabel linnad
create table linnad(
LinnId int primary key identity(1,1),
linnaNimi varchar(50) unique,
rahvaarv int  not null);


--tabel logi
create table logi(
Id int primary key identity(1,1),
kuupaev datetime,
andmed text);


--Insert triger
create trigger linnaLisamine 
on linnad 
for insert
as 
insert into logi(kuupaev, andmed)
select 
getdate(), inserted.linnanimi
from inserted


--kontrollimiseks tuleb lisada uus linn tabelisse linnad
insert into linnad (linnanimi, rahvaarv)
values ('Pärnu', 20000);
select * from linnad;
select * from logi;


--kustutamine triger
drop trigger linnaLisamine

--Insert triger
create trigger linnaLisamine 
on linnad 
for insert
as 
insert into logi(kuupaev, andmed)
select 
getdate(), 
concat('lisatud linn: ', inserted.linnanimi, ' | rahvaarv: ', inserted.rahvaarv, ' | Id: ', inserted.LinnId)
from inserted

-- delete trigger
create trigger linnaKutsutamine
on linnad 
for delete
as 
insert into logi(kuupaev, andmed)
select 
getdate(), 
concat('kustutanud linn: ', deleted.linnanimi, ' | kustutanud  rahvaarv: ', deleted.rahvaarv, ' | kustutanud Id: ', deleted.LinnId)
from deleted

delete from linnad where LinnID = 2;

select * from linnad;
select * from logi;

-- update trigger
create trigger linnaUueandamine
on linnad 
for update
as 
insert into logi(kuupaev, andmed)
select 
getdate(), 
concat('vana linna andmed: ',  d.rahvaarv, ' | Id: ', d.LinnId , '| uued linna andmed: ',  i.rahvaarv, ' | Id: ', i.LinnId)
from deleted d inner join inserted i 
on d.LinnId=i.LinnId;

select * from linnad;

update linnad set linnanimi = 'Tapa uus', rahvaarv = 25
where linnID = 2;
select * from linnad;
select * from logi;

-- lisamine kasutajaNimi logi tabelisse 
alter table logi add kasutaja varchar(40);

update logi set kasutaja = system_user


--Insert delete triger
create trigger linnaLisamineKustutamine
on linnad 
for insert, delete
as 
begin
set nocount on;

	insert into logi(kuupaev, andmed, kasutaja)
	select 
	getdate(), 
	concat('lisatud linn: ', inserted.linnanimi, ' | rahvaarv: ', inserted.rahvaarv, ' | Id: ', inserted.LinnId),
	SYSTEM_USER
	from inserted

	union all 

	select
	getdate(), 
	concat('kustutatud linn: ', deleted.linnanimi, ' |  rahvaarv: ', deleted.rahvaarv, ' | Id: ', deleted.LinnId),
	SYSTEM_USER
	from deleted;
end;

disable trigger linnaLisamine on linnad
disable trigger linnaKutsutamine on linnad

--kontroll

insert into linnad (linnanimi, rahvaarv)
values ('Pärnu2', 20000);
select * from linnad;
select * from logi;


delete from linnad where LinnID = 3;
select * from linnad;
select * from logi;



create table Autoo(
autoID int primary key identity(1,1),
autoNR char(6),
omanik varchar(30),
mark varchar(30),
aasta int
);
--tabel logi
create table logiAuto(
Id int primary key identity(1,1),
kuupaev datetime,
andmed text,
kasutaja varchar(40)
);

--drop table logiAuto


--Insert triger
create trigger AutoLisamine 
on Autoo
for insert
as 
insert into logiAuto(kuupaev, andmed, kasutaja)
select 
getdate(), 
concat('lisatud auto: ', inserted.autoNR, ' | rahvaarv: ', inserted.omanik,'| mark: ', inserted.mark, ' | Id: ', inserted.AutoID),
System_user
from inserted

insert into autoo (autoNR, omanik, mark, aasta)
values ('123ABC', 'Yarik Baka', 'Toyota', 2018);

select * from Autoo
select * from logiAuto


-- delete tigger
create trigger AutoKustutamine 
on Autoo
for delete
as 
insert into logiAuto(kuupaev, andmed, kasutaja)
select 
getdate(), 
concat('Kustutatud auto: ', deleted.autoNR, ' | rahvaarv: ', deleted.omanik,'| mark: ', deleted.mark, ' | Id: ', deleted.AutoID),
System_user
from deleted

drop trigger AutoKustutamine 

delete from Autoo where AutoID = 2;

select * from Autoo
select * from logiAuto


create trigger AutoUuendamine
on Autoo
for update
as 
insert into logiAuto(kuupaev, andmed, kasutaja)
select 
getdate(), 
concat('Uus auto: ', i.autoNR, ' | rahvaarv: ', i.omanik,'| mark: ', i.mark, ' | Id: ', i.AutoID, 
'Vana auto: ', d.autoNR, ' | rahvaarv: ', d.omanik,'| mark: ', d.mark, ' | Id: ', d.AutoID),
System_user
from deleted d inner join inserted i 
on d.AutoID=i.AutoID;

update Autoo 
SET AutoNR = '321ABC' WHERE AutoID = 3
select * from Autoo
select * from logiAuto

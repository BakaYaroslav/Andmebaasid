create database raamatYarik;
use raamatYarik;

--tabeli zant loomine
create table zanr(
zanrID int primary key identity(1,1),
zanrNimetus varchar (50) not null,
kirjeldus text);
select * from zanr;

--tabeli täitmine
insert into zanr(zanrNimetus, kirjeldus)
values ('drama','emotsioonalne zanr')

--tabel autor
create table autor(
autorID int primary key identity(1,1),
eenimi varchar (50),
perenimi varchar (50) not null,
synniaasta int check (synniaasta >1900),
elukoht varchar (30)
);

select * from autor;
insert into autor(eenimi, perenimi, synniaasta)
values ('Juhan','Sütiste',1911);
select * from autor;
--tabeli uuendamine
update autor set elukoht = 'Tallinn'

--kustutamine tabelist
delete from zanr where zanrID = 2



--tabel raamat

create table raamat(
raamatID int primary key identity(1,1),
raamatNimetus varchar (100) unique,
lk int,
autorID int,
foreign key(autorID) references autor(autorID),
zanrID int,
foreign key(zanrID) references zanr(zanrID),
);


select * from autor;
select * from zanr;

insert into raamat (raamatNimetus, lk, autorID, zanrID)
values ('Eneida', 200, 5, 1),
('Muutumine', 250, 4, 4),
('Zahar Berkut', 500, 6, 5)

select * from raamat;


create table trykikoda
(
	trykikodaID int primary key identity(1,1),
	nimetus varchar(50) unique,
	address varchar(40)
);

select * from trykikoda;

insert into trykikoda(nimetus, address)
values('K-print', 'Tallinn'),
('Uniprint', 'Tallinn'),
('raamaprint', 'Tallinn');

create table trykitudRaamat
(
	trRaamatID int primary key identity(1,1),
	trykikodaID int,
	foreign key (trykikodaID) references trykikoda(trykikodaID),
	raamatID int,
	foreign key (raamatID) references raamat(raamatID),
	kogus int
);

select * from trykitudRaamat;

insert into trykitudRaamat(trykikodaID, raamatID, kogus)
values(1, 2, 500),
(2, 5, 20),
(3, 5, 300);



select * from raamat;



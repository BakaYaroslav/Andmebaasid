create database Baka;
use Baka;


create table kasutaja(
kasutaja_id int primary key identity(1,1),
kasutaja_nimi varchar(30) not null,
parool char(10) not null);

select * from kasutaja

insert into kasutaja (kasutaja_nimi, parool)
values ('oleg', ' testik'), 
('Yarik', ' 12345'),
('Vitalii', ' 0000'),
('kirill', ' 12345k');

--uue veeru lisamine
alter table kasutaja add epost varchar(20);
update kasutaja set epost = 'test1@test.ee' where kasutaja_id = 1;

--veeru kustutamine
alter table kasutaja drop column epost;
--veeru andmetüübi muutmine 
alter table kasutaja alter column parool varchar(25);


--proceduuri tabeli muutmiseks loomine

create procedure alterTable 
@valik varchar(20),
@tabeliNimi varchar(25),
@veeruNimi varchar(25),
@tyyp varchar(20) = null
as
begin
    declare @sql as varchar(max)
	set @sql = case
	when @valik = 'add' then 
	concat('alter table ', @tabelinimi, ' add ', @veerunimi, ' ', @tyyp)
	when @valik = 'drop' then 
	concat('alter table ', @tabelinimi, ' drop column ', @veerunimi)
	when @valik = 'alter' then 
	concat('alter table ', @tabelinimi, ' alter column ', @veerunimi,  ' ', @tyyp)
	END;
	print @sql;
	begin
	exec (@sql);
	END;
end;
--kutse
--lisamine
exec alterTable @valik='add', 
@tabeliNimi='kasutaja',
@veeruNimi='elukoht',
@tyyp='int';
select * from kasutaja;
--kutsutamine
exec alterTable @valik='drop',
@tabeliNimi='kasutaja',
@veeruNimi='mobiil';
select * from kasutaja;
--veeru muutmine
exec alterTable @valik='alter',
@tabeliNimi='kasutaja',
@veeruNimi='elukoht',
@tyyp='varchar(30)';

--proc kustutamine
drop procedure alterTable

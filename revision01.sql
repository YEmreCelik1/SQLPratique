--Database olusturma
create database emre3;

create table subeler(
id char(3),
sube_adi varchar(30),
basari_notu real); 

--VAR OLAN TABLODAN YENI BIR TABLO OLUSTURMA
create table sube 
as
select sube_adi, basari_notu from subeler;
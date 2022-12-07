--*****ALIASES KULLANIMI*****
/*Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir

--iki fields i birlestirme
--Eger iki sutunun verilerini birlestirmek istersek concate sembolu olan || kullaniriz.

*/
CREATE TABLE calisanlar1 
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50) );

INSERT INTO calisanlar1 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar1 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar1 VALUES(345678901, 'Mine Bulut', 'Izmir');
--Calisan_isim ile calisan_dogdugu_sehir field larini birlestirelim
select calisan_id, calisan_isim ||' '||calisan_dogdugu_sehir as isimDogumSehri from calisanlar1;
select calisan_id, calisan_dogdugu_sehir||' '||calisan_isim  as isimDogumSehri from calisanlar1;
select calisan_id, concat (calisan_dogdugu_sehir,' ',calisan_isim) as isimDogumSehri from calisanlar1;

--*****VIEW KULLANIMI***** create view + createIsmi + as + ....
create view bilgileriBirlestirme
as
select calisan_id, concat (calisan_dogdugu_sehir,' ',calisan_isim) as isimDogumSehri from calisanlar1;

create table personel3(
id int,
isim varchar(30),
soyisim varchar(30),
email varchar (45),
tarih date,
unvan varchar(30),
maas real);

insert into personel3 values(12345,'Ali','Can','alican@gmail.com','10-APR-10','isci',5000);
insert into personel3 values(12346,'Veli','Cem','velicem@gmail.com','10-JAN-12','isci',5500);
insert into personel3 values(12347,'Ayse','Gul','aysegul@gmail.com','10-MAY-14','muhasebeci',4500);
insert into personel3 values(12348,'Fatma','Yasa','fatmayasa@gmail.com','10-APR-09','muhendis',7500);
--PRACTICE 8
/*
a) Yukarda verilen “personel” tablosunu olusturun
b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
c) Iscilerin tum bilgilerini listeleyin
d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
e) Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyi   */
--b 
select isim from personel3 where maas<5000 or unvan='isci';
--c
select * from personel3 where unvan='isci';
--d
select unvan,maas from personel3 where soyisim in('Can','Cem','Gul');
--e
select email,tarih from personel3 where maas>5000;
--f
select * from personel3 where maas >5000 or maas<7000;

--***IS NULL CONDITION et IS NOT NULL CONDITION***
--Arama yapilan field’da NULL degeri almis kayitlari getirir.

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

--name sutununda null olan degerleri listeleyelim
select * from insanlar where name is null;
--insanlar tablosunda name i null olmayan name degerleri listeleyelim
select * from insanlar where name is not null;
--insanlar tablosunda null deger almis name verilerini 'no name' olarak degistiriniz.
update insanlar set name = 'no name' where name is null;


--***ORDER BY CLAUSE KULLANIMI****
--ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
--yapmak icin kullanilir.Buyukten kucuge ya da kucukten buyuge siralayabiliriz.Default olarak kucukten buyuge (asc) siralama yapilir.
--Eger buyukten kucuge siralama yapmak istiyorsak ORDER BY komutundan sonra DESC komutunu kullaniriz.
--ORDER BY komutu sadece SELECT komutu Ile kullanilir
--NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
-- eger sutun uzunluguna gore siralamak istersek length(fields) kullaniriz
CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--Insanlar tablosundaki datalari adres’e gore siralayin
select * from insanlar2 order by adres; --alfabetik siralama

--soyisimie gore
select * from insanlar2 order by soyisim;
--Insanlar tablosunda ismi Mine olanlari SSN sirali olarak listeleyelim
select * from insanlar2 where isim='Mine' order by ssn ;
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 
select * from insanlar2 where soyisim='Bulut' order by isim;
--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar2 order by ssn desc;
--Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar2 order by isim asc, soyisim desc;
--İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
select isim, soyisim from insanlar2 order by length(soyisim);
--Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select isim ||' '||soyisim as isimSoyisim from insanlar2 order by length(isim );
select isim ||' '||soyisim as isimSoyisim from insanlar2 order by length(isim || soyisim);
select isim ||' '||soyisim as isimSoyisim from insanlar2 order by length(isim) + length(soyisim);
select concat(isim,' ',soyisim) from insanlar2 order by length(concat(isim,soyisim));


--*****GROUP BY CLAUSE*****
--Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT 
--komutuyla birlikte kullanılır

CREATE TABLE manav
(
isim varchar(50), 
Urun_adi varchar(50), 
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2); 
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4); 
INSERT INTO manav VALUES( 'Ali', 'Armut', 2); 
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3); 
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5); 
INSERT INTO manav VALUES( 'Ali', 'Armut', 2); 
INSERT INTO manav VALUES( 'Veli', 'Elma', 3); 
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);
select * from manav
delete from manav;
--manav tablosunu isim e gore grouplayalim
select isim from manav group by isim; -- burada isimler group landirildi, tek e dusuruldu.
select isim, count(isim) from manav group by isim;
--Isme gore alinan toplam urunleri bulun
select isim, sum(urun_miktar) from manav group by isim;
--Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi,count(isim)  from manav group by urun_adi;
--Alinan kilo miktarina gore musteri sayisi
select urun_miktar, count(isim) from manav group by (urun_miktar);
--isme gore alinan urun miktarlarini listeleyelim
select isim, count(urun_adi) from manav group by isim;



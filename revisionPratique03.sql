--*****SUBQUERIES*****
--SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU’dur.
--1) WHERE’ den sonra kullanilabilir

CREATE TABLE calisanlar2 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1000, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);
select * from calisanlar2;
select * from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin
select isim, maas, isyeri from calisanlar2 where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
select isim,maas, sehir from calisanlar2 where isyeri in(select marka_isim  from markalar where marka_id>101);

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz
select marka_id, calisan_sayisi from markalar where marka_isim in(select isyeri from calisanlar2 where sehir='Ankara');


--***AGGREGATE METOT KULLANIMI ve SUBQUERIES
--calisnalar2 den max maas icin
select max (maas) as max_maas from calisanlar2;
--eger bir sutuna gecici isim vermek isterse AS komutunu yazdiktan sonra gecici isimi yazariz.
--calisanlar2 den min maasi listeleyelim
select min(maas) as min_maas from calisanlar2;
--calisanlar2 deki maaslarin toplamini listeleyelim
select sum(maas) from calisanlar2;

--calisanlar2 deki maaslarin ort. listeleyelim
select avg(maas) from calisanlar2;
select round(avg(maas),2) from calisanlar2;

--calisanlar2 de kac maas alan var
select count(maas) from calisanlar2; --burada maas eger null ise null sayilmaz.
select count(*) from calisanlar2; -- burada ise satirlarin hepsini sayar

select * from calisanlar2;
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id, marka_isim,(select count(sehir)
from calisanlar2 where marka_isim=isyeri) as sehir_sayisi from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi,
(select sum(maas) from calisanlar2 where marka_isim=isyeri) as toplam_maas from markalar;

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim, calisan_sayisi, (select min(maas) from calisanlar2 where marka_isim=isyeri ) as min_maas,
(select max(maas) from calisanlar2 where isyeri=marka_isim) as max_maas from markalar;

--VIEW KULLANIMI
--bir defa view yaptiktan sonra tabloda degisiklk yaparsak mesela bir veri daha eklersek, bu durumda ayri bir isimle tekrar view
--olusturmak gerekiyor.
create view maxminmaas
as
select marka_isim, calisan_sayisi, (select min(maas) from calisanlar2 where marka_isim=isyeri ) as min_maas,
(select max(maas) from calisanlar2 where isyeri=marka_isim) as max_maas from markalar;
select * from maxminmaas;

--*****EXISTS CONDITION*****
/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer olarak, EXISTS ve NOT EXISTS ifadeleri de
alt sorgudan getirilen değerlerin içerisinde bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar.

burada in kullanimindakinden farki; iki tablodaki fields isimleri ortak.
*/
CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(
urun_id int ,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

----MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri
--MART ayında alan MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
--1. yol
select musteri_isim, urun_id from mart where urun_id in (select urun_id from nisan where nisan.urun_id=mart.urun_id);
--2. yol
select musteri_isim,urun_id from mart where exists (select urun_id from nisan where nisan.urun_id=mart.urun_id);

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri NİSAN ayında
--satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select musteri_isim, urun_isim from nisan where exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim);
select musteri_isim, urun_isim from nisan where urun_isim in(select urun_isim from mart where mart.urun_isim=nisan.urun_isim);

--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select musteri_isim, urun_isim from nisan where not exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim);
select musteri_isim, urun_isim from nisan where urun_isim not in(select urun_isim from mart where mart.urun_isim=nisan.urun_isim);




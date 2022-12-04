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


--***AGGREGATE METOT KULLANIMI
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













INSERT INTO personel3 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel3 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel3 VALUES(345678901, 'Mehmet Ozturk','Ankara', 3500, 'Honda'); 
INSERT INTO personel3 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel3 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel3 VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel3 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel3 
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20)
);
select * from personel3;
--Isme gore toplam maaslari bulun
select isim,sum(maas) from personel3 group by (isim);
--sehre gore toplam personel sayisini bulun
select sehir, count(isim) from personel3 group by (sehir);
select sehir, count(id) from personel3 group by (sehir);
--Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
select sirket,count(isim) from personel3 where maas>5000 group by sirket;
select sirket,count(id) from personel3 where maas>5000 group by sirket;
select sirket,count(*) from personel3 where maas>5000 group by sirket;
--Her sirket icin Min ve Max maasi bulun
select sirket,min(maas) from personel3 group by sirket
select sirket,max(maas) from personel3 group by sirket
select sirket,min(maas), max(maas) from personel3 group by sirket;

---*****HAVING CLAUSE KULLANIMI*****
--AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur.
--Sadece group by ile kullaniriz.

--1)Her sirketin MIN maaslarini eger 2000’den buyukse goster
select sirket, min(maas) from personel3 where maas>2000 group by sirket
select sirket, min(maas) from personel3 group by sirket having min(maas)>2000;

--Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi 
--ve toplam maasi gosteren sorgu yaziniz
select isim, sum(maas) from personel3 group by isim having sum(maas)>10000;

--Eger bir sehirde calisan personel sayisi 1’den coksa
--sehir ismini ve personel sayisini veren sorgu yaziniz
select sehir, count(isim) as personel_sayisi from personel3 group by sehir having count(isim)>1;

--Eger bir sehirde alinan MAX maas 5000’den dusukse
-- sehir ismini ve MAX maasi veren sorgu yaziniz
select sehir,max(maas) from personel3 group by sehir having max(maas)<5000;

--*****UNION OPERATOR*****
--Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen field sayis ve data type ayni olmalidir.

--Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
--sehirleri gosteren sorguyu yaziniz
select isim,maas from personel3 where maas>4000
union
select sehir,maas from personel3 where maas>5000;

--Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
--bir tabloda gosteren sorgu yaziniz
select isim, maas from personel3 where isim='Mehmet Ozturk'
union
select isim, maas from personel3 where sehir='Istanbul' order by maas;

select isim, maas from personel3 where sehir='Istanbul' or isim='Mehmet Ozturk';


select * from personel3;

--Sehirlerden odenen ucret 3000’den fazla olanlari ve personelden ucreti 5000’den az
--olanlari bir tabloda maas miktarina gore sirali olarak gosteren sorguyu yaziniz
select sehir, maas from personel3 where maas>3000
union
select isim, maas from personel3 where maas<5000 order by maas;

--2 Tablodan Data Birlestirme
CREATE TABLE personel5
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20),
CONSTRAINT pers_pk PRIMARY KEY (id));

INSERT INTO personel5 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel5 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel5 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel5 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel5 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel5 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel5 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

drop table personel1;
CREATE TABLE personel_bilgi5  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT person_bilgi_fk FOREIGN KEY (id) REFERENCES personel5(id)
);
INSERT INTO personel_bilgi5 VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi5 VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi5 VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi5 VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi5 VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi5 VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi5 VALUES(123456710, '5537488585', 1);

select * from personel5;
select * from personel_bilgi5;

--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi 
--tablosundan da tel ve cocuk sayisini yazdirin

select sehir, maas from personel5 where id=123456789
union
select tel,cocuk_sayisi from personel_bilgi5 where id=123456789;

--*****UNION ALL*****
/*
UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesini alir.
UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.
NOT : UNION ALL ile birlestirmelerde de
1)Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali
2)Alt alta gelecek sutunlarin data type’lari ayni olmal

Union tekrarli verileri teke dusuru ve bize bu sekilde sonuc verir.
Union All ise tekrarli verilerle birlikte tum sorgulari getirir
*/
----Personel tablosunda maasi 5000’den az olan tum isimleri ve maaslari bulunuz
select isim,maas from personel5 where maas<5000;
--Ayni sorguyu UNION ile iki kere yazarak calistirin
select isim,maas from personel5 where maas<5000
union
select isim,maas from personel5 where maas<5000;
--Ayni sorguyu UNION ALL ile iki kere yazarak calistirin
select isim,maas from personel5 where maas<5000
union all
select isim,maas from personel5 where maas<5000;

--Tabloda personel maasi 4000’den cok olan tum sehirleri ve maaslari yazdirin
select sehir,maas from personel5 where maas>4000
--Tabloda personel maasi 5000’den az olan tum isimleri ve maaslari yazdirin
select isim,maas from personel5 where maas<5000
--Iki sorguyu UNION ve UNION ALL ile birlestirin
select sehir,maas from personel5 where maas>4000
union
select isim,maas from personel5 where maas<5000;

select sehir,maas from personel5 where maas>4000
union all
select isim,maas from personel5 where maas<5000;


--*****INTERSECT(KESISIM)*****
/*
Farkli iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz.
*/
--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin
select id from personel5 where sehir in('Istanbul','Ankara')
intersect
select id from personel_bilgi5 where cocuk_sayisi in(2,3);

--) Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini
--listeleyin

--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin

--Iki sorguyu INTERSECT ile birlestiri

--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin









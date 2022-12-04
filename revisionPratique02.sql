--***DML - DELETE - TRUNCATE***
/*
TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını geri alamayacagimiz sekilde siler.
Seçmeli silme yapamaz.
TRUNCATE TABLE where ...... OLMAZ
*/

create table ogrenciler6(
id int,
isim varchar(50),
veli_isim varchar(30),
yazili_notu int);
INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler6 VALUES(128, 'Ali Can', 'Hasan',75);

select * from ogrenciler6;

-- tablodaki verileri truncate ile silme
truncate table ogrenciler6;
truncate ogrenciler6;
select * from ogrenciler6;

--***ON DELETE CASCADE***
/*
- Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz.
Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmak yeterli
-- on delete cascade sayesinde parent taki silinen bir kayıt ile ilişkili olan tüm 
child kayıtlarını silebiliriz. Ancak child dan silersek parent dan silinmiyor, sadece child dan siliniyor.
-- cascade yoksa önce child temizlenir sonra parent
*/
drop table if exists talebeler; -- eger daha once talebeler tablosu varsa siler 
CREATE TABLE talebeler
(
id CHAR(3) primary key, 
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar( 
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) 
REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90); 

select * from talebeler;
select * from notlar;

--notlar tablosundan id si 123 olan datayi silelim.  
delete from notlar where talebe_id='123';
select * from notlar;
select * from talebeler;

--talableer tablosundan id si 126 olan datayi silelim.normalde parent child iliskisi olan tablolarda
                                            --parent dan bir veri silmek icin once child da silmek gerekiyordu.
											--ancak parent tabloyu olustururken sona koydugumuz ON DELETE CASCADE sayesinde
											--parent dan veri silebiliyoruz.Ayrica ayni anda bu veri child dan da silinmis olur
delete from talebeler where id='126';
select * from notlar;
select * from talebeler;

-- Parent tablo ile birlikte child tablo icindeki verileride silelim
delete from talebeler;
select * from notlar;
select * from talebeler;

 -- İlişkili tablolardan parent olan talebeler tablosun ortadan kaldirip notlar tablosunu birakalim
drop table talebeler cascade;
select * from notlar;
select * from talebeler;

--***IN, NOT IN CONDITION***
--IN Condition birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari
--(Condition) tek komutla yazabilme imkani verir

drop table if exists musteriler;
CREATE TABLE musteriler 
(
urun_id int, 
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO  musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

--mustriler tablsoundan urunismi orange apple veya appricot olan datalari listeleyelim
select * from musteriler where urun_isim in('Apple','Orange','Apricot');

--NOT IN
select * from musteriler where urun_isim not in ('Apple','Orange','Apricot');

--***BETWEEN, NOT BETWEEN CONDITION***
--BETWEEN Condition iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla
--yazabilme imkani verir. Yazdigimiz 2 sinirda araliga dahildir (INCLUSIVE)

--example 1 Urun_id 20 ile 40 arasinda olan urunlerin tum bilgilerini listeleyiniz

select * from musteriler where urun_id>=20 and urun_id<=40;
select * from musteriler where urun_id between 20 and 40;

--NOT BETWEEN
--iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek
--komutla yazabilme imkani verir. Yazdigimiz 2 sinirda araliga harictir (EXCLUSIVE)
select * from musteriler where urun_id not between 20 and 40;

CREATE table personel1
(
personel_id char(4),
isim varchar(50),
maas int
);

insert into personel1 values('1001', 'Ali Can', 70000);
insert into personel1 values('1002', 'Veli Mert', 85000);
insert into personel1 values('1003', 'Ayşe Tan', 65000);
insert into personel1 values('1004', 'Derya Soylu', 95000);
insert into personel1 values('1005', 'Yavuz Bal', 80000);
insert into personel1 values('1006', 'Sena Beyaz', 100000);
insert into personel1 values('1004', 'Derya Soylu', 95000);

delete from personel1;
drop table personel1;
select  * from personel1;
-- Example 2 - id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
select * from personel1 where personel_id between '1003' and '1005';

-- Example 3 - D ile Y arasındaki personel bilgilerini listeleyiniz
select * from personel1 where isim between 'D' and 'Y';
-- Example 4 - D ile Y arasında olmayan personel bilgilerini listeleyiniz
select * from personel1 where isim not between 'D' and 'Y';
-- Example 5 - Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
select * from personel1 where (isim='Sena' and maas=70000);
-- Example 6 - Maaşı 70000 veya ismi Sena Beyaz olan personeli listeleyiniz
select * from personel1 where (isim='Sena Beyaz' or maas=70000);

select  * from personel1;










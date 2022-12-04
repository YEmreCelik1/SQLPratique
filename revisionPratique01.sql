create table ogrenciler(
ogrenci_id char(4),
isimSoyisim varchar(25),
notOrtalamasi real,
kayitTarihi date);

--***var olan tablodan yeni tablo olusturma
create table ogrenciOrtalamalar
as select isimSoyisim, notOrtalamasi from ogrenciler;

--***insert (Database e veriekleme)
--tum field lara data eklemek icin;
insert into ogrenciler values('1234','Joyce Jonathan',80.5,now());
--bazi fieldlara data eklemek icin
insert into ogrenciler(ogrenci_id, kayitTarihi) values ('1235','2022-12-03');
select * from ogrenciler;

--example 1 - “tedarikciler” isminde bir tablo olusturun ve “tedarikci_id”, “tedarikci_ismi”, “tedarikci_adres”
--ve “ulasim_tarihi” field’lari olsun.

create table tedarikciler(
tedarikci_id char(5),
tedarikci_ismi varchar(30),
tedarikci_adres varchar(50),
ulasim_tarihi date);

select * from tedarikciler;

--example 2 - “tedarikçi_ziyaret” isminde bir tabloyu “tedarikciler” tablosundan olusturun.
--Icinde “tedarikci_ismi”, “ulasim_tarihi” field’lari olsun.

create table tedarikci_ziyaret as select tedarikci_ismi, ulasim_tarihi from tedarikciler; 
select * from tedarikci_ziyaret;

/*example 3
“ ogretmenler” isminde tablo olusturun. Icinde “kimlik_no”, “isim”, “brans” ve “cinsiyet”
field’lari olsun.
“ogretmenler” tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
Kimlik_no: 23443, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
“ogretmenler” tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
Kimlik_no: 567597624, isim: Ali Veli
*/

create table ogretmenler(kimlik_no char(5), isim varchar(30), brans varchar(30), cinsiyet char(10));
select * from ogretmenler;
insert into ogretmenler values('23443','Ayse Guler','Matematik','kadin');
insert into ogretmenler values('56759', 'Ali Veli');
select * from ogretmenler;

--***Tablodaki Tum ya da bir kisim Field’lari Cagirma
--tum fields lar
select * from ogretmenler;
--bir kisim field lar
select isim, cinsiyet from ogretmenler; 

--***Bir field’in “tekrarsiz” deger almasi nasil saglanir?
--***Bir field’in “NULL” deger almamasi nasil saglanir?
create table ogrenciler1(
id char(5) unique,
isim varchar(30) not null,
adres varchar(50),
notOrtalamasi real);
insert into ogrenciler1 values('1234','emre','lyon',88.8);
insert into ogrenciler1 values('1234','emre','lyon',88.8); --hata verir unique
insert into ogrenciler1 values('1235',null,'lyon',88.8);  -- hata veriri not null
insert into ogrenciler1(id,isim,adres) values('1236','Joyce', 'Lyon');
select * from ogrenciler1;

--NOT: INSERT INTO kodunu kullanarak bir tabloya data eklemek istediginizde, CONSTRAINT’lere uymak zorundayiz.
--Ornegin;NOT NULL yazan kisma bir deger atamak zorundayiz

--example 4 _ Personel isminde bir tablo olusturun, icinde id,isim,soyisim,email,ise_baslama_tarihi ve
--maas fieldlari olsun, isim field’I bos birakilamasin
create table personel(
isim varchar(50) not null,
email varchar(50),
maas real
);

/* ***Bir Tabloya “Primary Key” Nasil Eklenir***
1) Primary Key bir record’u tanimlayan bir field veya birden fazla field’in kombinasyonudur.
2) Primary Key Unique’dir
3) Bir tabloda en fazla bir Primary Key Olabilir
4) Primary Key field’inda hic bir data NULL olamaz
		bir field’ini “primary key” yapmak icin 2 yol var
	1-Data Type’dan sonra “PRIMARY KEY” yazarak.
	2-CONSTRAINT Keyword Kullanilarak Primaray Key Tanimlanabilir
*/
create table ogrenciler2(
ogr_id char(5) primary key,
isim varchar(30) not null,
not_ort real);

select * from ogrenciler2;

create table ogrenciler4(
ogr_id char(5),
isim varchar(30) not null,
not_ort real,
primary key(ogr_id));

create table ogrenciler3(
ogr_id char(5),
isim varchar(30),
not_ort real,
constraint constraint_adi primary key(ogr_id)
); --constraint ogrenciler5 not null(isim) bu calismiyor
select * from ogrenciler3;

/*Example 5 - “sehirler” isimli bir Table olusturun. Tabloda “alan_kodu”, “isim”, “nufus” field’lari olsun.
Isim field’i bos birakilamasin. 1.Yontemi kullanarak “alan_kodu” field’ini “Primary Key” yapin
*/
create table sehirler(
alan_kodu char(3) primary key,
isim varchar(30) not null,
nufus real);

/* ***Tabloya “Foreign Key” Nasil Eklenir ?
 Foreign Key iki tablo arasinda Relation olusturmak icin kullanilir.
 Foreign Key baska bir tablonun Primary Key’ine baglidir.
 Referenced table (baglanilan tablo, Primary Key’in oldugu Tablo) parent table olarak 
adlandirilir. Foreign Key’in oldugu tablo ise child table olarak adlandirilir.
 Bir Tabloda birden fazla Foreign Key olabilir
 Foreign Key NULL degeri alabilir
Note 1: “Parent Table” olmayan bir id’ye sahip datayi “Child Table”’a ekleyemezsiniz
Note 2: Child Table’i silmeden Parent Table’i silemezsiniz. Once “Child Table” silinir, sonra 
“Parent Table” silinir
*/

--Example 6_“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,“iletisim_isim” 
--field’lari olsun ve “tedarikci_id” yi Primary Key yapin. “urunler” isminde baska bir tablo olusturun 
--“tedarikci_id” ve “urun_id” field’lari olsun ve “tedarikci_id” yi Foreign Key yapin.

create table tedarikciler3(
tedarikci_id char(5),
tedarikci_ismi varchar(50),
primary key(tedarikci_id));

create table urunler(
tedarikci_id char(5),
urun_id char(5),
constraint urunlerKisitlamasi foreign key(tedarikci_id) references tedarikciler3(tedarikci_id));

create table urunler1(
tedarikci_id char(5),
urun_id char(5),
foreign key(tedarikci_id) references tedarikciler3(tedarikci_id));

--Example 7
--“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari 
--olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın. “adresler” isminde baska bir tablo olusturun.
--Icinde “adres_id”,“sokak”, “cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.

create table calisanlar(
id char (5) primary key,
isim varchar(50) unique,
maas int not null,
ise_baslama date);

create table adresler(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(25),
foreign key (adres_id) references calisanlar(id) );

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --constraints unique 
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', null, '2019-04-12');  --not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --constraints unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --syntax hatasi
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --constraints primary key
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --constraints primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');   --constraints primary key

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep'); --La clé (adres_id)=(10012) n'est pas présente dans la table « calisanlar ».
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar;
select * from adresler;

/*  ***Tabloya “CHECK Constraint” Nasil Eklenir ?***
	CHECK ile bir alana girilebilecek değerleri sınırlayabiliriz.
Mesela tablomuzda YAŞ bir alanı number data tipinde yani sayısal alan olarak 
belirlemiş olabiliriz. Ancak bu alan negatif sayı girilmesi anlamsız olacağı için 
CHECK yapısını kullanarak negatif giriş yapılmasını engelleyebiliriz.
*/

--sehirler2 tablosu olusturalim, nufusun negatif deger girilmemesi icin sinirlandirma (Constraint) koyali

create table sehirler2(
alan_kodu int primary key,
isimi varchar(30),
nufus int check(nufus>0));

insert into sehirler2 values(1234,'lyon',-123); -- check hatasi yani nufus negatif olamaz
insert into sehirler2 values(1234,'lyon',5678);


create table sehirler3(
alan_kodu int check(alan_kodu>0) primary key,
isimi varchar(30),
nufus int check(nufus>0)not null);

insert into sehirler3 values(1234,'lyon',6789);
insert into sehirler3 values(-123,'lyon',6789); --check hatasi alan_kodu negatif olamaz
insert into sehirler3 values(1235,'lyon',null); --nufus null olamaz

--***DQL - SELECT KOMUT***
select * from calisanlar;

--Tablodan sadece maas’ı 5000 den buyuk olanlarin isim ve maas field’larindaki datalari getirelim
select isim,maas from calisanlar where maas>5000;
--Tablodan sadece maas’ı 5000 den buyuk olanlarin datalarini getirelim
select * from calisanlar where maas>5000;
--Tablodan adres ve isim field’indaki tum datalari getirelim ???????????????
select isim,(select * from where (id=adres_id) ) from calisanlar;
--calisanlar tablosundan ismi Veli Han olan tum verileri listeleyelim
select * from calisanlar where isim='Veli Han';

--calisanlar tablosundan maasi 5000 olan tum verileri listeleyelim
select * from calisanlar where maas=5000;

--****DML - DELETE KOMUTU
-- DELETE FROM tablo_adı; Tablonun tüm içerğini siler.
-- Veriyi seçerek silmek için WHERE komutu kullanılır
--* DELETE FROM tablo_adı WHERE sutun_adi = veri; 
--Tabloda istediğiniz veriyi siler.

delete from calisanlar;
delete from adresler;

select * from adresler;
select *from calisanlar;
--adresler tablosundan sehri Antep olan verileri silelim
delete from adresler where sehir='Antep';

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

-- id'si 124 olan ogrenciyi siliniz.
delete from ogrenciler6 where(id=124);
select * from ogrenciler6;

-- ismi Kemal Yasa olan satırını siliniz
delete from ogrenciler6 where(isim='Kemal Yasa');
select * from ogrenciler6;

---- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
delete from ogrenciler6 where(isim='Nesibe Yilmaz' or isim='Mustafa Bak');
select * from ogrenciler6;

-- İsmi Ali Can ve id'si 123 olan kaydı siliniz.
delete from ogrenciler6 where(isim='Ali Can' and id=123 );
select * from ogrenciler6;
-- id 'si 126'dan büyük olan kayıtları silelim.
delete from ogrenciler6 where(id>126);
select * from ogrenciler6;
-- id'si 123, 125 veya 126 olanları silelim.
delete from ogrenciler6 where(id=123 or id=125 or id=126);
select * from ogrenciler6;
USE sys;

/* ======================== ALIASES ===========================
   Aliases kodu ile tablo yazdirilirken, field isimleri sadece
   o cikti icin degistirilebilir.
===============================================================*/
CREATE TABLE employees
(
employee_id char(9),
employee_name varchar(50),
employee_birth_city varchar(50)
);

INSERT INTO employees VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO employees VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO employees VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM employees;

SELECT employee_id 
AS id, employee_name 
AS isim ,employee_birth_city 
AS city
FROM employees;

/* ======================== GROUP BY CLAUSE ===========================
1- GROUP By komutu sonuclari bir veya daha fazla sutuna goregruplamak icin SELECT komutuyla birlikte kullanilir.
2- GROUP BY komutu her grup basina bir satir dondurur.
3- GROUP BY AGGREGATE fonksiyonlariyla birlikte kullanilir.
*/
CREATE TABLE manav (
    isim VARCHAR(50),
    urun_adi VARCHAR(50),
    urun_miktar INT
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
INSERT INTO manav VALUES( 'Ali', null, 2);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 1);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 4);
INSERT INTO manav VALUES( 'Ayse', null, 3);

SELECT * FROM manav;

-- Soru1: Urun adina gore alinan urunlerin toplam kilosunu listeleyin.
SELECT urun_adi, SUM(urun_miktar)toplam_kg
FROM manav
GROUP BY urun_adi;

-- Soru2: Isme gore, alinan urunlerin toplam kilosunu bulup, isim sirasina gore siralayin.
SELECT isim, SUM(urun_miktar)toplam_kg
FROM manav
GROUP BY isim
ORDER BY isim;

-- Soru3: Isme gore, alinan urunlerin toplam kilosunu bulup, isim sirasina gore ters siralayin. 
SELECT isim, SUM(urun_miktar)toplam_kg
FROM manav
GROUP BY isim
ORDER BY isim DESC;

-- Soru4: Bunlari bir de toplam kiloya gore ters sirali yapalim
SELECT isim, SUM(urun_miktar)toplam_kg
FROM manav
GROUP BY isim
ORDER BY toplam_kg DESC;

-- Soru5: Urun ismine gore urun satin alan toplam kisi sayisini kisi sayisina gore siralayiniz.
SELECT urun_adi, COUNT(isim)kisi_sayisi
FROM manav
GROUP BY urun_adi
ORDER BY kisi_sayisi;

-- Soru6: Alinan kilo miktarina gore musteri sayisini, urun_miktar sirasina gore listeleyiniz.
SELECT urun_miktar, COUNT(isim) kisi_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY urun_miktar;

-- Soru7: Satilan meyve turune (urun_adi) gore urun alan kisi sayisini, urun_adi NATURAL ORDER'a gore gosteren QUERY yaziniz. ASC
SELECT urun_adi, COUNT(isim)kisi_sayisi
FROM manav
GROUP BY urun_adi
ORDER BY urun_adi;

-- Soru8: Satilan meyve turune (urun_adi) gore urun alan kisi sayisini, urun_adi NATURAL ORDER'a gore gosteren QUERY yaziniz.
SELECT urun_adi, COUNT(isim)kisi_sayisi
FROM manav
WHERE urun_adi IS NOT NULL
GROUP BY urun_adi
ORDER BY urun_adi;

-- Soru9: Satilan meyvenin 4 harfli olmasina (urun_adi) gore urun alan kisi sayisini, urun_adi NATURAL ORDER'a gore gosteren QUERY yaziniz.
SELECT urun_adi, COUNT(isim) kisi_sayisi
FROM manav
WHERE urun_adi LIKE '____'
GROUP BY urun_adi
ORDER BY urun_adi;

/*======================== HAVING CLAUSE ======================= 
HAVING, AGGREGATE FUNCTION'lar ile birlikte kullanilan FILTRELEME komutudur.

Aggregate fonksiyonlar ile ilgili bir kosul koymak icin GROUP BY'dan sonra HAVING cumlecigi kullanilir.

Yeni create ettigimiz bir field uzerinden filtreleme yapmak istiyorsak WHERE cumlecigini kullanamayiz.
 
WHERE cumlecigi sadece  database de var olan fieldlar uzerinde bir filtreleme yapar.    
===============================================================*/
CREATE TABLE isciler
(
	id int,
	isim varchar(50),
    sehir varchar(20),
    maas int,
	sirket varchar(20)
);

INSERT INTO isciler VALUES 
(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'),
(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'),
(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'),
(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'),
(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'),
(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'),
(123456710, 'Hatıce Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM isciler;

-- Soru1: Sirketlere gore toplam isci sayisini listeleyiniz
SELECT sirket, COUNT(isim)isci_sayisi
FROM isciler
GROUP BY sirket;
 
-- Soru2: Sirketlere gore isci_sayisini 1'den buyukse yazdiriniz
SELECT sirket, COUNT(isim)isci_sayisi
FROM isciler
GROUP BY sirket
HAVING isci_sayisi > 1;

-- Soru3: (Ayni isimlere gore sorguyu yaziniz) Toplam geliri 8000 liradan fazla olan isimleri gosteren sorgu yaziniz
SELECT isim, SUM(maas)toplam_maas
FROM isciler
GROUP BY isim
HAVING toplam_maas > 8000;

-- Soru4: Eger bir sehirde alinan MAX maas 5000'den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir, MAX(maas)max_maas
FROM isciler
GROUP BY sehir
HAVING max_maas < 5000;

-- Soru5: Eger bir sehirde alinan MAX maas 5000'den buyukse sehir ismi 'i' harfi ile basliyorsa o sehirleri ve MAX maasi, maas sirali veren sorgu yaziniz
SELECT sehir, MAX(maas)max_maas
FROM isciler
WHERE sehir LIKE 'i%'
GROUP BY sehir
HAVING max_maas > 5000
ORDER BY max_maas;

/*============================ LIMIT ===========================
>Tablodaki verilerin belli bir kismini listelemek icin LIMIT
 komutunu kullaniriz.
 
>LIMIT komutundan sonra kullandigimiz sayi kadar kaydi bize getirir.

>Eger belirli bir aralikta calismak istiyorsak bu durumda 
iki sayi gireriz, ancak bu sayilardan ilki baslangic noktamizi 
ifade ederken ikincisi kac kayit getirecegimizi belirtir. Baslangic 
noktasi dahil edilmez!
===============================================================*/
-- Soru1: Isciler tablosundan ilk 5 kaydi getiriniz.
SELECT * 
FROM isciler
LIMIT 5;

-- Soru2:  Isim sirali tablodan ilk 3 kaydi listeleyin.
SELECT isim 
FROM isciler
ORDER BY isim
LIMIT 3;

-- Soru3: Maas sirali tablodan 4. kayittan 7. kayda kadar olan (7. dahil degil) kayitlarin isim ve sehir bilgilerini listeleyin.
SELECT isim, sehir
FROM isciler
ORDER BY maas
LIMIT 3,3;

/*====================== LIMIT VE OFFSET =====================
LIMIT = Bize kac adet data gelecegini belirliyor
OFFSET = Kac adet verinin atlanacagini belirler.
=============================================================*/
-- Soru1: Maas sirali tablodan 4. kayittan 7. kayda kadar olan (7. dahil degil) kayitlarin isim ve sehir bilgilerini listeleyin.
SELECT isim, sehir
FROM isciler
ORDER BY maas
LIMIT 3 OFFSET 3;

-- Soru2: Bu ornekte OFFSET ile ilk 3 satir atlandi LIMIT ile 4. 5. 6. siradaki datalar goruntulendi.
SELECT isim, sehir
FROM isciler
ORDER BY maas
LIMIT 1111111111111 OFFSET 5;

-- Soru3: Maasi en yuksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz.
SELECT * 
FROM isciler 
ORDER BY maas DESC
LIMIT 3;

-- Soru4: Maasi en yuksek kisiler listesinden 3. sirada olan ismi listeleyen sorguyu yaziniz.
SELECT isim
FROM isciler
ORDER BY maas DESC
LIMIT 2,1;

SELECT isim
FROM isciler
ORDER BY maas DESC
LIMIT 1 OFFSET 2;

-- Soru5: Maas'i 4000'den yuksek olan ılk 3 kisinin sehrini listeleyin.
SELECT sehir, isim
FROM isciler
WHERE maas>4000
ORDER BY maas DESC
LIMIT 3;

/*=========================DISTINCT===========================
DISTINCT cumlecıgı bir sorgu ifadesinde benzer olan kayitlari 
filtrelemek icin kullanilir. 
Dolayisiyla secilen sutun veya sutunlar icin benzersiz (UNIQUE)
veri iceren satirlari olusturmaya yarar.
------- SYNTAX----------
SELECT DISTINCT field1, field2 ......
FROM table_name  
============================================================*/
-- Soru6: Iscileri yasadiklari sehirler ile tekrarsiz listeleyiniz
SELECT DISTINCT isim, sehir
FROM isciler; 

-- Soru7: manav tablosunda satilan farkli meyve turlerini listeleyen bir query yaziniz
SELECT urun_adi 
FROM manav
GROUP BY urun_adi;   -- Gruplama syntax yapisidir.

SELECT DISTINCT urun_adi  -- dogru syntax yapisi budur.
FROM manav;

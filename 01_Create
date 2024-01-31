USE sys;

/*===============================================
		TABLO OLUSTURMA (CRUD - Create)
 ------------------ Syntax ----------------------
CREATE TABLE table_name
(
field_name DATATYPE,
field_name DATATYPE,
field_name DATATYPE,
field_name DATATYPE,
field_name DATATYPE,
);
-------------------------------------------------
===============================================*/

-- Soru1: id, isim, not ortalamasi, adres ve son degistirme tarihi fieldlari iceren bir ogrenciler tablosunu olusturun.
CREATE TABLE ogrenciler 
(
id CHAR(4),
isim VARCHAR(20),
not_ortalamasi DOUBLE,
adres VARCHAR(100),
son_degistirme_tarihi DATE
);

SELECT * FROM ogrenciler;

CREATE TABLE tedarikciler (
tedarikci_id CHAR(4),
tedarikci_isim VARCHAR(20),
tedarikci_adres VARCHAR(100),
ulasim_tarihi DATE
);

SELECT * FROM tedarikciler;

/*--------------------- Syntax -------------------
	CREATE TABLE table_name
	AS
	SELECT field1, field2
	FROM other_table_name;
--------------------------------------------------*/

-- Soru2: Ogrenciler tablosundan isim ve not_ortalamasi field'larini alarak ogrenci_derece isimli yeni bir tablo olusturun.
CREATE TABLE ogrenci_derece
AS
SELECT isim, not_ortalamasi
FROM ogrenciler;

SELECT * FROM ogrenci_derece;

-- Soru3: tedarikciler table'indan tedarikci_ismi ve ulasim_tarihi field'larini alarak tedarikciler_son isminde yeni bir table olusturun.
CREATE TABLE tedarikciler_son
AS
SELECT tedarikci_isim, ulasim_tarihi 
FROM tedarikciler;

SELECT * FROM tedarikciler_son;

-- Soru4 : musteri_id(int), isim(varchar), email(varchar) ve dogum_tarihi(date) fieldlari iceren bir musteriler tablosunu olusturun.
CREATE TABLE musteriler
(
	musteri_id INT ,
    isim VARCHAR(50),
    email VARCHAR(25),
    dogum_tarihi DATE
);

SELECT * FROM musteriler;

-- Soru5 : oluşturduğunuz musteriler tablosunu kullanarak sadece isim ve email sütunlarını içeren iletisim_bilgileri adında yeni bir tablo oluşturun. Bu yeni tablonun ayrıca 'id' adında bir sütunu olmalıdır.
CREATE TABLE iletisim_bilgileri
(id INT)
AS
SELECT isim, email 
FROM musteriler; 

SELECT * FROM iletisim_bilgileri;

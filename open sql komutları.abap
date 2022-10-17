se38 ile

# Variable #
Data: gv_persid TYPE zgk_persi_de,
      gv_perad  TYPE zgk_persad_de,// gv Variable için.
      gs_pers_t  TYPE zgk_pers_t,// gs Structure için.
      gt_pers_t    TYPE TABLE OF zgk_pers_t.// gt Table için.

# SELECT #
SELECT * FROM zgk_pers_t//tüm kolonları çeker.
INTO TABLE gt_pers_t.
//Where yapısı
select single * from tableName into gs_per_t where kolonAd EQ deger.

SELECT SINGLE * FROM zgk_pers_t//Sıngle:tek bir satırı tutar.
INTO gs_pers_t.

SELECT SINGLE pers_id FROM zgk_pers_t//pers_id tek alır.
INTO gv_persid.

# update #
      UPDATE zgk_pers_t SET PERS_AD = 'Buse'
      WHERE pers_id EQ 1.//id 1 olan personel yerine buse adı gelir.(EQ =key anahtar)
           write : 'update komutu çalıştı'.

//Update ve delte komutu normal sql komutu ile aynıdır.

//Modify komutu o structure içindeki key e sahip bi deger varsa update yapar yoksa insert işlemi yapar
modify tableName from gs_per_t.







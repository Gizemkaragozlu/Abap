se38:program oluşturma
# parameters #
PARAMETERS:p_num1 TYPE int4.// üst menüden git-> metin sembolü->selection texts kısmından text düzeltebiliriz.
örneğin: yaşınız yazıp kaydedince p_num1 yazan kısım yaşınız olarak değişir.
 p_persad TYPE zgk_persad_do.//önceden oluşturduğumuz tablodan persad alıyoruz.
selection texts kısmından p_persad //yazan yeri adınız olarak değiştirebiliriz.

# select option #
TABLES: ZGK_PERS_T.//Tables: veritabanıTabloAdı.//tabloyu kullanıyorum demek için.
data:gv_psrsoyad type zgk_perssoyad_do
select option:s_perssd//8 karakter olmalı yoksa hata verir. FOR  gv_psrsoyad.//gv olan kısım için üstte data eklemeliyiz.
s_perscn for zbk_pers_t-pers_cıns.//personel tablosundan cinsiyet kolonun alır.

# checkbox #
PARAMETERS: p_cbox1 AS CHECKBOX.// 

# radio button #
parameters: p_rad1  RADIOBUTTON GROUP gr1,
            p_rad2 RADIOBUTTON GROUP gr1,//gr2 yazarsak ikinci bir grup olur.
            p_rad3 RADIOBUTTON GROUP gr1.

# selection screen #
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.//başlat
SELECTION-SCREEN END OF BLOCK bl1.//bitir

SELECTION-SCREEN: BEGIN OF BLOCK b1  WITH FRAME TITLE text-001.//Başlik .

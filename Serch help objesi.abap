adım 1:se11 ile serch help seçelim.
adım 2:hangi tabloya serch help yapmak isteniyorsa selection methoda yazılır.
adım 3: parameter kısmından serch help parameter yani kolon adlarımızı yazalım.
adım 4: se38
*&---------------------------------------------------------------------*
*& Report ZGK_SERCH_HELP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zgk_serch_help.
* "// matchcode object serch help çağırmak için yazılır se11'den zgk_egt_01sh. serch help oluşturduğum isim
*parameters: p_depok type zgk_depokodu_dt matchcode object zgk_egt_01sh.
*parameters: p_fabad type zgk_firmaad_dt matchcode object zgk_egt_01sh.
*parameters: p_mno type zgk_malzemeno_dt matchcode object zgk_egt_01sh.

parameters: p_depok type zgk_depokodu_dt. "// zgk_depokodu_dt çift tıkla further kısmında teker teker tanımla
parameters: p_fabad type zgk_firmaad_dt.
parameters: p_mno type zgk_malzemeno_dt.


START-OF-SELECTION

yukarıdaki şekilde yazalım.


->Bu projede fiyat kolonu tanımladık fiyat kolonunu editledik girilen değerleri toplayıp kaydetmeye yarar ve ekrana popup olarak mesaj gösteren bir proje uygulandı...

ZGK_OOALV_SCREEN_TOP:
cost TYPE int4,"Yeni bir kolon ekledik..
////////////////////////////////////////
ZGK_OOALV_SCREEN_FRM:

*  call METHOD go_alv->register_edit_event
*    exporting//Fonksiyonun bize döneceği parametreler..
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter."//Yalnızca entera basınca yaptığım değişiklikleri sistem algılar.

  call METHOD go_alv->register_edit_event//methodu çağırır..
    exporting
      i_event_id = cl_gui_alv_grid=>mc_evt_modified."//her hangi bir değişikliği anında algılar.

 clear: gs_fcat.
  gs_fcat-fieldname = 'COST'.
  gs_fcat-scrtext_s = 'Fİyat'.
  gs_fcat-scrtext_m = 'Fiyat'.
  gs_fcat-scrtext_l = 'Fiyat'.
  gs_fcat-edit      = abap_true.
  append gs_fcat to gt_fcat. //Yeni bir kolon girdik adını yazdık..

Append : tabloyu değiştirmeden standart uygulamanın parçası olmayan müşteriye özel alanlar ekleyerek SAP tablolarını geliştirmenize olanak tanır..

form get_total_sum .
  DATA: lv_ttl_sum TYPE int4,
         lv_ttl_sum_c TYPE char10,
        lv_mess TYPE  char200.//Ekrana mesaj yazmak için local tanımladık..

  LOOP AT gt_scarr INTO gs_scarr.
    lv_ttl_sum = lv_ttl_sum + gs_scarr-cost."//Tabloda fiyat kolonuna girilen değerleri toplar..

  ENDLOOP.
  lv_ttl_sum_c = lv_ttl_sum.
  CONCATENATE 'Tüm Satırların toplamı = '"//Ekrana popup ile mesaj verdirir..
              lv_ttl_sum_c
              INTO lv_mess.
Concatanate: komutu birden fazla string değeri tek bir string değerde birleştirmeye yarar..

 LOOP AT: İnternal tablodaki her kayıt için bir döngü bloğu çalıştırılır..
 LOOP ifadesi ile WHERE anahtar kelimesi kullanılarak döngü sayısı sınırlandırılabilir..
 Koşula uyan her kayıt sayısı kadar döngü oluşur..

  MESSAGE lv_mess TYPE 'I'.
//////////////////////////////////////////////////
ZGK_OOALV_SCREEN_PAI:
module user_command_0100 input.
  CASE sy-ucomm.
    WHEN '&BACK' .
   SET SCREEN 0.// geri dönderir..
   WHEN '&SAVE'."Kaydet butonunu aktif ediyoruz..
   PERFORM get_total_sum." oo mantığıyla yapıyoruz..
  ENDCASE.

endmodule.
 ZGK_OOALV_SCREEN_TOP:

  seatl TYPE char1,"Dropdown koltuk harfleri için tanımladık..
  location TYPE char20,"Dropdown için kolon ekledik yurtdışı,yuriçi diye..
  cost TYPE int4,"Yeni bir kolon ekledik
  seatp TYPE char10,"dynamic dropdown

ZGK_OOALV_SCREEN_FRM:

 LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
   CASE <gfs_scarr>-currcode.
   	WHEN 'EUR'.
      <gfs_scarr>-dd_handle = '3'."dropdown da belirttiğimiz kritere göre seçenekler çıkar..
         	WHEN 'USD'.
      <gfs_scarr>-dd_handle = '4'.
         	WHEN 'JPY'.
      <gfs_scarr>-dd_handle = '5'.
   ENDCASE.
 ENDLOOP.

form set_fcat .
clear: gs_fcat.
  gs_fcat-fieldname = 'LOCATION'.
  gs_fcat-scrtext_s = 'Lokasyon'.
  gs_fcat-scrtext_m = 'Lokasyon'.
  gs_fcat-scrtext_l = 'Lokasyon'.
  gs_fcat-edit      = abap_true.
  gs_fcat-drdn_hndl  = 1.
  append gs_fcat to gt_fcat.

  clear: gs_fcat.
  gs_fcat-fieldname = 'SEATL'.
  gs_fcat-scrtext_s = 'Koltuk Harf'.
  gs_fcat-scrtext_m = 'Koltuk Harf'.
  gs_fcat-scrtext_l = 'Koltuk Harf'.
  gs_fcat-edit      = abap_true.
  gs_fcat-drdn_hndl  = 2."//Sabit bir dropdown verilir..
  append gs_fcat to gt_fcat.


  clear: gs_fcat.
  gs_fcat-fieldname = 'SEATP'.
  gs_fcat-scrtext_s = 'Koltuk Pos'.//Kolon adlarımızı giriyoruz..
  gs_fcat-scrtext_m = 'Koltuk Pos'.
  gs_fcat-scrtext_l = 'Koltuk Pos'.
  gs_fcat-edit      = abap_true.
  gs_fcat-drdn_field  = 'DD_HANDLE'.
  append gs_fcat to gt_fcat.
endform.
//Dropdown girdilerimiz
form set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown type LVC_S_DROP.
  CLEAR:ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtiçi'.
  APPEND ls_dropdown to lt_dropdown.

  CLEAR:ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtdışı'.
  APPEND ls_dropdown to lt_dropdown.

CLEAR:ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'A'.
  APPEND ls_dropdown to lt_dropdown.

  CLEAR:ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'B'.
  APPEND ls_dropdown to lt_dropdown.

  "//////////////////////////////////
  CLEAR:ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown to lt_dropdown.


  CLEAR:ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown to lt_dropdown.


  CLEAR:ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown to lt_dropdown.

  "/////////////////////////////////
  CLEAR:ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown to lt_dropdown.

    CLEAR:ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown to lt_dropdown.

  "///////////////////////////////
  CLEAR:ls_dropdown.
  ls_dropdown-handle = 5.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown to lt_dropdown.
  go_alv->set_drop_down_table(
    exporting
      it_drop_down       = lt_dropdown  " Dropdown Table

  ).
endform.
ZGK_OOALV_SCREEN:
####################
*&---------------------------------------------------------------------*
*& Report ZGK_OOALV_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_OOALV_SCREEN.


INCLUDE ZGK_OOALV_SCREEN_top." değişkenler tanımlanır
INCLUDE ZGK_OOALV_SCREEN_cls.
INCLUDE ZGK_OOALV_SCREEN_pbo."scrren açılmadan önce oluşmuş olan yer
INCLUDE ZGK_OOALV_SCREEN_pai."oluşturduktan sonra butonları yakalayan yer
INCLUDE ZGK_OOALV_SCREEN_frm.

START-OF-SELECTION.
 PERFORM get_data.
 PERFORM set_fcat.
 PERFORM set_layout.



call SCREEN 0100.

ZGK_OOALV_SCREEN_TOP:
######################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_TOP
*&---------------------------------------------------------------------*
type-pools icon."İconları tanıyan include

data: go_alv   type ref to cl_gui_alv_grid,
      go_cust type ref to cl_gui_custom_container.

types: begin of gty_scarr,
         durum    type icon_d,
         carrid   type s_carr_id,
         carrname type s_carrname,
         currcode type s_currcode,
         url      type s_carrurl,
         style    type lvc_t_styl,
         end of gty_scarr.

*  seatl TYPE char1,       "Dropdown koltuk harfleri için tanımladık..
*  location TYPE char20,   "Dropdown için kolon ekledik yurtdışı,yuriçi diye..
*  cost TYPE int4,         "Yeni bir kolon ekledik
*  seatp TYPE char10,      "dynamic dropdown
*  dd_handle TYPE int4,    "Dynamic dropdown
*  MESS TYPE CHAR200,
*  line_color TYPE char4,
*  cell_color TYPE lvc_t_scol,




data:gs_cellstyle type lvc_s_styl.
data: gs_cell_color type lvc_s_scol.

DATA:go_spli TYPE REF TO cl_gui_splitter_container,
      go_sub1 TYPE REF TO cl_gui_container,"container için 2 tane obje oluşturduk..
      go_sub2 TYPE REF TO cl_gui_container.

DATA: go_docu TYPE REF TO cl_dd_document.

class cl_event_receiver definition deferred.
data: go_event_receiver type ref to cl_event_receiver.

data: gt_scarr  type table of gty_scarr,
      gs_scarr  type gty_scarr,
      gt_fcat   type lvc_t_fcat,
      gs_fcat   type lvc_s_fcat,
      gs_layout type lvc_s_layo.


field-symbols:<gfs_fc>    type lvc_s_fcat,
              <gfs_scarr> type gty_scarr.

ZGK_OOALV_SCREEN_CLS:
#########################

*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_CLS
*&---------------------------------------------------------------------*
class cl_event_receiver definition.
  public section.
    methods handle_top_of_page         "TOP_OF_PAGE""Alv ustune başlık ve acıklama alanı
    for event top_of_page of cl_gui_alv_grid "cl class yapısı..
    importing
    e_dyndoc_id
    table_index.

    methods handle_hotspot_click       "HOTSPOT_CLİCK""Hucre içindeki altı çizgili metin oluşturma
    for event hotspot_click of cl_gui_alv_grid
    importing
    e_row_id
    e_column_id.

    methods handle_double_click       "DOUBLE_CLİCK""hucreye cift tıklama
    for event double_click of cl_gui_alv_grid
    importing
    e_row
    e_column
    es_row_no.

    methods handle_data_changed       "DATA_CHANGED""hucrede herhangi bir veri degisimini kontrol eder
    for event data_changed of cl_gui_alv_grid
    importing
    er_data_changed
    e_onf4
    e_onf4_before
    e_onf4_after
    e_ucomm.

    methods handle_onf4                "ONF4""Search help
    for event onf4 of cl_gui_alv_grid
    importing
    e_fieldname
    e_fieldvalue
    es_row_no
    er_event_data
    et_bad_cells
    e_display.
endclass.


class cl_event_receiver implementation.
method handle_top_of_page.

 data: lv_text type sdydo_text_element.

    lv_text = 'FLIGHT DETAILS'.
    call method go_docu->add_text
    exporting
    text      = lv_text
    sap_style = cl_dd_document=>heading. "başlık verisi
    .

    call method go_docu->new_line.
    clear: lv_text.
    concatenate 'User:' sy-uname into lv_text separated by space.
    call method go_docu->add_text
    exporting
    text         = lv_text
    sap_color    = cl_dd_document=>list_positive
    sap_fontsize = cl_dd_document=>medium.

    call method go_docu->display_document
    exporting
    parent = go_sub1.
  endmethod.

  method handle_hotspot_click.
    break-point.
  endmethod.

  method handle_double_click.
    break-point.
  endmethod.

  method handle_data_changed.
    break-point.
  endmethod.

  method handle_onf4.
    break-point.
  endmethod.
endclass.

ZGK_OOALV_SCREEN_PBO:
#####################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module status_0100 output.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  PERFORM display_alv.
endmodule.

ZGK_OOALV_SCREEN_PAI:
######################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module user_command_0100 input.
  CASE sy-ucomm.
    WHEN '&BACK' .
   SET SCREEN 0.
   WHEN '&SAVE'."Kaydet butonunu aktif ediyoruz..
   PERFORM get_total_sum." oo mantığıyla yapıyoruz..
  ENDCASE.

endmodule.
ZGK_OOALV_SCREEN_FRM:
#######################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form display_alv.


*"///////////////////////////////////////////////
*  create object go_alv
*    exporting
*      i_parent = go_count.  " Obje istediği için container adını yazıyoruz..


if go_alv IS INITIAL.
CREATE OBJECT go_cust
exporting
container_name = 'CC_ALV' .

    create object go_alv
      exporting
        i_parent = cl_gui_container=>screen0. "//Tabloyu basabilidiği en geniş biçimde ekrana basar..

    create object go_spli
      exporting
        parent = go_cust
        rows   = 2
       columns = 1.

    call method go_spli->get_container
      exporting
        row       = 1            " Row
        column    = 1             " Column
      receiving
        container = go_sub1.         " Container


    CREATE OBJECT go_docu
      exporting
        style            = 'ALV_GRID'.


    call method go_spli->get_container
      exporting
        row       = 2            " Row
        column    = 1             " Column
      receiving
        container = go_sub2.         " Container


     create object go_alv
      exporting
        i_parent = go_sub2.

  CALL METHOD go_alv->set_table_for_first_display
  exporting
    is_layout                     = gs_layout
  changing
    it_outtab                     =  gt_scarr
    it_fieldcatalog               = gt_fcat .

CALL METHOD go_alv->list_processing_events
  exporting
    i_event_name      = 'TOP_OF_PAGE'
    i_dyndoc_id       = go_docu.

ELSE.
  CALL METHOD go_alv->refresh_table_display.
  endif.



    create object go_event_receiver.
    set handler go_event_receiver->handle_top_of_page for go_alv.




*  PERFORM set_dropdown.

*    call method go_alv->set_table_for_first_display
*      exporting
**       i_buffer_active =
**       i_bypassing_buffer            =
**       i_consistency_check           =
**       is_variant      =
**       i_structure_name = 'SCARR'
**       i_save          =
**       i_default       = 'X'
*        is_layout       = gs_layout
**       is_print        =
**       it_special_groups             =
**       it_toolbar_excluding          =
**       it_hyperlink    =
**       it_alv_graphics =
**       it_except_qinfo =
**       ir_salv_adapter =
*      changing
*        it_outtab       = gt_scarr
*        it_fieldcatalog = gt_fcat  "Kolon bazında düzenlemeler yaptığımız yapı..
**       it_sort         =
**       it_filter       =
**    exceptions
**       invalid_parameter_combination = 1
**       program_error   = 2
**       too_many_lines  = 3
**       others          = 4
      .

    "//////////////////////////////////////////////

*  call METHOD go_alv->register_edit_event
*    exporting
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter."//Yalnızca entera basınca yaptığım değişiklikleri sistem algılar.

*    call method go_alv->register_edit_event
*      exporting
*        i_event_id = cl_gui_alv_grid=>mc_evt_modified. "//her hangi bir değişikliği anında algılar.
*  else.
*    call method go_alv->refresh_table_display."//Var olan güncellemeleri yakalar
*  endif.


endform.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form get_data .

  select * from scarr
  into corresponding fields of table  gt_scarr.

  loop at gt_scarr assigning <gfs_scarr>.
    if <gfs_scarr>-currcode <> 'EUR'.   "editlemek için sadece eur ve url editler
      clear: gs_cellstyle.
      gs_cellstyle-fieldname = 'URL'.
      gs_cellstyle-style     = cl_gui_alv_grid=>mc_style_disabled.
      append gs_cellstyle to <gfs_scarr>-style.
    endif.
  endloop.

* LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*   CASE <gfs_scarr>-currcode.
*     WHEN 'EUR'.
*      <gfs_scarr>-dd_handle = '3'."dropdown da belirttiğimiz kritere göre seçenekler çıkar..
*           WHEN 'USD'.
*      <gfs_scarr>-dd_handle = '4'.
*           WHEN 'JPY'.
*      <gfs_scarr>-dd_handle = '5'.
*   ENDCASE.
*
*
* ENDLOOP.
 " //İcon Bölümü
    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
      <gfs_scarr>-durum = '@0B@'."//İcon adımızı giriyoruz..

    ENDLOOP.


*"//Para birimi USD olanları turuncu yaptık..
*    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*      CASE <gfs_scarr>-currcode.
*        WHEN 'USD'.
*        <gfs_scarr>-line_color = 'C710'.
*        WHEN 'JPY'.
*        <gfs_scarr>-line_color = 'C501'."yazı rengi yeşil oldu
*WHEN 'EUR'.
*  CLEAR: gs_cell_color.
*  gs_cell_color-fname = 'URL'.
*  gs_cell_color-color-col = '3'.
*  gs_cell_color-color-int = '1'.
*  gs_cell_color-color-inv ='0'.
*  APPEND gs_cell_color to <gfs_scarr>-cell_color.
*
*      ENDCASE.

*    ENDLOOP.


endform.
*&---------------------------------------------------------------------*
*&      Form  SET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form set_fcat .
*   clear: gs_fcat.
*  gs_fcat-fieldname = 'DURUM'.
*  gs_fcat-scrtext_s = 'durum'.
*  gs_fcat-scrtext_m = 'durum'.
*  gs_fcat-scrtext_l = 'durum'.
**  gs_fcat-col_pos   = 2. "//Tablodaki kolonalrın yerlerini değişitirip yeniden sıralamamızı sağlar..
*  append gs_fcat to gt_fcat.

  clear: gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-scrtext_s = 'Havayolu T'.
  gs_fcat-scrtext_m = 'Havayolu Tanımı'.
  gs_fcat-scrtext_l = 'Havayolu Şirketinin Kısa Tanımı'.
*  gs_fcat-col_pos   = 2. "//Tablodaki kolonalrın yerlerini değişitirip yeniden sıralamamızı sağlar..
  append gs_fcat to gt_fcat.

  clear: gs_fcat.
  gs_fcat-fieldname = 'CARRNAME'.
  gs_fcat-scrtext_s = 'Havayolu A'.
  gs_fcat-scrtext_m = 'Havayolu Adı'.
  gs_fcat-scrtext_l = 'Havayolu Şirketinin Adı'.
*  gs_fcat-key       = abap_true. "//Kolonu key yapar..
*  gs_fcat-outputlen = 100 . "//Kolonun genişliğini manuel olarak ne kadar istenirse öyle değiştirir..
*  gs_fcat-col_pos   = 3.
  append gs_fcat to gt_fcat.

  clear: gs_fcat.
  gs_fcat-fieldname = 'CURRCODE'.
  gs_fcat-scrtext_s = 'Havayolu PB'.
  gs_fcat-scrtext_m = 'Havayolu PB'.
  gs_fcat-scrtext_l = 'Havayolu Şirketinin Ulusal Para Birirmi'.
*  gs_fcat-col_pos   = 4.
*  gs_fcat-edit      = abap_true. "//Kolonu editlelemizi sağlar kolon içi düzenlemeye fırsat verir..
*  gs_fcat-no_out    = abap_true. "//Kolonu ekrandan kaldırmamızı sağlar..
  append gs_fcat to gt_fcat.

  clear: gs_fcat.
  gs_fcat-fieldname = 'URL'.
  gs_fcat-scrtext_s = 'Havayolu URL'.
  gs_fcat-scrtext_m = 'Havayolu URL'.
  gs_fcat-scrtext_l = 'Havayolu Şirketinin URL'.
  gs_fcat-edit      = abap_true.
*  gs_fcat-col_pos   = 1.
*  gs_fcat-col_opt   = abap_true."//Kolondaki verilerin uzunluğu kadar sığdırmaya yarayan yapı..
*  gs_fcat-hotspot   = abap_true."//Tıklanabilir özeliiği aktif hale gelir aynı zamanda altı çizili yapar..
  append gs_fcat to gt_fcat.
*
*  clear: gs_fcat.
*  gs_fcat-fieldname = 'COST'.
*  gs_fcat-scrtext_s = 'Fİyat'.
*  gs_fcat-scrtext_m = 'Fiyat'.
*  gs_fcat-scrtext_l = 'Fiyat'.
*  gs_fcat-edit      = abap_true.
*  append gs_fcat to gt_fcat.
*
*  clear: gs_fcat.
*  gs_fcat-fieldname = 'LOCATION'.
*  gs_fcat-scrtext_s = 'Lokasyon'.
*  gs_fcat-scrtext_m = 'Lokasyon'.
*  gs_fcat-scrtext_l = 'Lokasyon'.
*  gs_fcat-edit      = abap_true.
*  gs_fcat-drdn_hndl  = 1.
*  append gs_fcat to gt_fcat.
*
*  clear: gs_fcat.
*  gs_fcat-fieldname = 'SEATL'.
*  gs_fcat-scrtext_s = 'Koltuk Harf'.
*  gs_fcat-scrtext_m = 'Koltuk Harf'.
*  gs_fcat-scrtext_l = 'Koltuk Harf'.
*  gs_fcat-edit      = abap_true.
*  gs_fcat-drdn_hndl  = 2."//Sabit bir dropdown verilir..
*  append gs_fcat to gt_fcat.
*
*
*  clear: gs_fcat.
*  gs_fcat-fieldname = 'SEATP'.
*  gs_fcat-scrtext_s = 'Koltuk Pos'.
*  gs_fcat-scrtext_m = 'Koltuk Pos'.
*  gs_fcat-scrtext_l = 'Koltuk Pos'.
*  gs_fcat-edit      = abap_true.
*  gs_fcat-drdn_field  = 'DD_HANDLE'.
*  append gs_fcat to gt_fcat.
endform.

*form set_fcat.
*  call function 'LVC_FIELDCATALOG_MERGE'
*    exporting
*     I_STRUCTURE_NAME       = 'SCARR'
*      i_structure_name       = 'ZGK_OOALV_SCREEN_S'
*     I_INTERNAL_TABNAME     =
*    changing
*      ct_fieldcat            = gt_fcat
*    exceptions
*      inconsistent_interface = 1
*      program_error          = 2
*      others                 = 3.
*endform.

*&---------------------------------------------------------------------*
*&      Form  GS_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form set_layout .
  clear: gs_layout.
  gs_layout-cwidth_opt = abap_true.
*  gs_layout-edit       = abap_true. "//Tabloyu tümüyle editlememizi sağlar..
  gs_layout-zebra      = abap_true.
*  gs_layout-info_fname = 'LINE_COLOR'.
*  gs_layout-no_toolbar = abap_true.
  gs_layout-stylefname = 'STYLE'.
*  gs_layout-stylefname = 'CELL_COLOR'.
endform.
*&---------------------------------------------------------------------*
*&      Form  GET_TOTAL_SUM
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form get_total_sum .
  data: lv_ttl_sum type int4,
        lv_lines   type int4,
        lv_avr     type int4.
*         lv_ttl_sum_c TYPE char10,
*        lv_mess TYPE  char200.

*  LOOP AT gt_scarr INTO gs_scarr.
*    lv_ttl_sum = lv_ttl_sum + gs_scarr-cost."//Tabloda fiyat kolonuna girilen değerleri toplar..
*  ENDLOOP.
*  DESCRIBE TABLE gt_scarr LINES lv_lines.
*
*LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*  IF <gfs_scarr>-cost > lv_avr.
*    <gfs_scarr>-durum = '@0A@'.
*    ELSEIF  <gfs_scarr>-cost < lv_avr.
*    <gfs_scarr>-durum = '@08@'.
*    else.
*    <gfs_scarr>-durum = '@09@'.
*
*  ENDIF.
*
*ENDLOOP.
*  lv_ttl_sum_c = lv_ttl_sum.
*  CONCATENATE 'Tüm Satırların toplamı = '"//Ekrana popup ile mesaj verdirir..
*              lv_ttl_sum_c
*              INTO lv_mess.
*
*  MESSAGE lv_mess TYPE 'I'.


endform.
*&---------------------------------------------------------------------*
*&      Form  SET_DROPDOWN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*form set_dropdown .
*  DATA: lt_dropdown TYPE lvc_t_drop,
*        ls_dropdown type LVC_S_DROP.
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 1.
*  ls_dropdown-value = 'Yurtiçi'.
*  APPEND ls_dropdown to lt_dropdown.
*
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 1.
*  ls_dropdown-value = 'Yurtdışı'.
*  APPEND ls_dropdown to lt_dropdown.
*
*CLEAR:ls_dropdown.
*  ls_dropdown-handle = 2.
*  ls_dropdown-value = 'A'.
*  APPEND ls_dropdown to lt_dropdown.
*
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 2.
*  ls_dropdown-value = 'B'.
*  APPEND ls_dropdown to lt_dropdown.
*
*  "//////////////////////////////////
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 3.
*  ls_dropdown-value = 'Ön'.
*  APPEND ls_dropdown to lt_dropdown.
*
*
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 3.
*  ls_dropdown-value = 'Arka'.
*  APPEND ls_dropdown to lt_dropdown.
*
*
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 3.
*  ls_dropdown-value = 'Kanat'.
*  APPEND ls_dropdown to lt_dropdown.
*
*  "/////////////////////////////////
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 4.
*  ls_dropdown-value = 'Ön'.
*  APPEND ls_dropdown to lt_dropdown.
*
*    CLEAR:ls_dropdown.
*  ls_dropdown-handle = 4.
*  ls_dropdown-value = 'Arka'.
*  APPEND ls_dropdown to lt_dropdown.
*
*  "///////////////////////////////
*  CLEAR:ls_dropdown.
*  ls_dropdown-handle = 5.
*  ls_dropdown-value = 'Kanat'.
*  APPEND ls_dropdown to lt_dropdown.
*  go_alv->set_drop_down_table(
*    exporting
*      it_drop_down       = lt_dropdown  " Dropdown Table
*
*  ).
*endform.
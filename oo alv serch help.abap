ZGK_OOALV_SCREEN
#################
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

ZGK_OOALV_SCREEN_CLS:
#####################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_CLS
*&---------------------------------------------------------------------*
class cl_event_receiver definition.
  public section.
     METHODS HANDLE_ONF4 "search field
      FOR EVENT onf4 of CL_GUI_ALV_GRID
        IMPORTING
          E_FIELDNAME
          E_FIELDVALUE
          ES_ROW_NO
          ER_EVENT_DATA
          ET_BAD_CELLS
          E_DISPLAY.
/////////////////////////////////////

 method handle_onf4.

    types: begin of lty_value_tab,  "Value tab alanı için bir tek kolonlu tablo oluşturuyorz
             carrname type s_carrname,
             carrdeff type char20,
           end of lty_value_tab.

    data: lt_value_tab type table of lty_value_tab, "Oluşturudugumuz tek kolonlu tabloyu referans alan bir internal table oluşturuuyoruz
          ls_value_tab type lty_value_tab. "Ve o alanı doldurmak içinde bir structre

    "Search help alanına basıldıgınnda pop up ile birlikte ekrana gelcek alan
    clear ls_value_tab.
    ls_value_tab-carrname = 'Uçuş 1'.
    ls_value_tab-carrdeff = 'Birinci uçuş'.
    append ls_value_tab to lt_value_tab.

    clear ls_value_tab.
    ls_value_tab-carrname = 'Uçuş 2'.
    ls_value_tab-carrdeff = 'İkinci uçuş'.
    append ls_value_tab to lt_value_tab.

    clear ls_value_tab.
    ls_value_tab-carrname = 'Uçuş 3'.
    ls_value_tab-carrdeff = 'Üçüncü uçuş'.
    append ls_value_tab to lt_value_tab.


    data: lt_return_tab type table of ddshretval, "return table tipinde bi tablo
          ls_return_tab type ddshretval. "O tabloyu da doldurmak için structure


    call function 'F4IF_INT_TABLE_VALUE_REQUEST' "Search help alanına bastıgımda ekrana cıkacak pop up alanı
      exporting
        retfield     = 'CARRNAME'  "oluşturulan tablodaki hangi kolonu referans(DEğerini) almamız gerkttiigin bu alana yazıyoruz
        window_title = 'carrname F4'    "Açılan search helpin başlıgı
        value_org    = 'S'   "Default olarak S veriyourz
      tables
        value_tab    = lt_value_tab "Ekranda gorunmesini istedigimiz internal table "Dinamik table olan "N kolonlu
        return_tab   = lt_return_tab.  "Yaptıgı seçimi yakalamamız için kullancagım alan


    "Sarch help alanına basıldıgında ekrana gelcek pop up tan seçilen alanı ls_return_tab içinde  tutyoruz
    "F0001 seçilen kolon sırasıdır
    read table lt_return_tab into ls_return_tab with key fieldname = 'F0001'.
    if sy-subrc eq 0.

      "Seçilen degeri direkt olarak tablonun alanına bascagımzı için field symbol kullanıoruz
      read table gt_scarr assigning <gfs_scarr> index es_row_no-row_id. "Search help içinde hangi satırda işlem yapıldıysa onunla şartıyorzu
      if sy-subrc eq 0.

        "Tablomun seçil satırına search help uzerindn seçilen degeri yazdırıyoruz
        <gfs_scarr>-carrname = ls_return_tab-fieldval.

        go_grid->refresh_table_display( ). "Yapılan degişikligin alv uzerine yansıması için alvyi refreshliyoruz
      endif.
    endif.

    "Search help kısmının tamamlanmış olması için
    er_event_data->m_event_handled = 'X'.

  endmethod.
endclass.

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

  if go_grid is initial.


    create object go_event_receiver."Event yapısını once creat ederiz

    create object go_cust "Container objemizi tutması için
      exporting
        container_name = 'CC_ALV'.



    "Normalde alv yapımıza direk containır tutan yapımızı verirdik ama o yapıyı parçaladıgımız için artık onun bir parçası olan sub2 tutcak
    create object go_grid
      exporting
        i_parent = go_cust. "         GO_CONTAINER. yapısı tutmicak o yapıyı bolduk onu parçaladıgımız yapı tutacak


    set handler go_event_receiver->handle_onf4 for go_grid. "Seacrh help alanını alv ye assign ediyorum

    perform register_f4."Search help alanını kullanmak için

  call method go_grid->register_edit_event "Eğer kolonumda editable bi alan varsa kullancı bu alana manul deger girebilir bizimde bunu yakalamamız gerkir
      exporting
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.      " Event ID

    go_grid->set_table_for_first_display(
      exporting
        is_layout                     =       gs_layout          " Layout
      changing
        it_outtab                    =        gt_scarr   "Veri bascagımız tablo.
        it_fieldcatalog               =       gt_fcat           " Kolon bazında duzenleme yapmamızı saglar
    ).


  else.
    call method go_grid->refresh_table_display.
  endif.
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
endform.


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
  gs_layout-zebra      = abap_true.
*  gs_layout-stylefname = 'STYLE'
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
  call function 'LVC_FIELDCATALOG_MERGE'
    exporting
      i_structure_name = 'SCARR'
    changing
      ct_fieldcat      = gt_fcat.

  loop at gt_fcat assigning <gfs_fcat>.
    if <gfs_fcat>-fieldname eq 'CARRNAME'.
      <gfs_fcat>-edit = abap_true.  "//Edit modu açık..
    <gfs_fcat>-f4availabl = abap_true."aşağıdaki ile görevleri aynı serch help iconunu gösterir.
*      <gfs_fcat>-style = cl_gui_alv_grid=>mc_style_f4.
    endif.
  endloop.
endform.
*&---------------------------------------------------------------------*
*&      Form  REGISTER_F4
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form register_f4 .
data: lt_f4 type LVC_T_F4, "Birden cok alana search help ekleyebilriiz bu yuzden bu değişkenn bir intern table
      ls_f4 TYPE lvc_s_f4. "Tablomu doldurmakta kullanacagım structure

clear ls_f4.

LS_F4-FIELDNAME = 'CARRNAME'. "hangi kolona search help ekliceksem o alanı yazacgım
LS_F4-REGISTER = 'X'. "Register yanı search help alan olacagını belirtiyoruz
APPEND LS_F4 to LT_F4."sectigim kolonu tabloma eklyorm

call METHOD GO_grid->REGISTER_F4_FOR_FIELDS "Search help alanının  hangi kolonda olacagını vermemiz gereklidir
  exporting
    IT_F4 =       lt_f4           "Search help alanalarının kaydedildigi alanlarını veriyoruz
  .

endform.
ZGK_OOALV_SCREEN_PAI:
#####################
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
  ENDCASE.

endmodule.

ZGK_OOALV_SCREEN_PBO:
#######################
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

ZGK_OOALV_SCREEN_TOP:
#######################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_TOP
*&---------------------------------------------------------------------*

data: go_grid  type ref to cl_gui_alv_grid,
      go_cust type ref to cl_gui_custom_container.

data: gt_scarr   type table of scarr,
      gs_scarr   type scarr,
      gt_fcat    type lvc_t_fcat,
      gs_layout  type lvc_s_layo.

   FIELD-SYMBOLS: <gfs_fcat> TYPE LVC_S_FCAT,
                  <gfs_scarr> TYPE scarr.

CLASS cl_event_receiver DEFINITION DEFERRED.

DATA go_event_receiver TYPE REF TO cl_event_receiver.

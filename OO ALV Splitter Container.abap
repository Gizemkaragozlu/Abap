=>Layout kısmından iki tane container oluşturuldu cc_alv,cc_alv2.
=>Tabloları yan yana tek bir container içinde göstermek için ve iki container içinde göstermek için oluşturulan kodlama..

ZGK_OOALV_SCREEN_TOP:
/////////////////////////
data: go_alv  type ref to cl_gui_alv_grid,
      go_cust type ref to cl_gui_custom_container.

DATA: go_splitter TYPE REF TO cl_gui_splitter_container,
      go_gui1 TYPE REF TO cl_gui_container,
      go_gui2 TYPE REF TO cl_gui_container.



data: go_alv2  type ref to cl_gui_alv_grid,
      go_cust2 type ref to cl_gui_custom_container.

data: gt_scarr   type table of scarr,
      gt_sflight type table of sflight,
      gt_fcat    type lvc_t_fcat,
      gt_fcat2   type lvc_t_fcat,
      gs_fcat    type lvc_s_fcat,
      gs_layout  type lvc_s_layo.
//////////////////////////
ZGK_OOALV_SCREEN_FRM:
/////////////////////////
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

  if go_alv is initial.
    create object go_cust
      exporting
        container_name = 'CC_ALV'.

    create object go_splitter
      exporting
        parent  = go_cust
        rows    = 1
        columns = 2.

    call method go_splitter->get_container
      exporting
        row       = 1
        column    = 1
      receiving
        container = go_gui1. " Container


    call method go_splitter->get_container
      exporting
        row       = 1 "2.tablo için..
        column    = 2
      receiving
        container = go_gui2. " Container


    create object go_alv
      exporting
        i_parent = go_gui1.


    create object go_alv2 "2.tablo için..
      exporting
        i_parent = go_gui2.

    call method go_alv->set_table_for_first_display
      exporting
        is_layout       = gs_layout
      changing
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.


    call method go_alv2->set_table_for_first_display
      exporting
        is_layout       = gs_layout
      changing
        it_outtab       = gt_sflight
        it_fieldcatalog = gt_fcat2.
    "//////////////////////////////////////////////////////
    "2.tabloyu ekrana basmak

*   CREATE OBJECT go_cust2
*    exporting
*      container_name = 'CC_ALV2'.
*
*    create object go_alv2
*      exporting
*        i_parent = go_cust2 .
*
*  CALL METHOD go_alv2->set_table_for_first_display
*  exporting
*    is_layout                     = gs_layout
*  changing
*    it_outtab                     =  gt_sflight
*    it_fieldcatalog               = gt_fcat2 .


  else.
    call method go_alv->refresh_table_display.
*  CALL METHOD go_alv2->refresh_table_display.
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


  select * from sflight
  into corresponding fields of table  gt_sflight.
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
  gs_layout-stylefname = 'STYLE'.
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

  call function 'LVC_FIELDCATALOG_MERGE'
    exporting
      i_structure_name = 'SFLIGHT'
    changing
      ct_fieldcat      = gt_fcat2.

endform.


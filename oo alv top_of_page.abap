ZGK_OOALV_SCREEN_CLS:
//////////////////////
class cl_event_receiver definition.
  public section.
    methods handle_top_of_page         "TOP_OF_PAGE""Alv ustune başlık ve acıklama alanı
    for event top_of_page of cl_gui_alv_grid "cl class yapısı..
    importing
    e_dyndoc_id
    table_index.
.....................................
class cl_event_receiver implementation.
method handle_top_of_page.

 data: lv_text type sdydo_text_element.

    lv_text = 'Gizem'.
    call method go_docu->add_text
    exporting
    text      = lv_text
    sap_style = cl_dd_document=>heading. "başlık verisi..
    .

    call method go_docu->new_line.       " Bir alt satıra geçme methodu..
    clear: lv_text.
    concatenate 'User:' sy-uname into lv_text separated by space.

    call method go_docu->add_text "Ekrana eklemek için..
    exporting
    text         = lv_text
    sap_color    = cl_dd_document=>list_positive "// User Kısmınında yazan yazının taban rengi..
    sap_fontsize = cl_dd_document=>medium. "// Yazı büyüklüğü..

    call method go_docu->display_document
    exporting
    parent = go_sub1.

  endmethod.

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

if go_alv IS INITIAL.
CREATE OBJECT go_cust
exporting
container_name = 'CC_ALV' .

    CREATE OBJECT go_docu
      exporting
        style            = 'ALV_GRID'.

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
        row       = 1
        column    = 1
      receiving
        container = go_sub1.


    call method go_spli->get_container
      exporting
        row       = 2            " Row
        column    = 1            " Column
      receiving
        container = go_sub2.      " Container


     create object go_alv
      exporting
        i_parent = go_sub2.

     CALL METHOD go_spli->set_row_height
       exporting
         id                = 1
         height            = 15.

     CREATE OBJECT go_docu
       exporting
         style            =  'ALV_GRİD'.


    create object go_event_receiver.
    set handler go_event_receiver->handle_top_of_page for go_alv.


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
endform.

ZGK_OOALV_SCREEN_TOP:
////////////////////////
DATA:go_spli TYPE REF TO cl_gui_splitter_container,
      go_sub1 TYPE REF TO cl_gui_container,"container için 2 tane obje oluşturduk..
      go_sub2 TYPE REF TO cl_gui_container.

DATA: go_docu TYPE REF TO cl_dd_document. "top_of_page için oluşturulan obje..
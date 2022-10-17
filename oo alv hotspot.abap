ZGK_OOALV_SCREEN_TOP:
#######################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_TOP
*&---------------------------------------------------------------------*

data: go_grid  type ref to cl_gui_alv_grid,
      go_cust type ref to cl_gui_custom_container.

data: gt_scarr   type table of scarr,
      gS_scarr   type scarr,
      gt_fcat    type lvc_t_fcat,
      gs_layout  type lvc_s_layo.
   FIELD-SYMBOLS: <gfs-fcat> TYPE LVC_S_FCAT.

CLASS cl_event_receiver DEFINITION DEFERRED.

DATA go_event_receiver TYPE REF TO cl_event_receiver.

ZGK_OOALV_SCREEN_CLS:
#######################

    methods handle_hotspot_click       "HOTSPOT_CLİCK""Hucre içindeki altı çizgili metin oluşturma,tıklanabilir özellik oluşturma..
    for event hotspot_click of cl_gui_alv_grid
    importing
    e_row_id
    e_column_id.
//////////////////////////////////
method handle_hotspot_click.
   DATA: lv_mess TYPE char200.

   READ TABLE gt_scarr INTO gs_scarr INDEX e_row_id-index.
   IF sy-subrc eq 0.
     CASE e_column_id-fieldname.
     	WHEN 'CARRID'.
     CONCATENATE 'Tıklanılan Kolon'
                 e_column_id-fieldname
                 'değeri'
                 gs_scarr-carrid
                 INTO lv_mess
                 SEPARATED BY space.
     MESSAGE lv_mess TYPE 'I'.
     WHEN 'CARRNAME'.
     CONCATENATE 'Tıklanılan Kolon'
                 e_column_id-fieldname
                 'değeri'
                 gs_scarr-carrid
                 INTO lv_mess
                 SEPARATED BY space.
     MESSAGE lv_mess TYPE 'I'.
     ENDCASE.

   ENDIF.
  endmethod.

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
    create object go_cust
      exporting
        container_name = 'CC_ALV'.

    CREATE OBJECT go_grid
      exporting
        i_parent          =  go_cust.

CREATE OBJECT go_event_receiver.
set HANDLER go_event_receiver->handle_hotspot_click FOR go_grid. "Tıklanma..

    call method go_grid->set_table_for_first_display
      exporting
        is_layout       = gs_layout
      changing
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.


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
  LOOP AT gt_fcat ASSIGNING <gfs-fcat>. "// hotspot özelliğini uygulayacağımız kolonları yazdık..
    IF <gfs-fcat>-fieldname EQ 'CARRID' or
       <gfs-fcat>-fieldname EQ 'CARRNAME'.
       <gfs-fcat>-hotspot = abap_true.

    ENDIF.
  ENDLOOP.
endform.
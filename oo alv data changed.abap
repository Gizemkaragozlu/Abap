ZGK_OOALV_SCREEN_TOP:
#####################
*&---------------------------------------------------------------------*
*&  Include           ZGK_OOALV_SCREEN_TOP
*&---------------------------------------------------------------------*

data: go_grid  type ref to cl_gui_alv_grid,
      go_cust type ref to cl_gui_custom_container.

data: gt_scarr   type table of scarr,
      gs_scarr   type scarr,
      gt_fcat    type lvc_t_fcat,
      gs_layout  type lvc_s_layo.

   FIELD-SYMBOLS: <gfs_fcat> TYPE LVC_S_FCAT.

CLASS cl_event_receiver DEFINITION DEFERRED.

DATA go_event_receiver TYPE REF TO cl_event_receiver.

ZGK_OOALV_SCREEN_CLS:
#####################
   methods handle_data_changed       "DATA_CHANGED""hucrede herhangi bir veri degisimini kontrol eder
        for event data_changed of cl_gui_alv_grid
      importing
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.
/////////////////////////////////////
  method handle_data_changed.
    data: ls_modi type lvc_s_modi,
          lv_mess type char200.

    loop at er_data_changed->mt_good_cells into ls_modi.
      read table gt_scarr into gs_scarr index ls_modi-row_id.
      if sy-subrc eq 0.
        concatenate ls_modi-fieldname
        'eski değer'
        gs_scarr-carrname
        ',yeni değer'
        ls_modi-value
        into lv_mess
        separated by space.
        MESSAGE lv_mess TYPE 'I'.

      endif.
    endloop.
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

set HANDLER go_event_receiver->handle_data_changed FOR go_grid. "assign ediyoruz..

    call method go_grid->set_table_for_first_display
      exporting
        is_layout       = gs_layout
      changing
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.

CALL METHOD go_grid->register_edit_event
  exporting
    i_event_id = cl_gui_alv_grid=>mc_evt_modified.


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

LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
  IF <gfs_fcat>-fieldname eq 'CARRNAME'.
    <gfs_fcat>-edit = abap_true.  "//Edit modu açık..
 ENDIF.
ENDLOOP.
endform.
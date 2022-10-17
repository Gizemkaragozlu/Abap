*&---------------------------------------------------------------------*
*& Report ZGK_GUI_STATUS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_GUI_STATUS.
START-OF-SELECTION.
call SCREEN 0100.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module status_0100 output.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.
endmodule.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module user_command_0100 input.
  DATA: lv_text type char200.
  CONCATENATE sy-ucomm// ikiden fazla string ifadesini tutan yapı.
             'butonuna basılmıştır.'
              INTO lv_text
              SEPARATED BY space.//boşuk olmasını sağlar.
message lv_text type 'I'.
  CASE sy-ucomm.
  	WHEN '&BCK'.
  LEAVE TO SCREEN 0.
  ENDCASE.

endmodule.
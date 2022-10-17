Smartforms->Form arayüzü->İçe aktar IV_ACTIVE TYPE CHAR1 'A'
(gv_active olan yerleri sildik metin dosyalarındaki gv_active olanları iv_active olarak değiştirdik.)

se38
*&---------------------------------------------------------------------*
*& Report ZGK_SMARTFORMS_PRM_GND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_SMARTFORMS_PRM_GND.
DATA: gv_fm_name type RS38L_FNAM,
      gs_control TYPE SSFCTRLOP,
      gs_output_opt TYPE SSFCOMPOP.

DATA: gt_scarr TYPE TABLE OF scarr.

DATA: gv_currcode TYPE s_CURRCODE.

SELECT-OPTIONS: s_code FOR gv_currcode.
PARAMETERS:p_active TYPE char1. "Parametre oluşturduk aktif pasif uçuşlar için..

START-OF-SELECTION.



select * from scarr
  INTO TABLE gt_scarr
  WHERE currcode in s_code.

gs_control-no_dialog = abap_true. "//Popup ekranı çıkmasın diye yazılır.
gs_control-preview = abap_true.  "// Çıktı ekranı basabilmesi için yazılır.
gs_output_opt-tddest = 'LP01'.

call function 'SSF_FUNCTION_MODULE_NAME'
  exporting
    formname                 = 'ZGK_002'
 IMPORTING
   FM_NAME                  =  gv_fm_name     " // aşağıda yazdığımız smartformumuzu dönderir..
          .
if sy-subrc <> 0.
* Implement suitable error handling here
endif.



call function gv_fm_name
 EXPORTING
   CONTROL_PARAMETERS         = gs_control
   OUTPUT_OPTIONS             = gs_output_opt
   USER_SETTINGS              = ' '  " // Değişikliğin aktif olarak geçerli olması için içini boş bırakıyoruz.
   IT_SCARR                   = gt_scarr
   IV_ACTIVE                  = p_active "Smartformda iv_active tanımladık..
 EXCEPTIONS
   FORMATTING_ERROR           = 1
   INTERNAL_ERROR             = 2
   SEND_ERROR                 = 3
   USER_CANCELED              = 4
   OTHERS                     = 5
          .
if sy-subrc <> 0.
* Implement suitable error handling here
endif.
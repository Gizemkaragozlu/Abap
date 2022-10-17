Se11 den Datatype->ZGK_SCARR_TT oluşturduk.
Smartformdan IT_SCARR TYPE ZGK_SCARR_TT yazdık.(gt_scarr yerine)
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_SMARTFORMS_DRIVE.

DATA: gv_fm_name type RS38L_FNAM, 
      gs_control TYPE SSFCTRLOP, "Smartformda yaptığımız çalışmanın source code control ve output type.
      gs_output_opt TYPE SSFCOMPOP.


START-OF-SELECTION.

gs_control-no_dialog = abap_true. "//Popup ekranı çıkmasın diye yazılır.
gs_control-preview = abap_true.  "// Çıktı ekranı basabilmesi için yazılır.
gs_output_opt-tddest = 'LP01'.

call function 'SSF_FUNCTION_MODULE_NAME'
  exporting
    formname                 = 'ZGK_001'
 IMPORTING
   FM_NAME                  =  gv_fm_name     " // aşağıda yazdığımız smartformumuzu dönderir..
          .
if sy-subrc <> 0.
* Implement suitable error handling here
endif.



call function gv_fm_name " call function /1BCDWB/SF00000088 böyle açtık sonra data da gv_fm_name oluşturduk buraya yapıştırdık.
 EXPORTING
   CONTROL_PARAMETERS         = gs_control
   OUTPUT_OPTIONS             = gs_output_opt
   USER_SETTINGS              = ' '  " // Değişikliğin aktif olarak geçerli olması için içini boş bırakıyoruz.

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
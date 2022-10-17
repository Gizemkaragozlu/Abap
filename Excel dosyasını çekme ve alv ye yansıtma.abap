 "Parametre yanında serch help ve serch helpe tıklanınca dosya seçme seçeneği çıkar.
  "Seçilen Tabloyu alv ye yansıtma..

  TYPE-POOLS: truxs,
        slis.

TYPES: BEGIN OF t_itab,
      col1 TYPE char20,
      col2 TYPE char20,
      col3 TYPE char20,
      col4 TYPE char20,
   END OF t_itab,
   t_it_itab type STANDARD TABLE OF t_itab.

Data: gt_tab TYPE t_it_itab,
  wa_tab TYPE t_itab,
  g_numrows TYPE i.

PARAMETERS: p_fname TYPE c LENGTH 50.

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.
AT SELECTION-SCREEN on VALUE-REQUEST FOR p_fname.
DATA: l_filename LIKE  IBIPPARMS-PATH.
CALL FUNCTION 'F4_FILENAME'
 EXPORTING
   PROGRAM_NAME        = SYST-CPROG
   DYNPRO_NUMBER       = '1000'
 IMPORTING
   FILE_NAME           = l_filename
        .
p_fname = l_filename.

START-OF-SELECTION.

DATA: lc_fname TYPE RLGRAP-FILENAME,
  lt_tab TYPE TRUXS_T_TEXT_DATA.

  lc_fname = p_fname.

CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
  EXPORTING
    I_TAB_RAW_DATA             = lt_tab
    I_FILENAME                 = lc_fname
  TABLES
    I_TAB_CONVERTED_DATA       = gt_tab
  EXCEPTIONS
    CONVERSION_FAILED          = 1
  OTHERS                       = 2
      .
IF SY-SUBRC <> 0.
  WRITE 'Error'.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

" Delete First Row / HEADER
DELETE gt_tab INDEX 1.

IF gt_tab[] is INITIAL.
  MESSAGE 'No Record(s) found' TYPE 'I'.
  EXIT.
ELSE.
  PERFORM DisplayALv.
ENDIF.

FORM DISPLAYALV.
 DATA: l_it_fcat type SLIS_T_FIELDCAT_ALV,
       l_wa_fcat TYPE SLIS_FIELDCAT_ALV.

l_wa_fcat-fieldname = 'COL1'.
l_wa_fcat-inttype = 'C'.
l_wa_fcat-outputlen = '30'.
l_wa_fcat-text_fieldname = 'ID'.
l_wa_fcat-seltext_s = 'ID'.
 APPEND l_wa_fcat TO l_it_fcat.
 CLEAR l_wa_fcat.



l_wa_fcat-fieldname = 'COL2'.
l_wa_fcat-inttype = 'C'.
l_wa_fcat-outputlen = '30'.
l_wa_fcat-text_fieldname = 'NO'.
l_wa_fcat-seltext_s = 'NO'.
 APPEND l_wa_fcat TO l_it_fcat.
 CLEAR l_wa_fcat.

 l_wa_fcat-fieldname = 'COL3'.
l_wa_fcat-inttype = 'C'.
l_wa_fcat-outputlen = '30'.
l_wa_fcat-text_fieldname = 'AIRFARE'.
l_wa_fcat-seltext_s = 'AIRFARE'.
 APPEND l_wa_fcat TO l_it_fcat.
 CLEAR l_wa_fcat.

  l_wa_fcat-fieldname = 'COL4'.
l_wa_fcat-inttype = 'C'.
l_wa_fcat-outputlen = '30'.
l_wa_fcat-text_fieldname = 'CURR'.
l_wa_fcat-seltext_s = 'CURR'.
 APPEND l_wa_fcat TO l_it_fcat.
 CLEAR l_wa_fcat.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    I_CALLBACK_PROGRAM       = sy-repid
    IT_FIELDCAT              = l_it_fcat
    I_DEFAULT          = 'X'
    I_SAVE             = 'A'
  TABLES
    T_OUTTAB           = gt_tab[].

IF SY-SUBRC <> 0.
  WRITE: 'SY-SUBRC: ', SY-SUBRC .
ENDIF.

ENDFORM.
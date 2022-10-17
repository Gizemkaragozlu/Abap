REPORT ZGK_REUSE_ALV.
TYPES: BEGIN OF gty_list,
  ebeln TYPE ebeln,
  ebelp TYPE ebelp,
  BSTYP TYPE EBSTYP,
  BSART TYPE bSART,
  matnr TYPE matnr,
  menge TYPE bstmg,
  END OF gty_list.
   DATA: gt_list TYPE TABLE OF gty_list,
         gs_list TYPE gty_list.

   DATA:gt_fieldcatalog TYPE slis_t_fieldcat_alv,
         gs_fieldcatalog TYPE slis_fieldcat_alv.

   DATA: gs_layout TYPE  SLIS_LAYOUT_ALV.

START-OF-SELECTION.

select
  ekko~ebeln"kolonları alır...
  ekpo~ebelp
  ekko~BSTYP
  ekko~BSART
  ekpo~matnr
  ekpo~menge
   from ekko
  INNER JOIN ekpo on ekpo~ebeln eq ekko~ebeln"iki tablodaki ortak key leri alır ve birleştirir...
  into TABLE gt_list.


  CLEAR gs_fieldcatalog-fieldname.
    gs_fieldcatalog-fieldname = 'ebeln'.
    gs_fieldcatalog-seltext_s = 'sas no'."kolon başlığı kısa orta ve uzun olarak yazdık...
    gs_fieldcatalog-seltext_m = 'sas numarası'.
    gs_fieldcatalog-seltext_l = 'sas numarası'.
*    gs_fieldcatalog-key      = abap_true."key yapmak için...
    gs_fieldcatalog-col_pos   = 0."kolon sırasını belirler...
    gs_fieldcatalog-outputlen = 15."genişilik...
    gs_fieldcatalog-edit      = abap_true."Edit yazmamızı,düzenlememizi sağlar...
    gs_fieldcatalog-hotspot   = abap_true."Altını çizer...
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

    CLEAR gs_fieldcatalog-fieldname.
    gs_fieldcatalog-fieldname = 'ebelp'.
    gs_fieldcatalog-seltext_s = 'kalem'.
    gs_fieldcatalog-seltext_m = 'kalem'.
    gs_fieldcatalog-seltext_l = 'kalem'.
*    gs_fieldcatalog-key       = abap_true.
     gs_fieldcatalog-col_pos  = 0.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

    CLEAR gs_fieldcatalog-fieldname.
    gs_fieldcatalog-fieldname = 'BSTYP'.
    gs_fieldcatalog-seltext_s = 'belge tip'.
    gs_fieldcatalog-seltext_m = 'belge tipi'.
    gs_fieldcatalog-seltext_l = 'belge tipi'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

      CLEAR gs_fieldcatalog-fieldname.
    gs_fieldcatalog-fieldname = 'BSART'.
    gs_fieldcatalog-seltext_s = 'belge tür'.
    gs_fieldcatalog-seltext_m = 'belge türü'.
    gs_fieldcatalog-seltext_l = 'belge türü'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.


    CLEAR gs_fieldcatalog-fieldname.
    gs_fieldcatalog-fieldname = 'matnr'.
    gs_fieldcatalog-seltext_s = 'malzeme'.
    gs_fieldcatalog-seltext_m = 'malzeme'.
    gs_fieldcatalog-seltext_l = 'malzeme'.
  APPEND gs_fieldcatalog TO gt_fieldcatalog.

    CLEAR gs_fieldcatalog-fieldname.
    gs_fieldcatalog-fieldname = 'menge'.
    gs_fieldcatalog-seltext_s = 'miktar'.
    gs_fieldcatalog-seltext_m = 'miktar'.
    gs_fieldcatalog-seltext_l = 'miktar'.
    gs_fieldcatalog-do_sum    = abap_true."toplam miktar
  APPEND gs_fieldcatalog TO gt_fieldcatalog.



gs_layout-window_titlebar   = 'Layout yapısını öğreniyoruz'.
gs_layout-zebra             = abap_true.
gs_layout-colwidth_optimize = abap_true."kolon genişliğini ayarlar...
call function 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = ' '
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
   IS_LAYOUT                         = gs_layout
   IT_FIELDCAT                       = gt_fieldcatalog
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  tables
    t_outtab                          = gt_list
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
if sy-subrc <> 0.
* Implement suitable error handling here
endif
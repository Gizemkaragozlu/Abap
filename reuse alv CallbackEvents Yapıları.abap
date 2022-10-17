abap reuse alv events get:
SE37 veya SE80 gibi ilgili SAP işlemine REUSE_ALV_EVENTS_GET adını girerek tam işlev modülü belgelerini ve kod listesini görüntülemek için buraya bakın .
orm display_alv .
*  // Events yapısı normal bir top_page gibi çalışır default değer dönderir...
gs_event-name = slis_ev_top_of_page.
gs_event-form = 'TOP_OF_PAGE'."//END_OF LIST yazarsam tablonun sonunda gösterir...
APPEND gs_event TO gt_events.
 call function 'REUSE_ALV_GRID_DISPLAY' " Pattern yani örnek kısmından REUSE_ALV_GRID_DISPLAY yazıp Enterlıyoruz..
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = sy-repid //CallbackEvents 
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
"TOP_OF_PAGE = bulunduğu sayfanın üzerinde Top of Page alanları bulunmaktadır.
" Bu alanlara istediğimiz bilgiyi oluşturarak yansıtabilmekteyiz.
*   I_CALLBACK_TOP_OF_PAGE            = 'TOP_OF_PAGE ' "// default bir top_of_page açılır...
                                                       "//Buraya istediğimiz isim yazılabilir form kısmına da aynı yazmak şartı ile...
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
   IT_EVENTS                         = gt_events
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
    t_outtab                          = gty_list
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
if sy-subrc <> 0.
* Implement suitable error handling here
endif.
*PERFORM top_of_page.

endform.

form top_of_page .

endform.

#ZGK_REUSE_ALV_TOP#
DATA: gs_layout TYPE  SLIS_LAYOUT_ALV.
   DATA: gt_events TYPE SLIS_T_EVENT," içerde event oluşturduk.internal tablein structuresini oluşturduk...
         gs_event TYPE slis_alv_event.
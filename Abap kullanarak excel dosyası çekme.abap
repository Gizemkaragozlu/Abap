*&---------------------------------------------------------------------*
*& Report ZGK_EXCEL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zgk_excel.
" Tablonun kolonlarını teker teker belirttik..

TYPES: BEGIN OF gty_scarr,
  carrid TYPE scarr-carrid,
  carrname type scarr-carrname,
  currcode TYPE scarr-currcode,
  url  TYPE scarr-url,
  END OF gty_scarr.


data: it_row type truxs_t_text_data.
data gt_tab type table of gty_scarr.

parameters: p_file type rlgrap-filename.

at selection-screen on value-request for p_file. "Seçim ekranının değer talebei alanında göster..

  call function 'F4_FILENAME' "Yerel ekranda belirli bir dosya seçmemizi sağlar.
    exporting
      field_name = 'P_FILE'
    importing
      file_name  = p_file.

start-of-selection.
  call function 'TEXT_CONVERT_XLS_TO_SAP' "excel sayfasından veri almak ve dahili bir tabloya yüklemek için kullanılır..
    exporting
      i_line_header        = 'X'
      i_tab_raw_data       = it_row
      i_filename           = p_file
    tables
      i_tab_converted_data = gt_tab
    exceptions
      conversion_failed    = 1
      others               = 2.
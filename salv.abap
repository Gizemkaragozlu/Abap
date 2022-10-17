internal table oluştur salv bağla sonra ekrana bas.
se38 ile

"Basit SALV
*DATA: gt_sbook TYPE TABLE OF sbook,//"sbook hazır tablo
*      go_salv TYPE REF TO cl_salv_table."go global object...
*
*START-OF-SELECTION.
*select * UP TO 20 ROWS FROM sbook"internal table içini dolduralım,sbook tablosunun ilk 20 satırını ekrana basar...
*  into TABLE gt_sbook.
*  "salv bağlamak için yazılan kod...
*cl_salv_table=>factory(
*  importing
*    r_salv_table   = go_salv
*  changing
*    t_table        = gt_sbook
*).
*
*go_salv->display( ). "Ekrana basalım...

DATA: gt_sbook TYPE TABLE OF sbook,
      go_salv TYPE REF TO cl_salv_table."go global object...
DATA:lo_display TYPE REF TO cl_salv_display_settings.
DATA:lo_cols TYPE REF TO cl_salv_columns.
DATA:lo_col TYPE REF TO cl_salv_column.
DATA:lo_func TYPE REF TO cl_salv_functions.

DATA:lo_header TYPE REF TO cl_salv_form_layout_grid,"lo local object
      lo_h_label TYPE REF TO cl_salv_form_label,
      lo_h_flow TYPE REF TO cl_salv_form_layout_flow.

START-OF-SELECTION.
select * UP TO 20 ROWS FROM sbook"internal table içini dolduralım,sbook tablosunun ilk 20 satırını ekrana basar...
  into TABLE gt_sbook.
  "salv bağlamak için yazılan kod...
cl_salv_table=>factory(
  importing
    r_salv_table   = go_salv
  changing
    t_table        = gt_sbook
).
lo_display = go_salv->get_display_settings( ).
lo_display->set_list_header( VALUE = 'SALV EĞİTİM')."'Başlığı değiştirmemizi sağlar'...
"get bir objenin datasını değiştirmek için kullanılır,
"set bir özellik değiştirmek için kullanılır...
lo_display->set_striped_pattern( value = 'X' )."kolonlara bir açık bir koyu olacak şekilde zebra özelliği verir,key olanlarda değişiklik yaşanmaz...
lo_cols = go_salv->get_columns( )."satır uzunluğunu yazıya göre ayarlar kısar...
lo_cols->set_optimize(
    value = 'X').
lo_col = lo_cols->get_column( columnname = 'LUGGWEIGHT' )."Değiştirmek istediğim kolonun adı...
lo_col->set_long_text('Gizem')."Yeni tanımların uzun,orta ve kısa olarak görünecek tanımlar...
lo_col->set_medium_text('Giz').
lo_col->set_short_text('Gi').

*lo_col = lo_cols->get_column( columnname = 'CARRID' ).
*lo_col->set_visible(
*    value = if_salv_c_bool_sap=>false "Carrıd kolonunu false olduğu için göstermez ...
*    ).

lo_func = go_salv->get_functions( )."Alv Toolbar eklemek için yazılan kod...
lo_func->set_all(
   value = if_salv_c_bool_sap=>true ).

CREATE OBJECT lo_header." Tablomuzun üst kısmına başlık niteliğinde yazılar yazmamızı sağlayan yapı...
 lo_h_label = lo_header->create_label( row = 1 column = 1 ).
 lo_h_label->set_text( value = 'Birinci Başlık'  ).
 lo_h_flow = lo_header->create_flow( row = 2 column = 1 ).
 lo_h_flow->create_text(

   text     = 'İkinci Başlık'

 ).

go_salv->set_top_of_list( value = lo_header )."Alv ye bağlamamızı sağlar...
go_salv->set_screen_popup( "Tablomuzu popup şekline almamızı sağlar...
  exporting
    start_column = 10
    end_column   = 75
    start_line   = 5
    end_line     = 15
).
go_salv->display( ). "Ekrana basalım...
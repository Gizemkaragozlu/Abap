SAP İLE MAİL GÖNDERME

*&---------------------------------------------------------------------*
*& Report ZGK_MAIL_GONDERME
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_MAIL_GONDERME.

DATA: msg type REF TO cl_bcs_message.
CREATE OBJECT msg.

"Mail Türü Kime Gideceği ve Ekrana gelecek mesaj
msg->set_subject('Test Subject').
msg->set_main_doc( iv_contents_txt = 'Test e-mail').
msg->add_recipient('gizemkaragozlu@gmail.com').


"Hamgi tabloyu yollamak istiyorsak o tabloyu yazalım buradaki spfli tablosu
DATA: outtab TYPE TABLE OF spfli,
      table TYPE REF TO cl_salv_table.

SELECT * FROM spfli into TABLE outtab. 

  TRY.
    CALL METHOD cl_salv_table=>factory

      importing
        r_salv_table   = table                          " Basis Class Simple ALV Tables
      changing
        t_table        = outtab.
  CATCH cx_salv_msg.
  ENDTRY.

  DATA: v_xstring TYPE xstring.
  v_xstring = table->to_xml( if_salv_bs_xml=>c_type_xlsx ).


"Gönderilen Rapor Adı"
  msg->add_attachment(
    exporting
      iv_doctype      =  'EXT'                " Document Type
      iv_filename     =  'REPORT.XLSX'               " File Name (with Extension)
      iv_contents_bin =  v_xstring             " Binary Document Content
).

  msg->send( ).

MESSAGE 'Message sent' TYPE 'S'.
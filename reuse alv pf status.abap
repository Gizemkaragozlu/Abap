# PF STATUS #

kopyalamak için se38 den saplsalv guı status kısmından standart olanı kopyaladık program ismimizi yazdık.
se41 den de kopyalama işlemi yapılır(status)...
form pf_status_set USING p_extab TYPE slis_t_extab .
set PF-STATUS 'STANDARD'.

*  // Events yapısı normal bir top_page gibi çalışır default değer dönderir...
  gs_event-name = slis_ev_top_of_page.
  gs_event-form = 'TOP_OF_PAGE'."//END_OF LIST yazarsam tablonun sonunda gösterir...
  append gs_event to gt_events.

  gs_event-name = slis_ev_end_of_list.
  gs_event-form = 'END_OF_LIST'.
  append gs_event to gt_events.

   gs_event-name = slis_ev_pf_status_set.
  gs_event-form = 'PF_STATUS_SET'.
  append gs_event to gt_events.


form top_of_page.
  "Top_of_page içini dolduran yapı...
  data: lt_header type slis_t_listheader,
        ls_header type slis_listheader.
  DATA: lv_lines TYPE i.

  CLEAR:ls_header.
  DESCRIBE TABLE gt_list LINES lv_lines. "lv_lines data kısmında oluşturmak gerekiyor". //Tabledaki satır sayısını yakalamamızı sağlıyor...
  ls_header-typ = 'H'. " 'H' Büyük harfler ile başlık formatında yazar...
  ls_header-info = 'Satınalma Sipariş Motoru'.
  append ls_header to lt_header."Append komutu , varolan bir dahili tabloya tek bir satır ekler.
  "internal table atar...

  CLEAR:ls_header.
  ls_header-typ = 'S'. "'S'Başlığın altında yazar..." 'A' italik şeklinde yazar...
  ls_header-key = 'Tarih:'."Bold şeklinde..."
  ls_header-info = '15.09.2022'.

  append ls_header to lt_header.


  call function 'REUSE_ALV_COMMENTARY_WRITE'
    exporting
      it_list_commentary = lt_header.


     I_CALLBACK_PF_STATUS_SET          = 'PF_STATUS_SET  '
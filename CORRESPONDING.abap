CORRESPONDING: İki eşleştirmeye çalıştığın yapı bir birinden farklı ise bu hatayı düzeltmeye sağlayan yapı..

TYPES: BEGIN OF gty_type1,
         col1 TYPE char10,
         col2 TYPE char10,
         col3 TYPE char10,
         col4 TYPE char10,
  END OF gty_type1.


  TYPES: BEGIN OF gty_type2,
           col2 TYPE char10,
           col3 TYPE char10,
  END OF gty_type2.

DATA: gs_st1 TYPE gty_type1,
      gs_st2 TYPE gty_type2,
      gs_st3 TYPE gty_type2.

  START-OF-SELECTION.
  gs_st1-col1 = 'aaaa'."4 tane kolon oluşturduk..
  gs_st1-col2 = 'bbbb'.
  gs_st1-col3 = 'cccc'.
  gs_st1-col4 = 'dddd'.

*  gs_st2 = gs_st1.

MOVE-CORRESPONDING gs_st1 TO gs_st2."//Kolon bazında atamamı gerçekleştir..
move gs_st1 TO gs_st3."//Kolonları,satırları düzensiz yer değiştirmiş şekilde gösterir,kolon eşleştirmesi  yapmaz rasgele dağıtır..

  BREAK-POINT.

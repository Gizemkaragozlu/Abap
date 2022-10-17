REPORT ZGK_DINAMIK_SELECTIONSCREEN.
*PARAMETERS:p_num TYPE int4.
*  INITIALIZATION.
*  BREAK-POINT.
**  //Blokların ne zaman çalıştığını görmemizi sağlar...
*
*  AT SELECTION-SCREEN OUTPUT.
**    //Ekrana gelmeden ve ekran her yenilendiğinde açılan ekran..
*//İstediğimiz kadar tetikleyebilmemizi sağlar...
*  BREAK-POINT.
*
*  START-OF-SELECTION.
*  BREAK-POINT.

*DATA:gv_num TYPE i.
*PARAMETERS p_num1 TYPE int4 MODIF ID gr1.
*select-OPTIONS : s_num2 for gv_num MODIF ID gr1.
**//Selection screen iki değer girmemizi sağlar...
**//Modıf ıd,id atamamızı sağlar...
*INITIALIZATION.
*LOOP AT SCREEN.
*  IF screen-group1 eq 'GR1'.
*    screen-display_3d = 1.
*    screen-input = 0.
*    MODIFY SCREEN.
*  ENDIF.
*  ENDLOOP.

*PARAMETERS: p_num1 TYPE int4 MODIF ID gr1,
*            p_num2 TYPE int4 MODIF ID gr1,
*            p_num3 TYPE int4 MODIF ID gr2,
*            p_num4 TYPE int4 MODIF ID gr2,
*            p_num5 TYPE int4 MODIF ID gr3,
*            p_num6 TYPE int4 MODIF ID gr3.
*INITIALIZATION.
*LOOP AT SCREEN.
*  IF screen-group1 eq 'GR1'.
*    screen-display_3d = 1.
*    screen-input = 0.
*    MODIFY SCREEN.
*  ENDIF.
*
*
*  IF screen-group1 eq 'GR2'.
*    screen-input = 0.
*    MODIFY SCREEN.
*  ENDIF.
*
*  ENDLOOP.

PARAMETERS:rad1 RADIOBUTTON GROUP rgr1 DEFAULT 'X' USER-COMMAND usr1,
           rad2 RADIOBUTTON GROUP rgr1.
*//Default 'X' dersek radiobutton seçili olarak gelir...
PARAMETERS: p_lifnr TYPE lifnr MODIF ID gr1 DEFAULT 'Satıcı numarası',
            p_lifnrn TYPE name1_gp MODIF ID gr1 DEFAULT 'Satıcı tanımı',
            p_kunnr TYPE kunnr MODIF ID gr2 DEFAULT 'Müşteri numarası',
            p_kunnrn TYPE name1_gp MODIF ID gr2 DEFAULT 'Müşteri tanımı'.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
*    //Loop at screen sürekli bir döngü içersinde olma durumu...
    IF rad1 eq abap_true.
      IF screen-group1 eq 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
*       // MODIFY SCREEN UNUTULURSA EKRANDA İŞLEM GOZUKMEYCEKTİR...
      ENDIF.
      IF screen-group1 eq 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      ENDIF.
      IF rad2 eq abap_true.
      IF screen-group1 eq 'GR2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 eq 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.

      ENDIF.
      ENDIF.
    ENDLOOP.
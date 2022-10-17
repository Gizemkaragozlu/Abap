0100
PROCESS BEFORE OUTPUT.
 MODULE STATUS_0100.
   CALL SUBSCREEN sub1 INCLUDING sy-repid '101'.//programdan çağırır.
   CALL SUBSCREEN sub2 INCLUDING sy-repid '102'.
PROCESS AFTER INPUT.
 MODULE USER_COMMAND_0100.
   CALL SUBSCREEN sub1.//Tetiklenmesi için yazılır.
   CALL SUBSCREEN sub2.

DATA: gs_sflight TYPE sflight.
*tablonun her kolonundan birer tane veri tutmamızı sağlar...
PARAMETERS: p_CARRID TYPE	S_CARR_ID,
            p_CONNID TYPE	S_CONN_ID,
            p_FLDATE  TYPE S_DATE.
*tablodan istenilen kolonlar...
START-OF-SELECTION.
Select SINGLE * FROM sflight
*  tüm tablodan bir veri çekilecek...
  INTO gs_sflight
*  çektiğim datayı structure doldur...
  WHERE  CARRID EQ p_CARRID
       and CONNID EQ p_CONNID
       and FLDATE EQ p_FLDATE.
*  bu üç keyimizi alalım...

call SCREEN '0100'.
*ana sayfa niteliğinde 0100
//se16n deki tablo bilgilerimizi hangi keyi yazdıysak onları ekrana getirir...

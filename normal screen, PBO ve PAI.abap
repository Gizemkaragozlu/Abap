se38 ile program oluşturduktan sonra üst sekme bölümünde DİSPLAY OBJECT LİST e basıp çıkan object name alt kısmında klasör isimlerini görebiliriz.
klasör ismine sağ tik yaıpı creat ile diğer işlemler yapılır.
*&---------------------------------------------------------------------*
*& Report ZGK_NORMALSCREEN_PBO_PAI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_NORMALSCREEN_PBO_PAI.

START-OF-SELECTION.

call SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module status_0100 output.' Screen ekran açılmadan önce çalışacak kısım'.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.
endmodule.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module user_command_0100 input.'Screen ekrana geldikten sonra açılan kısım'.

endmodule.

SY-UCOMM=TIKLANILDIĞINDA yazılan function 
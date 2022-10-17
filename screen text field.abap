se38 ile program oluşturduktan sonra üst sekme bölümünde DİSPLAY OBJECT LİST e basıp çıkan object name alt kısmında klasör isimlerini görebiliriz.
klasör ismine sağ tik yaıpı creat ile diğer işlemler yapılır.

Creat-> screens seçelim aktif olmayan kodlarımızı aktif edelim.

*&---------------------------------------------------------------------*
*& Report ZGK_SCREENTEXTFIELD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_SCREENTEXTFIELD.

START-OF-SELECTION.//
call SCREEN 0100.// bunları da kendimiz yazıyoruz aynı şekilde 0100 verdim.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module status_0100 output.
  SET PF-STATUS '0100'.//0100 screen adın neyse onu yaz ben 0100 yaptım.
*  SET TITLEBAR 'xxx'.
endmodule.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module user_command_0100 input.

CASE sy-ucomm.//kullanıcının belirli bir olayda yapmak istediği işlevleri yapmak içindir.
  WHEN '&Back'.// geri tuş sembolümüze back adını atadık
    LEAVE TO SCREEN 0.//Bir önceki ekrana düşer. Programdan değil bloktan çıkar yada içinde bulunduğu LOOP tan çıkar.
ENDCASE.
endmodule.
//oluşturulmuş screen a tıklayıp üst kısımda layout tıklanır text simgesi seçilir text ve id yazılır.
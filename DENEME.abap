1-include ile global değişken oluştur top,pbo,pai,frm.
2-çift tıkla oluştur.
3-screen olştur. flow logic oluştur üstekini seç pbo tıkla, alttakini seç pai tıkla.
4-pbo tıkla gui status oluştur(0100) $back yazalım.
5.gui status title oo alvyazdık başlık olarak.
6-paı case sy-ucomm. when &back, set screen0 yap.
7-start-of-selection altına call screen 0100 yaz.
-----screenn oluştu---------
8-layout aç en altın bir üstünde olacak cc_alv diye id verdik
/////////Top/////////
*&---------------------------------------------------------------------*
*&  Include           ZGK_ALV_OO_ALV_KULLANIM_TOP
*&---------------------------------------------------------------------*

"Alv
DATA: go_alv TYPE REF TO CL_GUI_ALV_GRID, "oo_alv yi tanımladık
      go_container type REF TO CL_GUI_CUSTOM_CONTAINER. "alvyi tutcak bir de container ihtiyaç var onu da tanımladık

"Table data
DATA gt_scarr TYPE TABLE OF scarr.


////////PBO////////
*&---------------------------------------------------------------------*
*&  Include           ZGK_ALV_OO_ALV_KULLANIM_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  PERFORM dispaly_alv. "Alvyi ekrana basma

ENDMODULE.

//////////PAI///////////
*&---------------------------------------------------------------------*
*&  Include           ZGK_ALV_OO_ALV_KULLANIM_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.


CASE sy-ucomm.
  WHEN '&BACK'.
    SET SCREEN 0.
ENDCASE.
ENDMODULE.

///////////FRM/////////////
*&---------------------------------------------------------------------*
*&  Include           ZGK_ALV_OO_ALV_KULLANIM_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DISPALY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPALY_ALV .

CREATE OBJECT GO_CONTAINER "bu kısımda da alv ye vercegimiz containırı oluşturuyoruz
  exporting
    CONTAINER_NAME                 =        'CC_ALV'."layout uzernde oluşturdugumuz custom container id si     


CREATE OBJECT GO_ALV "Alvyi kullanmak için oluşturmamı gerekir
  exporting
    I_PARENT          =   go_container    ."container id si verilcek ama once oluşturulack
     "CL_GUI_CONTAINER=>SCREEN0 / da yazabilirdim hehrnagi bir contiane roluşturmadan da kullanabilirim



call METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY "ekrana basmak için methodu çağırmamız gereklidir
  exporting
    I_STRUCTURE_NAME              =          'SCARR'        " Ekrana basılcak tablo tipi
  changing
    IT_OUTTAB                     =        gt_scarr  . "Veri bascagımız tablo.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA .

SELECT * from scarr into TABLE gt_scarr.

ENDFORM.


//////////MAIN////////
*&---------------------------------------------------------------------*
*& Report ZGK_ALV_OO_ALV_KULLANIM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_ALV_OO_ALV_KULLANIM.

INCLUDE ZGK_ALV_OO_ALV_KULLANIM_TOP.
INCLUDE ZGK_ALV_OO_ALV_KULLANIM_PBO.
INCLUDE ZGK_ALV_OO_ALV_KULLANIM_PAI.
INCLUDE ZGK_ALV_OO_ALV_KULLANIM_FRM.

START-OF-SELECTION.


PERFORM get_data. "Tabloya veir çekme

  CAll SCREEN 0100.

///////////////////////////////////////////////////////
OO alv genelde hem screen uzerinde hemde screensiz kullanıma sahiptir
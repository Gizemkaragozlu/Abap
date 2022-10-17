se93: yeni z li program oluşturmamızı sağlar

se38 ile şunları yazdık;
*&---------------------------------------------------------------------*
*& Report ZGK_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGK_SELECTION_SCREEN.

PARAMETERS p_uname TYPE uname. //parametre oluşturduk

START-OF-SELECTION.

WRITE:p_uname.
//////////////////////////////////////////
se93 ile selection screen açtık program kısmına se38 ile açtığım ismi yapıştırdım.
Transcation code kısmında yazan yeri tcode kısmına yapıştır ve enter yap se38 de yapılanlar burada gözükecektir.
//////////////////////////////////////////
Dynprno Tcode: yukarıdaki işlemlerin aynısını yapıyoruz tek farkı se38 de screen oluşturuyoruz ve se93 kısmında screen number veriyoruz(screen numarası)
//////////////////////////////////////////
Tablo çağırma : Önecden oluşturduğumuz bakım tablomuzu çağıracağız.
se93 den en alt kısımda Transaction with parameters seçelim,

Transaction = sm30 skip inital screen ok
Default Vales->name of screen: viewname = ZGK_PERLIST //tablo ismim
                               update   = X

Nasıl Kontrol Ederim? se93 de hangi isimle açıldıysa ör:ZGK_EGT_03
                      bununla açılır konrol edilir.
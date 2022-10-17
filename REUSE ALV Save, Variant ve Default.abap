#Save:

I_SAVE = ' ' --> Display varyants cannot be saved
I_SAVE = 'X' --> Standart save mode
I_SAVE = 'U' --> User-specific save mode
I_SAVE = 'A' --> Standart and user-specific save mode

 I_SAVE  = 'X'
 I_SAVE  = 'A'  User-specific aktif durumda olur .


//Tabloyu kendi isteğimize göre gizleme yer değiştirme yaptıktan sonra,
Save Layout butonundan (küçük küp kareli olan) tanım girip kaydedelim default setting seçersek,
tablo kayıtlı kalır.
Select layout kısmından tablomuzu seçip görebiliriz...

#Variant:
Yapılan değişikliği kaydetmeye Varyant denir.
////////////////////////////////////////////////
ZGK_REUSE_ALV:
initialization.
gs_variant_get-report = sy-repid.
  call function 'REUSE_ALV_VARIANT_DEFAULT_GET'
    changing
      cs_variant    = gs_variant_get
    exceptions
      wrong_input   = 1
      not_found     = 2
      program_error = 3
      others        = 4.
  if sy-subrc eq 0.
p_vari = gs_variant_get-variant.
  endif.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
  gs_variant_get-report = sy-repid.
call function 'REUSE_ALV_VARIANT_F4'
  exporting
    is_variant                = gs_variant_get
 IMPORTING
   E_EXIT                    = gv_exit
   ES_VARIANT                = gs_variant_get
 EXCEPTIONS
   NOT_FOUND                 = 1
   PROGRAM_ERROR             = 2
   OTHERS                    = 3
          .
if sy-subrc eq 0.
IF  gv_exit IS INITIAL.
p_vari = gs_variant_get-variant.
ENDIF.
endif.
////////////////////////////////////////
ZGK_REUSE_ALV_TOP:
   DATA: gs_variant TYPE disvariant.
   DATA: gs_variant_get TYPE disvariant,
         gv_exit TYPE char1.

   PARAMETERS p_vari TYPE disvariant-variant.
////////////////////////////////////////////
ZGK_REUSE_ALV_FRM:
 gs_variant-variant = p_vari ." Hangi tabloyu görmek istiyorsak onu yazmalıyız..

#Default:
 I_DEFAULT                = 'X' //Burası X olursa ön ayarlı yapıdan etkilenir. X değilse boş ise alv nin oynanmamış kendi yapısını getirir..
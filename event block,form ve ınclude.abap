se38 ile yapıyoruz...
Event Block:program akışını düzene sokmak için ve takibini yapan key
INITIALIZATION:ekrana girilen user keyleri yazacağımız anı.
AT SELECTION-SCREEN:input parametrelerini özelleştirmeyi sağlayan parametre.
START-OF-SELECTION:run edeceğimiz yerleri bu parametrenin altına yazıyoruz.
END-OF-SELECTION:formları kullanacağımız parametre.

# Event Block #
PARAMETERS p_num TYPE int4.
INITIALIZATION.//üst tarafa parametre yazılır.
  p_num = 12.//ekranda 12 olarak girilir.
AT SELECTION-SCREEN.//enter yapınca birer birer arttırır.
  p_num = p_num + 1.

START-OF-SELECTION.//f8 yapınca ekranda write ile yazılan alan belirir.
  WRITE 'START-OF-SELECTION'.

END-OF-SELECTION.//f8 yapınca ekranda write ile yazılan alan belirir.
  WRITE'END-OF-SELECTION'.

# Form #
INITIALIZATION.
AT SELECTION-SCREEN.
START-OF-SELECTION.
PERFORM sayiya_bir_ekle.//performu ne kadar arttırırsan ekrana o kadar sayı gelir.
WRİTE gv_num1.

PERFORM iki_sayinin_carpimi USİNG 10// aşağıda belirttiğimiz iki sayıyı çarpmak için buraya perform girilir.
                                  5.
                                  
END-OF-SELECTION.
FORM sayiya_bir_ekle.
gv_num1 = gv_num1 + 1.//gv =global demek
ENDFORM.

FORM iki_sayinin_carpimi USING p_num1//iki sayıyı çarpmak için kullanıyoruz.
                               p_num2.
DATA:lv_sonuc TYPE int4.
lv_sonuc = p_num1 * p_num2.//l ile başlıyorsa local demek.
WRİTE: 'Sonuç = ', lv_sonuc.
ENDFORM.

# include #

se38 ile aç yürütülebilir program yerine include yazanı tıkla
önceden açtığımız bir programdan işlemi kesip yeni açtığımız include yapıştırırıyoruz.
INCLUDE ZGK_INCLUDE.//INCLUDE oluşturmak için çift tıkla.




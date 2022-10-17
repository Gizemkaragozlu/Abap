se80: function grup.programlar ve dd-obj geliştirmek ve gezinmek için bir araçtır.
ok işaretine basıp function grubu seçelim.
örneğin:zgk_function adını verdim.
ıncludes kısmında aktif olmayanları active edelim.

se37:Fonksiyon modülü oluşturma.
oluşturduktan sonra ...
IMPORT:Fonksiyon verilecek parametreler.
EXPORT:Fonksiyonun bize döneceği parametreler.
CHANGİNG:Değişmiş yapıları gösterir.
TABLES:Birden fazla satırın olduğu datalar vereceğimiz yapı.
EXCEPTİONS:Önceden hatayı görüp listeleyen yapı.
SOURCE CODE:Fonksiyonun yapacağı işlevin kodlandığı yer.

IMPORT= kısmında parametre adı,typing assoc.type,default value short text verdik.
ÖR:iv_num1.. type.. ınt4..10..bölen sayı

EXPORT= kısmından parametre adı,typing assoc.type,default value short text verdik.
ÖR:ev_num1.. type.. ınt4..sonuc

CHANGİNG= parametre name,typing,associated type
ÖR: cv_mes..type..char20

EXCEPTİONS= divided_by_zero SHORT TEXT cannot divide by zero 

SOURCE CODE= ev_sonuc = iv_num /iv_num2.
iv_num1 = 10.// değer vermek istersek hata verecek fakat 
ımport kısmına gelip PASS BY VALUE tıklarsak hata vermez değişiklik yapmaya izin verir.

ıf iv_num2 ıs ınıtıal.//hiç bir parametre girilmediğindeki kontrollerde işe yarıyor.
RAISE divided_by_zero// Exceptions çağırır.

# programda fonksiyon kullanma #
se38 ile
START-OF-SELECTION.
Pattern:örnek kısmından call function kısmına önceden yaptığımız se80 ile fonksiyon adımızı yapıştırıyoruz.

 
se24:class
METHODS:kısmına sum numbers.public değerlerini girdim.
parametres:iv_num1 type:importing pass:aktif et option:aktif et Associated type ınt 4 
parametreleri yazdıktan sonra source code kısmına aşağıdaki kodları yazıyoruz.
EV_RESULT = IV_NUM1 + IV_NUM2.

# programda kullanma #
se38 ile

data:go_eğitim_class type ref to ... clasadı//class ismini yaz
data: gv_num1 type int4,
gv_num2 type int4,
gv_result type int4.

start-of-selection.
create object go_egitim_class.

gv_num1 = 12.
gv_num2 = 15.

go_egitim_class -> sum_numbers// çift tıkla listelenecek.

write: gv_result.

STATIC METHOD:class ismini yazıp direkt erişilebiliriniz.
Attributes: cv_number Level: constant Visibity: public Associated Type:number_typ Inital Value:100
Methods: sum_numbers tıkla ..source code kısmına ev_result = iv_num1 + iv_num2 + cv_number.yazalım..

Friends: başka bir classı kullanma methodu.
se24 ile yeni bir class olşturalım.
method:dıff_numbers
 Level:Static Method 
Visibility:Public 
Description:difference numbers

METHODS kısmında önecki yaptığımız işlemeri yapıyoruz.
Source Code kısmına gelip:
 ev_result = iv_num1 - iv_num2.//bu şekilde yazıyoruz.
// Böylelikle ikinci classımız hazır hale geliyor.

METHODS kısmına gelip;diff_numbers,static method,public,difference numbers yazalım.
parametrelerimizi yazalım .

EVENTS:source code yazmadan yapıyı oluşturup istediğimiz her yerde kullanmamızı sağlar.
event:dıvıde_numbers
type:static event
visibility:public
descrition:divide numbers//bu şekilde yazdım farklı isimler de verilebilir.

Parameters:ıv_num1 ınt4 yapıp opsiyonel olarak tıklıyoruz.
Parameters:ıv_num2 ınt4 yapıp opsiyonel olarak tıklıyoruz.
Parameters:ev_result ınt4 yapıp opsiyonel olarak tıklıyoruz.

methods kısmına gelip yeni bir method adı verelim. daha sonra üst kısımda GO TO PROPERTES tıklayalım,
açılan pencerede object type ismi ne ise class/interface kısmına da aynı ismi girelim.
Event kısmına ise daha öneceden yazdığımız event ismimizi girelim.
source code kısmında gözükmesi için, parameters ksımına gelip sağ tarftaki event parameters kısmına basalım.
kaydedip aktif edelim.

INTERFACES: se24 ile açalım z_cl_egitim_ınterafce yazdık
olşturunca ınterface olarak seçelim.

ALİASES: bu kısma gelip visibilty public seçelim Alias parametre ismini yazalım







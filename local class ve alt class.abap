# Local Class #
class math_op definition.//Tanımlamaların yapıldığı yer.
public sectıon.
data:lv_num1 type i,
     lv_num2 type i,
     lv_result type i.
methods: sum_numbers.
endclass.

Class math_op_diff defınıtıon ınherıtıng from math_op.//alt class oluşturur.
public sectıon.
methods numb_diff.
endclass.

class math_op_diff ımplementatıon.//alt clasımızı ımplement ediyoruz.
method numb_diff.
lv_result = lv_num1 - lv_num2.
endmethod.
endclass.

class math_op ımplementatıon.// definition da tanımlanan methodu burda yazmak gerek.
method sum_numbers.
  lv_result = lv_num1 + lv_num2.
endclass.
//programda kullanımı...
Data:go_match_op type ref to match_op.//classı referans alır.
Data: go_math_op_diff type ref to math_op_diff.//alt class için dataya referans verelim.
start of selectıon.
CREATE OBJECT: go_match_op.//class kullanılabilir hale geldi.
create OBJECT go_math_op_diff.//alt class için oluşturduk.
go_match_op->lv_num1 = 12.//ekrana bastırdık,data değerleri girildi.
write: go_match_op->lv_result.

    go_math_op_diff->lv_num1 = 12.
    go_math_op_diff->lv_num2 = 15.
    go_math_op_diff->numb_diff( ).

WRITE: go_math_op_diff->lv_result.//alt clasımız için ekrana bastırdık.
//alt class da private erişilmiyor.
//protected da erişilmez.

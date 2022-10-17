sap abap temelleri-1
Program yaratmanın işlem kodu=>Se38
isimlendirmenin baş harfi z veya y ile başlanınca kullanımı daha kolay olur.
Başlangıç ekranında title belirlenir ve Tip seçilir örneğin Yürütülebilir program.

-Data Tipleri-
DATA gv_desg1=>#tanımlamak istediğim değişken ismi belirlenir. TYPE decimal ifade için p harfi yazılır.DECIMALS virgülden sonra kaç karakter olsun istersen sayı belirt.

data gv_degis1 type p decimals 3.//decimals
data gv_degis2 type int4 / int2 / int1 .//integer
data gv_gegis3 type n.  //numeric
data gv_degis4 type c. //char
data gv_degis5 type string.  //string

-Değer Verme-
gv_desg1 ='12.54' //decimals
gv_desg2 =123. //integer
gv_degs3 =654.//numeric
gv_degs4 ='A'.//char
gv_degs5 ='Gizmo.'//string



 
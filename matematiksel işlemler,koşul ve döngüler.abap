 Data gv_degis1 TYPE i.//integer
Data gv_degis2 TYPE n LENGTH 10.//numeric uzunluk 10

-İki nokta kullanımı-
DATA: gv_degis1 TYPE i.
      gv_degis2 TYPE n LENGTH 10.
      gv_sonuc TYPE i.
      gv_metin TYPE string.
      
//Her seferinde başına data yazmamak için iki nokta kullanılır.

-Yorum satırı-
başa* veya ctrl < ifadesi kullanılır.

gv_degis1 =64.
WRİTE gv_degis1.//Erkrana yazdır.
gv_degis2 =130.
WRİTE / gv_degis2.//Erkrana yazdır.// ALt satıra eklemek için'/'ifadesi kullanılır.

-Toplama işlemi-
gv_metin='Toplamı='.
gv_sonuc =gv_degis1+gv_degis2.
WRİTE: gv_metin,gv_sonuc.//String türünde metin yazıp yanına sonucu yazar.

-Çıkarma işlemi-
gv_sonuc =gv_degis1-gv_degis2.
WRİTE:/'Farkı=', gv_sonuc.//metin tanımlamadan direk bu şekilde de kullanılabilir.

-Çarpma işlemi-
gv_sonuc =gv_degis1g*v_degis2.
WRİTE gv_sonuc.

-Bölme işlemi-
gv_sonuc =gv_degis1/gv_degis2.
WRİTE gv_sonuc.

-İf koşul ifadeleri-
ıf gv_degis1 > gv_degis2.//degis1 ifadesi büyükse koşul doğrudur.
Write:'Birinci sayı büyüktür'.//Erkana yazdrır.
Enıf.//sona erdirir.

ıf gv_degis1 < gv_degis2.//degis2 ifadesi büyükse koşul doğrudur.
Write:'ikinci sayı büyüktür'.//Erkana yazdrır.
Endıf.//sona erdirir.
ekran çıktısı:İkinci sayı büyüktür.

#if'i sürekli yazmamak için aşağıdaki gibi yapabiliriz.
ıf gv_degis1>gv_degis2.
WRİTE:'ikinci sayı büyüktür'. 
ELSEIF gv_degis1 < gv_degis2.
WRİTE:'ikinci sayı büyüktür'.
ELSE.
WRİTE:'ikinci sayı eşittir!'.
ENDIF

-Case Kullanımı-
 case gv_degis1.
when1.
write 'Degisken değerim1.'.
when2.
write 'Degisken değerim2.'.
when others.
write'hiç bir değere eşit değil!'.
endcase.

-Do kullanımı-
Do 10 TIMES.//döngüyü 10 defa yazdırır.
gv_degis1=gv_degis1+1.//rakamları birer birer arttırır.
WRİTE: / gv_degis1,'do döngüsünü öğreniyoruz'.
ENDDO.

-While Döngüsü-
while gv_degis1<10.
gv_degis1=gv_degis1+1.
write:/gv_degis1,'While döngüsü '.
ENDWHİLE.
Ekran çıktısı=>
1 While Döngüsü
2 while döngüsü...10'a kadar


< LT. 
> GT. 
<= LE.
>= GE.
= EQ.

//Şeklinde de kullanılır.



ctrl-s kaydet ctrl-f3 ile program aktif edilir. f8 programı çalıştır.

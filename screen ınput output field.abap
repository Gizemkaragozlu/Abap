program kısmına aşağıdaki kod yazılır..

DATA: gv_ad type char20,// ad kısmını 20 karakterli.
      gv_soyad TYPE char30.// soyad kısmını 30 karaketer uzunluğunda yapmak için.

DATA: gv_rad1 type char1,// char türünde 1 karakter uzunluğunda.
      gv_rad2 type xfeld.// xfeld sınırlı seçenek sunar evet veya hayır gibi.

Screens kısımna gelip Layouta tıklayalım...
Üst kısımda DİCTİONARY tıklayalım ,
table/field name kısmına data kısmında yazdığımız örneğin gv* yapalım,
Get from program a tıklayınca DATA da yazdığımız gv_ad ve gv_soyad seçenekleri çıkar.
tıkladıktan sonrra bırakacağınız kısmı seçip tıklayın.

Ör: ad kısmını zorunlu girilmesini istiyorsan input kısmındaki seçeneklere göz at possible,not possiable gibi

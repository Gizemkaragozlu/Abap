tablo yapısındaki verileri basabilmek için bir internal table ve structure ihtiyacımız olucak.
adım 1: genel tanımlara tıkla.
adım 2: genel veriler kısmına structure ve table tanımla:
 gs_scarr type scarr
 gt_scarr type gtt_scarr // internal table datası..
adım 3: tipler kısmına
 TYPES: gtt_scarr TYPE TABLE OF scarr.//table tanımladık.
adım 4: bşl.drm.getir alanına table seçip listeletiyoruz:
select * from scarr // tüm tablo verilerini çekiyoruz..
  into table gt_scarr.
not: adım 4 de uygulanan işlemin aktif olması için giriş parametreleri tanımlanmalı.
  gt_scarr

adım 5: main ana penceremize sağ tıklayıp,table seçelim.
  table kısmında kolon ayarımızı boyutumuzu yapalım.
adım 6: başlık alanına sağ tık yap,tablo satırını seç   satır tipine table kısmında satır tipine ne veriysem aynısını vermeliyim.
    cell yeni sütun 1 olan kısma metin ekleyelim.
adım 7: table->veriler->dahili tablo gt_scarr into gs_scarr yazalım.
adım 8: ana alan kısmına gelelim sütun alanlarımıza metin ekleyelim,
 metin kısmında alan ekle butonuna tıkla oraya şunları yazalım;
Ör :&gs_scarr-carrid& // Kolon adlarımızı tanımlayalım teker teker.
Tablomuz oluştu
//////////////////////////////////////////
Program satırı için:
adım 9: table-> yeni bir satır tipi %LTYPE2 ve kolon oranları.
adım 10: sayfa altlığı kısmına gel yeni oluşturulan satır tipini çek.
sayfa altlığı->ikinci sütun metin tanımla toplam usd satırı yazdık.
toplam satırları tutmak için değişkene ihtiyaç var bu sebeple,
genel tanımlara gelip gv_ttl_usd type int4 giriyoruz.

ilgili sütuna (currcode olan yer)sağ tık yarat->akş mnt.->program satırları diyelim,
if gs_scarr-currcode eq 'USD'.
gv_ttl_usd = gv_ttl_usd + 1. //gv_ttl bir arttır.
endif.
giriş parametrelerine gs_scarr ve gt_ttl_usd tanımladık.



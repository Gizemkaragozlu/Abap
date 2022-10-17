Smartforms Döngüler:
adım 1: yeni bir pencere aç.
adım 2: yarat->akış mnt->döngü
adım 3: veriler->loop döngüsü gt_scarr into gs_scarr
adım 4: where koşulu currcode 'EUR' // currcode kolonundaki eur para birimini çek.
adım 5: alan ekle->&gs_scarr-carrname& // havayolu şirket adını çekiyoruz.
adım 6:döngümüze tablo başlığı vermek istersek oluşturduğumuz pencere altına metin açalım .
adım 7: tablo görünümü olsun diye çıktı seçeneklerine çizgi ekliyoruz.
not   : Bu işlemi para birimi eur olan havayolu şirket adlarını yazmak ve tablo şekilinde eklmek için yaptık..
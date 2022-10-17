# AraYüz #

Arayüz->Genel veriler.
GT_SCARR TYPE GTT_SCARR
//////////////////////
Tipler->
TYPES: gtt_scarr TYPE TABLE OF scarr.
//////////////////////
Kodlamanın bşl->
select * from scarr
  into table gt_scarr.
////////////////////// # Kaydet çık

# From kısmı #
Genel veriler->Tabloyu al->Bağlam kısmına taşı
Design kısmına tabloyu sürükle,
Object->Subform->Content: Flowed -> Allow Page Breaks tik işareti yapalım.
// Tablo sayfadan taşarsa diğer sayfaya gitsin diye yapıyoruz bu işlemi.

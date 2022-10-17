Arayüz:
Genel veriler: gv_header_t1 type char30 
Kodlamanın başl.drm.getirilimesi: gv_header_t1 = 'Gizlillik Politikası'.
// Bunları oluşturduktan sonra form kısmına gelelim
Bağlam->arayüz->Genel veriler->oluşturulan veri
// Tutup bağlam kısmına çekiyoruz bu işlemi arayüzde oluşturduğumuz olayları formda görmek için yapıyoruz.

Object Library panelinden Text Field seçip sürükleyelim,
Object->Binding->Data binding kısmında sağ tarafta küçük bir buton var ona tıklayalım,
arayüz kısmında sürüklediğimiz SFPSY alt sekmesinde USERNAME tıklayalım ve çalıştır anlık hangi kullanıcı girerse o gözükür.
aynı şeyler date ve time için de geçerli.
///////////////////////////////////////////
içe ektarma:
arayüz kısmından içe aktar tıkla,
iv_header type char30 // ekledik
form kısmına geldik,
text seçtik text yazısını sildik,
sağ tik -> Floating field tıkladık ve çalıştırdık.
// Ne işe yarar ?  - Programı çalıştırınca dürekt ordan yazma fırsatı verebilir.


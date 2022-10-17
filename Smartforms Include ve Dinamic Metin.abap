Dışarıdan kullanabilir ve değiştirilebilir olmasını sağlar.
so10:metin objesini oluşturduğumuz yapı
Dinamic: internal table text olarak basabildiğimiz yapı
metin özelliğini include seçtik.
s010'da oluşturduğumuz metni alıp oluşturduğumuz metnin metin anahtar kısmına yapıştıralım.
/////////////////////////////////////
penecere açtık->metin->dinamic metin seçtik.
Genel tanımlar GT_LINES type TSFTEXT oluşturduk.
               GS_LINE TYPE TLINE // tablo adımız TLINE  (önceden vardı tline).

Başl.drm.getir kısmından GT_LINES
                          GS_LINE // Tanımlandı.
clear: gs_line.
gs_line-TDFORMAT = '*'.
gs_line-TDLINE   ='Gizlilik Politikas'.
APPEND gs_line TO gt_lines.


clear: gs_line.
gs_line-TDFORMAT = '*'.
gs_line-TDLINE   ='Verilerin Saklaması'.
APPEND gs_line TO gt_lines.

Oluşturduğumuz metin sayfasına gelip alan adımızı giriyoruz &GT_LINES&


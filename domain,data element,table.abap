se11 domain data table gibi işlemler için kullanılır.
domain adı yazılır...zbk_personeldo vs gibi
short desciription pernosel adı
data type char//int,char vsvs seçenekler var.
No.characters 30//karakter uzunluğu 30 olsun.
//Aynı şekilde soyad için de yapıyoruz.

domain ZBK_PERCINS_DO
short desciription pernosel cinsiyeti//Kısa adı personel cinsiyeti
data type char //char türünde olsun
No.characters 1//Karakter uzunluğu 1 olsun

#value range bölümüne girip erkeğe e kıza k harfleri ile seçenek yapıyrouz
Fx.Val E....Kısa tanım Erkek gibi
////////////////////////////
-Data Element-
Intial Screen ekranından Data type butonunu seçip zbk_personelid_de
short description Personel Id yazalım.
domain,data type,length yazıyoruz.

Teknikal alandaki 
data class: APPL0 master table veya main table anlamına gelir.
size category:tablo boyutu.

Feld Label// kısmından kısa ve uzun adlandırmalar yapıyoruz.
///////////////////////////
Initial Screen kısmına tekrar geliyoruz...
-Table-
Database table ZBK_PERS_T//tablo oluşturuyoruz.

se16n:tablo verilerini görmek ve tablo kolonlarını incelemek.


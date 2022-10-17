#Exculuding;
ZGK_REUSE_ALV_Top:
DATA: gt_exclude TYPE SLIS_T_EXTAB,
         gs_exclude TYPE SLIS_EXTAB.
///////////////////////////////////////
ZGK_REUSE_ALV_FRM:
call function 'REUSE_ALV_GRID_DISPLAY' " Pattern yani örnek kısmından REUSE_ALV_GRID_DISPLAY yazıp Enterlıyoruz..
IT_EXCLUDING             = gt_exclude "Butonları gizlememizi sağlayan yapı...


 gs_exclude-fcode = '&UMC'.
  APPEND gs_exclude TO gt_exclude.
    gs_exclude-fcode = '&NFO'.
  APPEND gs_exclude TO gt_exclude.

#Sort:
ZGK_REUSE_ALV_TOP:
 DATA: gt_sort TYPE SLIS_T_SORTINFO_ALV ,
         gs_sort TYPE SLIS_SORTINFO_ALV.
////////////////////////////////////////

ZGK_REUSE_ALV_FRM:

 IT_SORT = gt_sort "Sıralı bir şekilde alv olması için..

 gs_sort-spos    = 1.
  gs_sort-tabname = 'GT_LIST'.
  gs_sort-fieldname = 'BSART'.
  gs_sort-down    = abap_true."Yukardan aşağıya sıralama...
  APPEND gs_sort TO gt_sort.

  gs_sort-spos    = 2.
  gs_sort-tabname = 'GT_LIST'.
  gs_sort-fieldname = 'MENGE'.
  gs_sort-up    = abap_true."Aşağıdan yukarıya doğru sıralama...
  APPEND gs_sort TO gt_sort.

#Filter:

   ZGK_REUSE_ALV_TOP:
   DATA:gt_filter TYPE SLIS_T_FILTER_ALV,
         gs_filter TYPE SLIS_FILTER_ALV.
//////////////////////////////////////////
ZGK_REUSE_ALV_FRM:
IT_FILTER = gt_filter "İstenilen şarta göre hangi kolonu getireceğimizi gösterir..
//İstediğimiz şarttaki kolonlar...
 gs_filter-tabname = 'GT_LIST'.
  gs_filter-fieldname = 'EBELP'.
  gs_filter-sign0 = 'I'."include
  gs_filter-optio = 'EQ'."sayısal değer bir aralık belirlemek için kullanılır..
  gs_filter-valuf_int = 20."20 ADET
  APPEND gs_filter to gt_filter.
  
    gs_filter-tabname = 'GT_LIST'.
  gs_filter-fieldname = 'MEINS'.
  gs_filter-sign0     = 'I'."include
  gs_filter-optio     = 'EQ'."sayısal değer bir aralık belirlemek için kullanılır..
  gs_filter-valuf_int = 'KG'."öLÇÜ BİRİMİ KG OLANLARI
  APPEND gs_filter to gt_filter.
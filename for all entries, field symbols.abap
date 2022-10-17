 #For All Entries:
 JOIN yapamıyacağımız tablolar için kullanılır. 
 Örneğin BSEG(FI Belge Kalemi Tablosu) bir cluster tablo yapısına sahip olduğundan dolayı
 bu tabloya JOIN işlemi gerçekleştirilemez.
 Bundan dolayı bu tablo ile ilgili bir işlem yapılacağında 
 bu tabloya For All Entries kuralı ile bağlanılır.
/////////////////////////////////////////////////////////////////
 #Field Symbols:
internal table tablomuzun her hangi bir rowunu her hangi bir kolonunu değiştirmede kolaylık sağlayan yapı..
Alan sembolleri, FIELD-SYMBOLS deyimi veya FIELD-SYMBOL bildirim operatörü tarafından bildirilen,
 mevcut veri nesneleri (veya mevcut veri nesnelerinin parçaları) için yer tutucular veya sembolik adlardır .
 Program çalışma zamanında bir alan sembolüne bir hafıza alanı atanır. 
Alan sembolü, bir alan için herhangi bir fiziksel alan ayırmaz, 
ancak belirli bir veri nesnesini (veya nesnenin bir bölümünü) barındıran bir bellek alanı için bir tür dinamik etikettir.
 İfadelerin işlenen konumlarında veri nesneleri yerine bir alan sembolü kullanılabilir. 
Bu tür bir deyim yürütüldüğünde,
 dahili tablolar işlenirken ASSIGN deyimi veya ASSIGNING eki tarafından alan sembolüne bir bellek alanı atanmalıdır .

ÖRNEK:

DATA: gt_scarr type TABLE OF scarr,
      gs_scarr TYPE scarr.

FIELD-SYMBOLS: <gfs_scarr> TYPE scarr.

START-OF-SELECTION.

select * FROM scarr
  INTO TABLE gt_scarr.
*
*  LOOP AT gt_scarr INTO gs_scarr.
*    IF gs_scarr-currcode eq 'LH'.
*      gs_scarr-carrname = 'Gizem Karagözlü'.
*      MODIFY gt_scarr FROM gs_scarr.
*    ENDIF.
*  ENDLOOP.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    IF <gfs_scarr>-carrid eq 'LH'.
      <gfs_scarr>-carrname = 'Gizem Karagözlü'.

    ENDIF.

  ENDLOOP.

  BREAK-POINT.
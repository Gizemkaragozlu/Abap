*Form ve İnclude*
//karmaşadan kurtulmak için include oluşturup performların adına göre kodlarmızı yerleştiriyoruz...
REPORT ZGK_REUSE_ALV.//From ve include kullanımı...

INCLUDE ZGK_REUSE_ALV_top.
INCLUDE ZGK_REUSE_ALV_frm.



START-OF-SELECTION.
PERFORM get_data.//üstüne çift tıkla...
PERFORM set_fc.
PERFORM set_layout.
PERFORM display_alv

#Pratik Fieldcatalog#

"Katalog yapımızı bu şekilde kısa biçimde yazabiliriz...
  PERFORM set_fc_sap USING 'ebeln' 'sas no' 'sas numarası' 'sas numarası' abap_true '0' .
  PERFORM set_fc_sap USING 'ebelp' 'kalem'   'kalem'       'kalem'        abap_true '1' .
  PERFORM set_fc_sap USING 'BSTYP' 'belge tip' 'belge tipi' 'belge tipi'  abap_true '2' .
  PERFORM set_fc_sap USING 'BSART' 'belge tür' 'belge türü' 'belge türü'  abap_true '3' .
  PERFORM set_fc_sap USING 'matnr' 'malzeme' 'malzeme' 'malzeme'          abap_true '4' .
  PERFORM set_fc_sap USING 'menge' 'miktar' 'miktar' 'miktar'             abap_true '5' .

#Fieldcatalog Merge#
form set_fc .

  call function 'REUSE_ALV_FIELDCATALOG_MERGE'
        EXPORTING
        I_PROGRAM_NAME               = sy-repid"programı çağırır ZGK_REUSE_ALV_FRM bunu yazmak yerine sy_repid tercih edilir...
*        I_INTERNAL_TABNAME           = 'GT_LIST'// tanımlamaları büyük harf ile yazmak mantıklı key sensitivity kralına uyulmalı...
        I_STRUCTURE_NAME             = 'ZGK_REUSE_ALV_S'"Structure tablamuzu ekledik...
        I_INCLNAME                   = sy-repid

       changing
         ct_fieldcat                  = gt_fieldcatalog.
         .
     if sy-subrc <> 0.
* Implement suitable error handling here
     endif.

#ZGK_REUSE_ALV_TOP#
*DATA: BEGIN OF gt_list OCCurs 0,//İneternal table...
*
*  ebeln Like ekko-ebeln, // Like benzeyen yapıları getirir...
*  ebelp Like ekpo-ebelp,
*  BSTYP Like ekko-BSTYP,
*  BSART Like ekko-bSART,
*  matnr Like ekpo-matnr,
*  menge Like ekpo-menge,
*  END OF gt_list.


TYPES: BEGIN OF gty_list,
  ebeln TYPE ebeln,
  ebelp TYPE ebelp,
  BSTYP TYPE EBSTYP,
  BSART TYPE bSART,
  matnr TYPE matnr,
  menge TYPE bstmg,
  END OF gty_list.
   DATA: gty_list TYPE TABLE OF gty_list,
         gs_list TYPE gty_list.

   DATA:gt_fieldcatalog TYPE slis_t_fieldcat_alv,
         gs_fieldcatalog TYPE slis_fieldcat_alv.

   DATA: gs_layout TYPE  SLIS_LAYOUT_ALV.

se11 ile structure oluşturduk


*&---------------------------------------------------------------------*
*& Report ZGK_SERCH_HELP_FUNCTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zgk_serch_help_function.

// "serch help function ekrandaki parametrelerden birine basınca diğer verileri getirir..

types: begin of gty_list,
         depo_kod   type zgk_depokodu_dt,
         fabrika_ad type zgk_firmaad_dt,
         malzeme_no type zgk_malzemeno_dt,
  END OF gty_list.

parameters: p_depok type  CHAR30,
            p_fabad type  CHAR30,
            p_mno   type  CHAR30.

data: gt_list       type table of gty_list,
      gt_return_tab type table of ddshretval,
      gt_mapping    type  table of dselc,
      gs_mapping    type dselc.

at selection-screen on value-request for p_depok. " p_depok için ekran içerisinde yardım ekranı çağırıldığında olan işlemler..

  select * from zgk_depo_t 
    into corresponding fields of table gt_list. " corresponding fields of tabloları eşle..

    gs_mapping-fldname = 'F0001'.
    gs_mapping-dyfldname = 'P_DEPOK'.
    APPEND gs_mapping to gt_mapping.

    gs_mapping-fldname = 'F0002'.
    gs_mapping-dyfldname = 'P_FABAD'.
    APPEND gs_mapping to gt_mapping.

    gs_mapping-fldname = 'F0003'.
    gs_mapping-dyfldname = 'P_MNO'.
    APPEND gs_mapping to gt_mapping.




  call function 'F4IF_INT_TABLE_VALUE_REQUEST'
    exporting
      retfield        = 'P_DEPOK'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'P_DEPOK'
      value_org       = 'S'
    tables
      value_tab       = gt_list       "Görünesini isteğim kısım.
      return_tab      = gt_return_tab "Yapılan seçimi gösterecek kısım.
     dynpfld_mapping  = gt_mapping    "Çoklu dataların görünmesini sağlayan kısım.
    exceptions
      parameter_error = 1
      no_values_found = 2
      others          = 3.
start-of-selection.
img butonunu seç sürükle 

se78 bmap ad yaz kaydet
Arayüz->Genel veriler-> GV_LOGO TYPE XSTRING

Kodlama başl->


cl_ssf_xsf_utilities=>get_bds_graphic_as_bmp(
  exporting
    p_object       = 'GRAPHICS'
    p_name         = 'LOGO_AIR'
    p_id           = 'BMAP'
    p_btype        = 'BCOL'
  receiving
    p_bmp          = gv_logo
  exceptions
    not_found      = 1
    internal_error = 2
    others         = 3
).
if sy-subrc <> 0.
  message id sy-msgid type sy-msgty number sy-msgno
    with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
endif.
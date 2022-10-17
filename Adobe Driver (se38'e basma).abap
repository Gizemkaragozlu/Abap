*&---------------------------------------------------------------------*
*& Report ZGK_FOR_VBK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
Report ZGK_FOR_VBK.


  data:gs_outputparams type  sfpoutputparams,
       gv_name         type  fpname,
       gv_funcname     type  funcname,
       gs_docparams    type  sfpdocparams,
       gs_formoutput   type  fpformoutput.
  start-of-selection.

  call function 'FP_JOB_OPEN' "çift tıkladık gs_outputparams type  sfpoutputparams bunu aldık.
    changing
      ie_outputparams = gs_outputparams
    exceptions
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      others          = 5.

  gv_name = 'ZGK_DENEME'.

  call function 'FP_FUNCTION_MODULE_NAME' "çift tıkladık gv_name type fpname,  gv_funcname type funcname,aldık.
    exporting
      i_name     = gv_name
    importing
      e_funcname = gv_funcname
*     E_INTERFACE_TYPE           =
*     EV_FUNCNAME_INBOUND        =
    .

  call function gv_funcname "gv_funcname yerine /1BCDWB/SM00000150 adobe çıktı id miz yazıyordu.
  "çift tıkladık gs_docparams type  sfpdocparams, gs_formoutput type fpformoutput. aldık
    exporting
      /1bcdwb/docparams  = gs_docparams
    importing
      /1bcdwb/formoutput = gs_formoutput
    exceptions
      usage_error        = 1
      system_error       = 2
      internal_error     = 3
      others             = 4.
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.

  call function 'FP_JOB_CLOSE' "bunu yazmazsak çıktımızı göremeyiz..
   EXCEPTIONS
     USAGE_ERROR          = 1
     SYSTEM_ERROR         = 2
     INTERNAL_ERROR       = 3
     OTHERS               = 4
            .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.
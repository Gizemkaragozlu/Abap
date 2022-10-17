Örnek Program Bulma:*dropdown* // iki yıldız arasında istenilen key yazılır.


DATA: gv_id TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value TYPE vrm_value.


gv_id = 'GV_YAS'.

gs_value-key = '1'.
gs_value-text = '18 Yaş'.
APPEND gs_value TO gt_values.

call function 'VRM_SET_VALUES'//üst tarafta örnek kısmına tklayıp vem_set_values yazınca aşağıdaki otomatik olarak yazılır.
    exporting
      id                    = gv_id
      values                = gt_values.

DATA: gv_ind TYPE i.

START-OF-SELECTION.


DO 60 TIMES.// dropdown 18 den başlayarak 60'a kadar seçenek sunar.
gs_value-key = gv_ind.
gs_value-text = gv_ind.
APPEND gs_value TO gt_values.
gv_ind = gv_ind + 1.
ENDDO.


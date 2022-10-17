Debug:
se38 ile program oluşturduk.
debug yapmak için \h yapıp enter yapıyoruz.
Desktop 3 ile devam ediyoruz.


Data: gv_index type i.
      gv_mod2 type i,
      gv_mod3 type i.
start of selectıon.
gv_index = 0.
do 10 tımes.
ıf gv_index mod 2 eq 0.// 2 ye bölmünden kalan 0 dır yazar.
   gv_mod2 = gv_mod2 + 1.
enıf.
gv_index = gv_index + 1.
enddo.

ıf gv_index mod 3 eq 0.
   gv_mod2 = gv_mod2 + 1.
enıf.
gv_index = gv_index + 1.
enddo.

Write:/'2 ye bölünen sayı adedi=', gv_mod2.
Write:/'3 ye bölünen sayı adedi=', gv_mod3.
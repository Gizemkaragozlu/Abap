Message Type:Valid message types are "A", "E", "I", "S", "W", and "X". These stand for termination (abort) message, error message, information message, status message, warning, and exit message.
START-OF-SELECTION.
MESSAGE 'Gizmo' TYPE 'S'.
MESSAGE 'Gizmo' TYPE 'I'.
MESSAGE 'Gizmo' TYPE 'W'.
MESSAGE 'Gizmo' TYPE 'E'.
MESSAGE 'Gizmo' TYPE 'A'.
MESSAGE 'Gizmo' TYPE 'X'.

MESSAGE 'gizmo' type 's' dısplay lıke 'x'.//bu yapı ekranda yazar ve alt kısımda uyarı sembolüyle birlikte gözükür.

// üst sekmede goto kısından text elements seçilir ve yazmak istenilen yazılır.

MESSAGE text-000 type 'I'.//Text Sybol,text elements kısmında 000 yazdığımız için o kodda yazılan çıkar.

se91: message class oluşturulur ve her yerde kullanılır.

MESSAGE i000(zgk_message_class).
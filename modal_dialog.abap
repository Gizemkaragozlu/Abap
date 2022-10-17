START-OF-SELECTION.
call SCREEN 0100 STARTING AT 10 10
                 ENDING AT 50 20.



module user_command_0100 input.
CASE sy-ucomm.
  WHEN '&CANCEL' .
    LEAVE TO SCREEN 0.
ENDCASE.

endmodule.
//cancel aktif eder...
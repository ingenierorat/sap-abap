*&---------------------------------------------------------------------*
*& Report Z_RECORRER_LA_PANTALLA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_recorrer_la_pantalla.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001. " Bloque b1.

  PARAMETERS: p_file TYPE string DEFAULT 'C\prueba.txt'. " Ruta del archivo.

SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN OUTPUT. " Evento de la pantalla.

  LOOP AT SCREEN INTO DATA(ls_screen). " Recorrer todos los objetos de la pantalla.

    IF ls_screen-name = 'P_FILE'.

      ls_screen-input = 0. " Lo pone de solo lectura.
      MODIFY SCREEN FROM ls_screen. " Realiza el cambio.

    ENDIF.

  ENDLOOP.
*&---------------------------------------------------------------------*
*& Include          ZMANEJO_ARCHIVO_RTORRES_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-000.

  SELECTION-SCREEN SKIP.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

    PARAMETERS: gp_delim TYPE c LENGTH 1, " Delimitador.
                gv_anali TYPE zclientes_asc-zanalista. " Analista.

  SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN END OF BLOCK b0.
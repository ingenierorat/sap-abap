*&---------------------------------------------------------------------*
*& Report ZLEER_TCON_CAB_TYPE_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zleer_tcon_cab_type_rtorres.

TYPES: BEGIN OF sty_spfli, "Estructura de la tabla
         carrid TYPE spfli-carrid,
         connid TYPE spfli-connid,
       END OF sty_spfli.

DATA it_spfli TYPE STANDARD TABLE OF sty_spfli WITH HEADER LINE. "Declraración de la tabla interna con cabecera.

SELECT carrid connid "Select a la tabla spfli para llenar la tabla interna.
  FROM spfli
  INTO TABLE it_spfli
  UP TO 5 ROWS.

LOOP AT it_spfli.
  WRITE: / it_spfli-carrid,
           it_spfli-connid.
ENDLOOP.
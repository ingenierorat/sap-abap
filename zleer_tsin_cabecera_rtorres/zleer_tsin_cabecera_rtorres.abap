*&---------------------------------------------------------------------*
*& Report ZLEER_TSIN_CABECERA_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zleer_tsin_cabecera_rtorres.

TYPES: BEGIN OF sty_spfli, "Estructura de la tabla
         carrid LIKE spfli-carrid,
         connid LIKE spfli-connid,
       END OF sty_spfli.

DATA: it_spfli TYPE STANDARD TABLE OF sty_spfli, "Tabla interna y area de trabajo
      wa_spfli TYPE sty_spfli.

SELECT carrid connid "Select para recorrer la tabla estandar spfli
  FROM spfli
  INTO TABLE it_spfli
  UP TO 5 ROWS.

LOOP AT it_spfli INTO wa_spfli. "Leer todos los registro encontrados
  WRITE: / wa_spfli-carrid,
           wa_spfli-connid.
ENDLOOP.
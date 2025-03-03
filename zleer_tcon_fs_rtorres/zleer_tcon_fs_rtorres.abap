*&---------------------------------------------------------------------*
*& Report ZLEER_TCON_FS_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zleer_tcon_fs_rtorres.

TYPES: BEGIN OF sty_spfli, "Estructura de la tabla
         carrid TYPE spfli-carrid,
         connid TYPE spfli-connid,
       END OF sty_spfli.


DATA: it_spfli TYPE STANDARD TABLE OF sty_spfli. "Declaración de la tabla interna sin cabecera.

FIELD-SYMBOLS: <fs_spfli> LIKE LINE OF it_spfli. "Declaración del Field Symbols para lees los datos.

SELECT carrid connid "Select a la tabla interna spfli para llenar la tabla interna.
  FROM spfli
  INTO TABLE it_spfli
  UP TO 5 ROWS.

LOOP AT it_spfli ASSIGNING <fs_spfli>. "Recorrer la tabla interna.
  WRITE: / <fs_spfli>-carrid,
           <fs_spfli>-connid.
ENDLOOP.
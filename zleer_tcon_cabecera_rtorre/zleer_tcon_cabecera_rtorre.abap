*&---------------------------------------------------------------------*
*& Report ZLEER_TCON_CABECERA_RTORRE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zleer_tcon_cabecera_rtorre.


DATA: BEGIN OF it_spfli OCCURS 0, "Estructura de datos con cabecera
        carrid    type spfli-carrid,
        connid    type spfli-connid,
        cityfrom  type spfli-cityfrom,
        cityto   type spfli-cityto,
      END OF it_spfli.


SELECT carrid connid cityfrom cityto
  FROM spfli
  INTO TABLE it_spfli
  UP TO 5 ROWS.


  LOOP AT it_spfli.
    WRITE: / it_spfli-carrid,
             it_spfli-connid,
             it_spfli-cityfrom,
             it_spfli-cityto.
  ENDLOOP.
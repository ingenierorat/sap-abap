*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: BEGIN OF st_spfli OCCURS 0,
        carrid TYPE s_carr_id,
        connid TYPE s_conn_id,
      END OF st_spfli.

SELECT carrid connid
  FROM spfli
  INTO TABLE st_spfli
  WHERE carrid = 'LH'.


WRITE:/10(45) 'El total de vuelos de este dia',
      /10(45) 'El numero de vuelos registrados'.

NEW-LINE.

SKIP 2.

WRITE:/10 'Los vuelos registrados satisfechos'.
WRITE:/10 sy-uline(70).

WRITE:/10 sy-vline,
      (13) 'Airline Code' COLOR COL_HEADING,sy-vline,
      (50) 'Flight Connection Number' COLOR COL_HEADING,sy-vline.

WRITE:/10 sy-uline(70).


LOOP AT st_spfli.

  WRITE:/10 sy-vline,
        (13) st_spfli-carrid, sy-vline,
        (50) st_spfli-connid, sy-vline.

ENDLOOP.

WRITE:10 sy-uline(70).
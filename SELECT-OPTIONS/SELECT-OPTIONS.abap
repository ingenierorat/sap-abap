*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.


TABLES spfli. "Declaración de la tabla

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001. "Bloque

  SELECT-OPTIONS: p_carr FOR spfli-carrid. " Parametro de selección

SELECTION-SCREEN END OF BLOCK b1. " Fin


DATA:BEGIN OF st_spfli OCCURS 0,
       carrid TYPE s_carr_id,
       connid TYPE s_conn_id,
     END OF st_spfli.

SELECT carrid connid
  FROM spfli
  INTO TABLE st_spfli
  WHERE carrid IN p_carr.

SKIP 1.


WRITE:/10(20) 'Airline Code' COLOR COL_HEADING,
         (30) 'Flight Connection Number' COLOR COL_HEADING.


LOOP AT st_spfli.
  WRITE:/10(20)   st_spfli-carrid,
           (30)   st_spfli-connid.
ENDLOOP.
*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres
       NO STANDARD PAGE HEADING
       LINE-SIZE 75.

DATA: it_spfli    TYPE STANDARD TABLE OF spfli,
      spfli_line  TYPE p,
      spfli_line2 TYPE p.

SELECT *
  FROM spfli
  INTO TABLE it_spfli.

IF sy-subrc EQ 0.
  DESCRIBE TABLE it_spfli LINES spfli_line.
  spfli_line2 = sy-dbcnt.
ENDIF.

*FORMAT COLOR COL_POSITIVE.

WRITE: /5(20) 'Usando DESCRIBE TABLE' COLOR COL_KEY INTENSIFIED on, spfli_line COLOR COL_POSITIVE INTENSIFIED on,
       /5(20) 'Usando sy-dbcnt' COLOR COL_KEY INTENSIFIED on, spfli_line2 COLOR COL_POSITIVE INTENSIFIED on.
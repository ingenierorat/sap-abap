*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres
       NO STANDARD PAGE HEADING
       LINE-SIZE 57.

DATA it_spfli TYPE STANDARD TABLE OF spfli WITH HEADER LINE.

SELECT *
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE it_spfli.

FORMAT COLOR COL_HEADING.
WRITE:/(12)  'CARRID',
       (12)  'CONNID',
       (25)  'CITYFROM'.
ULINE.
FORMAT COLOR OFF.

LOOP AT it_spfli.
  WRITE:/(12) it_spfli-carrid   COLOR COL_KEY INTENSIFIED ON, sy-vline,
         (12) it_spfli-connid   COLOR COL_KEY INTENSIFIED ON, sy-vline,
         (25) it_spfli-cityfrom COLOR COL_NORMAL, sy-vline.
ENDLOOP.
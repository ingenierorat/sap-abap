*&---------------------------------------------------------------------*
*& Report ZVARIANTE_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zvariante_rtorres.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS p_id TYPE c LENGTH 4.

SELECTION-SCREEN END OF BLOCK b1.

DATA it_spfli TYPE spfli OCCURS 0 WITH HEADER LINE.

SELECT * FROM spfli INTO TABLE it_spfli WHERE connid eq p_id.

LOOP AT it_spfli.

  WRITE: / it_spfli-connid.

ENDLOOP.
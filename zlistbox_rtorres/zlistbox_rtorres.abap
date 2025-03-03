*&---------------------------------------------------------------------*
*& Report ZLISTBOX_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlistbox_rtorres.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS p_carrid TYPE spfli-carrid AS LISTBOX VISIBLE LENGTH 20 DEFAULT 'LH'.

SELECTION-SCREEN END OF BLOCK b1.
*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.


SELECTION-SCREEN BEGIN OF SCREEN 101 AS SUBSCREEN.

  PARAMETERS campo1(15) TYPE c.

SELECTION-SCREEN END OF SCREEN 101.

SELECTION-SCREEN BEGIN OF SCREEN 102 as SUBSCREEN.

  PARAMETERS campo2(15) type c.

  SELECTION-SCREEN END OF SCREEN 102.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECTION-SCREEN BEGIN OF TABBED BLOCK seccion FOR 8 LINES.

    SELECTION-SCREEN TAB (15) name1 USER-COMMAND ucomm1 DEFAULT SCREEN 101.
    SELECTION-SCREEN tab (15) name2 USER-COMMAND ucomm2 DEFAULT SCREEN 102.

  SELECTION-SCREEN END OF BLOCK seccion.

SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
name1 = 'Primera solapa'.
name2 = 'Segunda solapa'.
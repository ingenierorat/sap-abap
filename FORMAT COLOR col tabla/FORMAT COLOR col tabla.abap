*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA col TYPE i VALUE 0.

DO 8 TIMES.

  col = sy-index - 1.

  FORMAT COLOR = col.
  WRITE : / col               COLOR OFF,
            'INTENSIFIED ON'  INTENSIFIED ON,
            'INTENSIFIED OFF' INTENSIFIED OFF,
            'INVERSE ON'      INVERSE ON.
ENDDO.

FORMAT COLOR OFF.

WRITE / 'Fin'.
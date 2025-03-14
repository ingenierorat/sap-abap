*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.


DATA: lv_name         TYPE string VALUE '  Juan Pérez García',
      lv_trimmed_name TYPE string.

" Eliminar espacios en blanco a la izquierda
lv_trimmed_name = lv_name.

CONDENSE lv_trimmed_name NO-GAPS.

WRITE: / lv_trimmed_name.
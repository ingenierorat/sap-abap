*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: lv_name TYPE string VALUE 'Juan Pérez García   ',
      lv_trimmed_name TYPE string.

" Eliminar espacios en blanco a la derecha
lv_trimmed_name = lv_name.
SHIFT lv_trimmed_name RIGHT DELETING TRAILING space.

WRITE: / lv_trimmed_name.
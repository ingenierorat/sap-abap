*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: lt_return type STANDARD TABLE OF bapiret2 WITH EMPTY KEY, " La línea WITH EMPTY KEY en ABAP significa que la tabla interna no tiene clave primaria definida.
      ls_return type bapiret2.
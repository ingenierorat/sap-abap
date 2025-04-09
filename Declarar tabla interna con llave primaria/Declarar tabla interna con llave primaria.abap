*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

TYPES: lt_mara TYPE SORTED TABLE OF mara WITH UNIQUE KEY matnr, " Si sí necesitas clave, puedes especificarla:
       ls_mara type mara.
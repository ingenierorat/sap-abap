*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres       

DATA lv_cartel(50) TYPE c VALUE 'El        valor de la carta es:'.

CONDENSE lv_cartel.

WRITE:/2(45) lv_cartel.
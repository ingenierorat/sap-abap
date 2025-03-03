*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: str(20)      TYPE c VALUE '00025421', " Numero inicial
      strresul(20) TYPE c. " Volcar el resultado aqui

CONCATENATE str+0(6) '.' str+6(2) INTO strresul. " Divide un numero en decimal

WRITE / strresul.
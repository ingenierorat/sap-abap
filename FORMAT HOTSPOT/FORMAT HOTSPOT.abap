*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

* Variables a utilizar.
DATA: lv_line(30) TYPE c,
      lv_str(20)  TYPE c VALUE 'Clck me'.

* Inicia la darle a ejecutar.
START-OF-SELECTION.

  FORMAT HOTSPOT. " Inicia el formato.
  WRITE lv_str COLOR 5.
  FORMAT HOTSPOT OFF. " Cierra el formato.

* Evento se dispara cuando pulsamos un click en el área.
AT LINE-SELECTION.
  GET CURSOR LINE lv_line. " Obtenemos el numero de la linea pulsada.
  READ LINE lv_line FIELD VALUE lv_str. " Leemos la linea
  WRITE:/ 'El valor seleccionado es: ', lv_str. " Se imprime la linea.
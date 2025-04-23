*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

* Varaible necesaria.
DATA: lv_autoid   TYPE i,
      ls_empleado TYPE zempleados. " Tabla en BD.

DO 5 TIMES.

* Función que hara el trabajo.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01' " Rango definido en la SNRO.
      object      = 'ZAUTOID' " Rango creado, el dominio necesario.
    IMPORTING
      number      = lv_autoid " Valor devuelto por la función.
    EXCEPTIONS
      OTHERS      = 1.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  ls_empleado-id_auto = lv_autoid. " El ID que se incrementara.
  ls_empleado-nombre = |Nombre aqui, mas ID { lv_autoid }|. " Nombre.

  INSERT zempleados FROM ls_empleado. " Inserta en DB el registro.

ENDDO.

IF sy-subrc = 0.
  WRITE:/ 'Registros insertados con exito'.
ENDIF.
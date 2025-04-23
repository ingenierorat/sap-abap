REPORT ztest_rtorres.

* Variable necesaria.
DATA: lv_autoid TYPE i.

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

WRITE: / 'El valor actual es: ', lv_autoid. " Volcar en pantalla el valor actual den rango.
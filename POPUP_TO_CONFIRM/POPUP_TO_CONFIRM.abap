*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: lv_result TYPE c.

CALL FUNCTION 'POPUP_TO_CONFIRM'
  EXPORTING
    titlebar              = 'Confirmación'
    text_question         = '¿Deseas continuar con la operación?'
    text_button_1         = 'Si'
    text_button_2         = 'No'
    default_button        = '1'
    display_cancel_button = 'X'
  IMPORTING
    answer                = lv_result
  EXCEPTIONS
    text_not_found        = 1
    OTHERS                = 2.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CASE lv_result .

  WHEN '1' .
    MESSAGE i002(sy) WITH 'Elegiste continuar'.
  WHEN '2' .
    MESSAGE i002(sy) WITH 'Elegiste no continuar'.
  WHEN 'A'.
    MESSAGE i002(sy) WITH 'Operación cancelada por el usuario'.

ENDCASE.
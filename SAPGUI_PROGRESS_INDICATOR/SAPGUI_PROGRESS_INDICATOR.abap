
***Todo esto va debtro de un Loop.

* Variables locales de progreso y de texto a utilizar.
  DATA: lv_progress TYPE p,
        lv_text(30) TYPE c.
        

* Obtener la cantidad que registro que tiene la tabla.
  DESCRIBE TABLE git_mara LINES lv_line.


*   Asignar los valores a las variables.
    lv_progress = ( sy-tabix / lv_line ) * 100.
    lv_text = |Procesando { lv_progress }%...|.

*   Actuaizar indicador de progreso.
    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        percentage = lv_progress
        text       = lv_text.


* Reestablecer el indicador de progreso.
  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      percentage = 0
      text       = ''.
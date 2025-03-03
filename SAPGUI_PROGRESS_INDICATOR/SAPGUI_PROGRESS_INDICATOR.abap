*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: lv_progress TYPE i,
      lv_text(30) TYPE c.

DO 100 TIMES.

  lv_progress = sy-index.
  lv_text = |Procesando { lv_progress }%...|.

  " Actualizar indicador de progreso.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      percentage = lv_progress
      text       = lv_text.

  " Simular un proceso largo
  WAIT UP TO 2 SECONDS.

ENDDO.

" Reestable cer el idicador de proceso.
CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
  EXPORTING
    percentage = 0
    text       = ''.
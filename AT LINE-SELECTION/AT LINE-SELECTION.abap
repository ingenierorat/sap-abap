*&---------------------------------------------------------------------*
*& Report ZTEST_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_rtorres.

DATA: it_mara TYPE TABLE OF mara,
      wa_mara TYPE mara,
      lv_line TYPE mara-matnr.

START-OF-SELECTION.
  SELECT *
    FROM mara
    INTO TABLE it_mara
    UP TO 10 ROWS.

  LOOP AT it_mara INTO wa_mara.
    WRITE: / wa_mara-matnr.
  ENDLOOP.

AT LINE-SELECTION.
  GET CURSOR LINE lv_line.
  READ LINE lv_line FIELD VALUE wa_mara-matnr.
  IF sy-subrc EQ 0.
    WRITE: / 'Linea seleccionada', wa_mara-matnr.
  ENDIF.
*&---------------------------------------------------------------------*
*&  Include           ZCONTROL_COMPUTER_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  ENTRADA_PC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM entrada_pc .

  gwa_computer-zcodigo = pa_cod.
  gwa_computer-zdescripcion = pa_desc.
  gwa_computer-zfecha = pa_fecha.
  gwa_computer-znpersona = pa_npers.
  gwa_computer-zcentro = pa_centr.
  gwa_computer-zhorae = sy-uzeit.


  INSERT zcomputer FROM gwa_computer.

  IF sy-subrc EQ 0.
    MESSAGE i009(zusert1).
  ELSE.
    MESSAGE i010(zusert1).

  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  READ_PC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM read_pc .
  LOOP AT git_computer INTO gwa_computer.

    WRITE: / 'Còdigo: ',       gwa_computer-zcodigo,
            / 'Descripciòn: ', gwa_computer-zdescripcion,
            / 'Centro: ',      gwa_computer-zcentro,
            / 'Nombre: ',      gwa_computer-znpersona,
            / 'Fecha: ',       gwa_computer-zfecha,
            / 'Hora entrada: ',gwa_computer-zhorae,
            / 'Hora salida: ', gwa_computer-zhoras.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CARGAR_DATOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM cargar_datos .
  SELECT *
  FROM zcomputer
  INTO TABLE git_computer
  WHERE zcodigo EQ pa_cod.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UPDATE_PC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update_pc .

  IF sy-subrc EQ 0. " Preguntar si se cargo el registro al inical la aplicaciòn

    SELECT SINGLE * " Hacer el query a la tabla transparente
      FROM  zcomputer
      INTO  gwa_computer
      WHERE zcodigo = pa_cod.

    IF sy-subrc EQ 0. " Si la llamada al query trae resultados, asignar registros
      gwa_computer-zdescripcion = pa_desc.
      gwa_computer-zcentro = pa_centr.

      UPDATE zcomputer FROM gwa_computer. " Actualizar la tabla con los nuevos cambios

      IF sy-subrc EQ 0.
        MESSAGE i006(zusert1).
      ELSE.
        MESSAGE i008(zusert1).
      ENDIF.

    ENDIF.
  ELSE.
    MESSAGE i007(zusert1).
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SALIDA_PC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM salida_pc .
  IF sy-subrc EQ 0.

    gwa_computer-zhoras = sy-uzeit.

    UPDATE zcomputer from gwa_computer.

    IF sy-subrc eq 0.
      MESSAGE i011(zusert1).
      else.
        MESSAGE i012(zusert1).
    ENDIF.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CARGAR_WA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM cargar_wa .

  SELECT SINGLE *
    FROM zcomputer
    INTO gwa_computer
    WHERE zcodigo = pa_cod.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DELETE_PC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM delete_pc .

IF sy-subrc eq 0.

  DELETE zcomputer from gwa_computer.
  IF sy-subrc eq 0.

    MESSAGE i013(zusert1).
    else.
      MESSAGE i014(zusert1).
  ENDIF.
else.
  MESSAGE i015(zusert1).
ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Report Z_TABLA_INTERNA_UPDATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_tabla_interna_update.

DATA: git_sociedades TYPE STANDARD TABLE OF t001,
      gwa_sociedades TYPE t001.


START-OF-SELECTION. " Evento de inicio

* Conuslta a tabla
  SELECT *
    FROM t001
    INTO TABLE git_sociedades
    UP TO 20 ROWS
    WHERE bukrs NE space.

  IF sy-subrc EQ 0. " Validar si trajo algun error la consulta

    LOOP AT git_sociedades INTO gwa_sociedades. " Recorrer la tabla interna y hacer el cambio a la columna waers

      gwa_sociedades-waers = 'USD'. " modifica a la moneda USD
      MODIFY git_sociedades FROM gwa_sociedades. " Instruccion que modifica la tabla interna

    ENDLOOP.

* Recorrer la tabla con el nuevo campos actualizados
    LOOP AT git_sociedades INTO gwa_sociedades.
      WRITE: / gwa_sociedades-butxt,
               gwa_sociedades-waers.
    ENDLOOP.


  ENDIF.